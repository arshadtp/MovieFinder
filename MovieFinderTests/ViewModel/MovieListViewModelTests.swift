//
//  MovieListViewModelTests.swift
//  MovieFinderTests
//
//  Created by Arshad T P on 7/18/18.
//  Copyright © 2018 Ab'initio. All rights reserved.
//

import Foundation
import XCTest
@testable import MovieFinder

class MovieListViewModelTests: XCTestCase {
	
	fileprivate var webServiceClient:MockMovieFinderWebService!
	
	override func setUp() {
		super.setUp()
		webServiceClient = MockMovieFinderWebService()

		// Put setup code here. This method is called before the invocation of each test method in the class.
	}
	
	override func tearDown() {
		webServiceClient = nil
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}
	// MARK: - getFriend
	func testSearchMovie() {
		
		let viewModel = MovieListViewModel.init()
		viewModel.searchMovie(name: "KingsMan", page: 1, shouldCache: true) { (cellData, error) in
			
			XCTAssert((cellData?.count ?? 0) > 0, "Data not loaded correctly")
		}
	}
}

private extension MovieListViewModel {
	
	func searchMovie(name: String, page:Int, shouldCache: Bool = true, _ completionBlock: @escaping SearchMovieCompletionBlock)  {
		let request = MovieRequestType.movieSearch(query: name, page: page)
		
		MockMovieFinderWebService().request(type: request) { (response, error) in
			// Set up params
			
			let movies = (response as? MovieListModel)?.movies ?? [MovieModel]()
			completionBlock(movies.map { return MovieViewModel.init(from: $0)}, error)
		}
	}
}

fileprivate final class MockMovieFinderWebService: MovieFinderWebService {
	
	
	override func request(type: RequestTypeProtocol,
												completion: @escaping (_ response:APIResponse?, _ error:Error?) -> Void ) {
		
		completion (MovieListModel.mock(), nil)
	}
}
