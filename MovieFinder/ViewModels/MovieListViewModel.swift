//
//  MovieListViewModel.swift
//  MovieFinder
//
//  Created by Arshad T P on 7/15/18.
//  Copyright © 2018 Ab'initio. All rights reserved.
//

import Foundation

final class MovieListViewModel {
	
	let totalResult: Int
	let totalPages: Int
	var currentPage: Int = 1
	private var movies = [MovieViewModel]()
	
	init(from movieList: MovieList) {
		totalResult = movieList.totalPages ?? 0
		totalPages = movieList.totalPages ?? 0
		if let movies = movieList.movies {
			self.movies = movies.map { return MovieViewModel.init(from: $0)}
		}
	}
	
	var numberOfRows: Int {
		return movies.count
	}
	
	func movieDetailForIndexPath(_ indexPath: IndexPath) -> MovieViewModel {
		return movies[indexPath.row]
	}
}
