//
//  MovieListModelTests.swift
//  MovieFinderTests
//
//  Created by Arshad T P on 7/18/18.
//  Copyright © 2018 Ab'initio. All rights reserved.
//

import XCTest
import ObjectMapper
@testable import MovieFinder

class MovieListModelTests: XCTestCase {
    
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
		
		let testSuccessfulJSON: [String: Any] =  ["page": 1,
																							"total_results": 10,
																							"total_pages": 2,
																							"results": [["title": "Batman",
																							"poster_path": "/udDVJXtAFsQ8DimrXkVFqy4DGEQ.jpg",
																						  "overview": "The Dynamic Duo faces.",
																						  "release_date": "1966-07-30"]]]
		
		let map = Map.init(mappingType: MappingType.fromJSON, JSON: testSuccessfulJSON)
		
		let movieListModel = MovieListModel.init(map: map)
		XCTAssertNotNil(movieListModel)
		movieListModel!.mapping(map: map)
		
		XCTAssertEqual(movieListModel!.page, 1)
		XCTAssertEqual(movieListModel!.totalPages, 2)
		XCTAssertEqual(movieListModel!.totalResults, 10)
		
		XCTAssertNotNil(movieListModel!.movies)
		XCTAssertGreaterThan(movieListModel!.movies!.count, 0)
		
	}

}
