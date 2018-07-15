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
	
	func loadData(_ viewModel: MovieViewModel)  {
		
		nameLabel.text = viewModel.name
		summaryLabel.text = viewModel.summary
		dateLabel.text = viewModel.releaseDate
		
		if let url = viewModel.imageURL {
			posterImageView.sd_setImage(with: url, completed: nil)
		}
		else {
			posterImageView.image = UIImage()
		}
	}

}
