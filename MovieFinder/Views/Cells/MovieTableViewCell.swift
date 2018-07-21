//
//  MovieTableViewCell.swift
//  MovieFinder
//
//  Created by Arshad T P on 7/15/18.
//  Copyright © 2018 Ab'initio. All rights reserved.
//

import UIKit

protocol MovieTableViewCellDisplayable {
	
	var imageURL: URL? {get}
	var name: String? {get}
	var releaseDate: String? {get}
	var summary: String? {get}
}

class MovieTableViewCell: UITableViewCell {

	private var viewModel: MovieTableViewCellDisplayable!
	// ----------------------
	// MARK: - Outlets
	// ----------------------

	@IBOutlet weak var posterImageView: UIImageView!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var dateLabel: UILabel!
	@IBOutlet weak var summaryLabel: UILabel!

  override func prepareForReuse() {
		// Cancelling prevoius cell image download to avoid showing unwanted image
    self.posterImageView.sd_cancelCurrentImageLoad()
  }
	
	
  /// Method to cancel image download
  func cancelImageDownLoad()  {
    if self.posterImageView != nil {
      self.posterImageView.sd_cancelCurrentImageLoad()
    }
  }
  
	func loadData(_ viewModel: MovieTableViewCellDisplayable)  {
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
