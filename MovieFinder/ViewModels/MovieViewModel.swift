//
//  MovieViewModel.swift
//  MovieFinder
//
//  Created by Arshad T P on 7/15/18.
//  Copyright © 2018 Ab'initio. All rights reserved.
//

import Foundation
import SDWebImage

final class MovieViewModel {
	
	lazy var imageBaseURL:URL = {
		
		guard let url = URL.init(string: URLConstant.movieImageBaseURL + MovieImageSize.large) else {
			fatalError("Please configure image base URL")
		}
		return url
	}()
	
	var imageURL: URL?
	var name: String?
	var releaseDate: String?
	var summary: String?
	
	init(from movie: MovieModel) {
		name = movie.title
		summary = movie.overview
		releaseDate = movie.relaseDateString
		if let imagePath = movie.posterPath {
			imageURL = imageBaseURL.appendingPathComponent(imagePath)
			debugPrint(imageURL)
		}
	
	}
}
