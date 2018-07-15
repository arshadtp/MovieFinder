//
//  MovieListViewModel.swift
//  MovieFinder
//
//  Created by Arshad T P on 7/15/18.
//  Copyright © 2018 Ab'initio. All rights reserved.
//

import Foundation

typealias RetrieveMovieCompletionBlock = (_ success: Bool, _ error: Error?) -> Void

final class MovieListViewModel {
	
	var totalResult: Int = 0
	var totalPages: Int = 0
	var currentPage: Int = 0
	
	private var movies = [MovieViewModel]()
	private var retrieveUsersCompletionBlock: RetrieveMovieCompletionBlock?
	private var name: String?
	private lazy var isLoading = {return  AtomicType(false)}()
	
//	init(from movieList: MovieList) {
//		totalResult = movieList.totalPages ?? 0
//		totalPages = movieList.totalPages ?? 0
//		if let movies = movieList.movies {
//			self.movies += movies.map { return MovieViewModel.init(from: $0)}
//		}
//	}
	init() {
		
	}
	
	var numberOfRows: Int {
		return movies.count
	}
	
	func movieDetailForIndexPath(_ indexPath: IndexPath) -> MovieViewModel {
		if indexPath.row == numberOfRows-1 {
			loadMoreIfNeeded()
		}
		return movies[indexPath.row]
	}
	
	
	func retrieveMovie(name: String? ,_ completionBlock: @escaping RetrieveMovieCompletionBlock) {
		retrieveUsersCompletionBlock = completionBlock
		self.name = name
		loadMovies(name: name, page: 1)
	}
	
	private func loadMoreIfNeeded() {
		if currentPage < totalPages, !isLoading.val {
			loadMovies(name: name, page: currentPage+1)
		}
	}

}

private extension MovieListViewModel {
	
	func configureModel(from model: MovieList)  {
		
		if let totalPage = model.totalPages {
			self.totalPages = totalPage
		}
		if let totalResult = model.totalResults {
			self.totalResult = totalResult
		}
		if let page = model.page {
			self.currentPage = page
		}
		if let movies = model.movies {
			self.movies += movies.map { return MovieViewModel.init(from: $0)}
		}
		
	}
	
	func loadMovies(name: String?, page:Int)  {
		isLoading.val = true
		let request = MovieRequestType.movieSearch(query: name, page: page)
		MovieFinderWebService().request(type: request) { [unowned self](response, error) in
			DispatchQueue.main.async {
				if let error = error {
					debugPrint(error)
					self.retrieveUsersCompletionBlock?(false, error)
				} else if let response = response as? MovieList {
					debugPrint(response)
					self.configureModel(from: response)
					self.retrieveUsersCompletionBlock?(true, nil)
				}
				self.isLoading.val = false
			}
		}

	}
}
