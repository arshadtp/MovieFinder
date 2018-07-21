//
//  MovieViewModelTest.swift
//  MovieFinderTests
//
//  Created by Arshad T P on 7/21/18.
//  Copyright © 2018 Ab'initio. All rights reserved.
//

import XCTest
@testable import MovieFinder

class MovieViewModelTest: XCTestCase {
	
	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}
	
	func testMovieModelInit()  {
		
		let model = MovieViewModel.init(from: MovieModel.mock())
		XCTAssertEqual(model.name, "Batman")
		XCTAssertEqual(model.releaseDate, "10-February, 2000")
		XCTAssertEqual(model.summary, "Hollywood thriller")
		XCTAssert(model.imageURL != nil, "poster image url is not initialized correctly")
	}
	
	
}
