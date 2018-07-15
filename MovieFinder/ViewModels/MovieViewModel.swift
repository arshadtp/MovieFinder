//
//  MovieViewModel.swift
//  MovieFinder
//
//  Created by Arshad T P on 7/15/18.
//  Copyright © 2018 Ab'initio. All rights reserved.
//

import Foundation

final class MovieViewModel {
	
	var imageURL: URL?
	var name: String?
	var releaseDate: String?
	var summary: String?
	
	init(from movie: MovieModel) {
		name = movie.title
		summary = movie.overview
	}
}
