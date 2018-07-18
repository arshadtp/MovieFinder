//
//  MovieListViewModel.swift
//  MovieFinder
//
//  Created by Arshad T P on 7/15/18.
//  Copyright © 2018 Ab'initio. All rights reserved.
//

import Foundation


final class MovieListViewModel: MoviesViewControllerDataSource {
	
	static let defaultPageNumber: Int = 1
	private (set) var totalResult: Int = 0
	private (set) var totalPages: Int = 0
	
	private (set) var currentPage: Int = defaultPageNumber
	
	private (set) var movies = [MovieTableViewCellDisplayable]()
	private lazy var isLoading = {return  AtomicType(false)}()
	
	init() {
	}
	
	
	// ----------------------
	// MARK: - MoviesViewControllerDataSource Protocol Methods
	// ----------------------
	
	/// Return number of rows/ elements to be displayed
	var numberOfRows: Int {
		return movies.count
	}
	
	
	/// method to fetch data for a particulr row
	///
	/// - Parameter index: index of the row
	/// - Returns: Data to be displated in row
	func movieDetailForIndexPath(_ index: Int) -> MovieTableViewCellDisplayable? {
		
		if movies.count > index {
			return movies[index]
		}
		return nil
	}
	
	
  /// Method fetches movie list matching the search term. Call this method for any new search. Calling this method will cancel any pending request.
  ///
  /// - Parameters:
  ///   - name: name of the movie to be seached
  ///   - page: page to be loaded
	///   - shouldCache: flag indicating whether to chache or not
  ///   - completionBlock: retunrs the movie details or error
	
	func searchMovie(name: String, page:Int, shouldCache: Bool = true, _ completionBlock: @escaping SearchMovieCompletionBlock)  {
		
		// Cancel all pending requests
		MovieFinderWebService.cancelAllRequests()
		loadMovies(name: name, page: page) {[weak self] (movieList, error) in
			if let weakSelf = self {
				// Set up params
				weakSelf.resetResultCountInfo(from: movieList)
				if let movies = movieList?.movies {
					if shouldCache {
						MovieCacheManager.addToCache(name: name)
					}
					completionBlock(movies.map { return MovieViewModel.init(from: $0)}, error)
				} else {
					completionBlock(nil, error)
				}
			}
		}
  }
	
	
  /// Load next page. Next page is loaded only if new page available and no other page is being loaded.
	///Call this method to load new page
  ///
  /// - Parameters:
  ///   - name: movie name to be searched
  ///   - page: page to be loaded
  ///   - completionBlock: <#completionBlock description#>
	func checkAndLoadNextPage(name: String, page:Int,_ completionBlock: @escaping SearchMovieCompletionBlock, didStartLoading:(()->())? = nil)  {
		
		// Load only if new page is available, or no other page load is in progress
    if currentPage < totalPages, !isLoading.val {
			
			loadMovies(name: name, page: page) {[weak self] (movieList, error) in
				if let weakSelf = self {
					// Set up params
					weakSelf.resetResultCountInfo(from: movieList)
					if let movies = movieList?.movies {
						completionBlock(movies.map { return MovieViewModel.init(from: $0)}, error)
					} else {
							completionBlock(nil, error)
					}
				}
			}
    }
  }
	
	
	/// Method to update the movie list
	///
	/// - Parameters:
	///   - array: new movie list to  append with/replace the existing
	///   - shouldClear: true to replace the extinsting
	func updateDataSourceArray(with array: [MovieTableViewCellDisplayable]?, byClearingExistingValues shouldClear: Bool = false)  {
		
		if shouldClear {
			movies = array ?? [MovieTableViewCellDisplayable]()
		}
		else if let array = array {
			movies += array
		}
	}

	// ----------------------
	// MARK: - Private Methods
	// ----------------------
	private func resetResultCountInfo(from movieList: MovieList?)  {
		currentPage = movieList?.page ?? 1
		totalResult = movieList?.totalPages ?? 0
		totalPages = movieList?.totalPages ?? 0
	}
}


private extension MovieListViewModel {
	
	private func loadMovies(name: String, page:Int, _ completionBlock: ((_ response: MovieList?, _ error: Error?) -> Void)?)  {
		isLoading.val = true
		let request = MovieRequestType.movieSearch(query: name, page: page)
		MovieFinderWebService().request(type: request) { [unowned self](response, error) in
      
      if error != nil {
        completionBlock?(nil, error)
      } else if let response = response as? MovieList {
        completionBlock?(response, error)
      }
      else {
        // TO DO:// Format error
      }
				self.isLoading.val = false
		}

	}
}
