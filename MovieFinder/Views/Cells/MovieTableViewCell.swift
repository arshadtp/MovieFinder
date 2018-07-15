//
//  MovieTableViewCell.swift
//  MovieFinder
//
//  Created by Arshad T P on 7/15/18.
//  Copyright © 2018 Ab'initio. All rights reserved.
//

import UIKit

protocol MovieTableViewCellDelegate: class {
	func contentDidChange(cell: MovieTableViewCell)
}

class MovieTableViewCell: UITableViewCell {

	private var viewModel: MovieViewModel!
	weak var delegate:MovieTableViewCellDelegate?
	// ----------------------
	// MARK: - Outlets
	// ----------------------

	@IBOutlet weak var posterImageView: UIImageView!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var dateLabel: UILabel!
	@IBOutlet weak var summaryLabel: UILabel!
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
//	override func prepareForReuse() {
//		posterImageView.image = nil
//	}
	
	func loadData(_ viewModel: MovieViewModel)  {
		
		nameLabel.text = viewModel.name
		summaryLabel.text = viewModel.summary
		dateLabel.text = viewModel.releaseDate
		
		if let url = viewModel.imageURL {
			DispatchQueue.global().async { [weak self] in
				let data = try? Data(contentsOf: url) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
				DispatchQueue.main.async {
					if let weakSelf = self {
						if data != nil {
							weakSelf.posterImageView.image = UIImage(data:data!)
						}else{
//							weakSelf.posterImageView.image = UIImage()
						}
						weakSelf.delegate?.contentDidChange(cell: weakSelf)
					}
				}
			}
		}
	}

}
