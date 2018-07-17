//
//  MovieTableViewCell.swift
//  MovieFinder
//
//  Created by Arshad T P on 7/15/18.
//  Copyright © 2018 Ab'initio. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

	private var viewModel: MovieViewModel!
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
		
		DispatchQueue.main.async { [weak self] in
			if let url = viewModel.imageURL {
				self?.posterImageView.sd_setImage(with: url, completed: nil)
			}
			else {
				self?.posterImageView.image = UIImage()
			}
		}
	}

}
