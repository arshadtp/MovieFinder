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
	
	// MARK: - getFriend
	func testSearchMoview() {
		
		let appServerClient = MockMovieFinderWebService()
		appServerClient.completionBlockParams =  (MovieListModel.mock(), nil)
		
		let viewModel = MovieListViewModel.init()
		viewModel.searchMovie(name: "batman", page: 1) { (response, error) in
			
		}
	}
}


private final class MockMovieFinderWebService: MovieFinderWebService {
	
	var completionBlockParams: (APIResponse?, Error?)
	
	override func request(type: RequestTypeProtocol,
							 completion: @escaping (_ response:APIResponse?, _ error:Error?) -> Void ) {
		completion(completionBlockParams.0, completionBlockParams.1)
	}
}
