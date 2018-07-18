//
//  MovieModelTests.swift
//  MovieFinderTests
//
//  Created by Arshad T P on 7/18/18.
//  Copyright © 2018 Ab'initio. All rights reserved.
//

import XCTest
import ObjectMapper
@testable import MovieFinder

class MovieModelTests: XCTestCase {
	
	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}
	
	
	/// Test for model initialization
	func testInitFromMap()  {
		
		let testSuccessfulJSON: [String: Any] = ["title": "Batman",
																		"poster_path": "/udDVJXtAFsQ8DimrXkVFqy4DGEQ.jpg",
																		"overview": "The Dynamic Duo faces.",
																		"release_date": "1966-07-30"]
		let map = Map.init(mappingType: MappingType.fromJSON, JSON: testSuccessfulJSON)
		
		let movieModel = MovieModel.init(map: map)
		XCTAssertNotNil(movieModel)
		movieModel!.mapping(map: map)
		XCTAssertEqual(movieModel!.title, "Batman")

		XCTAssertEqual(movieModel?.overview, "The Dynamic Duo faces.")
		XCTAssertEqual(movieModel?.posterPath, "/udDVJXtAFsQ8DimrXkVFqy4DGEQ.jpg")
		XCTAssertEqual(movieModel?.relaseDateString, "1966-07-30")
	}
	
	
}
