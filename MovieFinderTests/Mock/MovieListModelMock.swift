//
//  MovieListModelMock.swift
//  MovieFinderTests
//
//  Created by Arshad T P on 7/18/18.
//  Copyright © 2018 Ab'initio. All rights reserved.
//

import Foundation
import ObjectMapper
@testable import MovieFinder

extension MovieListModel {
	
	static func mock() -> MovieListModel {
		
		let testSuccessfulJSON: [String: Any] =  ["page": 1,
																							"total_results": 10,
																							"total_pages": 2,
																							"results": [["title": "Batman",
																													 "poster_path": "/udDVJXtAFsQ8DimrXkVFqy4DGEQ.jpg",
																													 "overview": "The Dynamic Duo faces.",
																													 "release_date": "1966-07-30"],
																													["title": "Batman 1",
																													 "poster_path": "/udDVJXtAFsQ8DimrXkVFqy4DGEQ.jpg",
																													 "overview": "Batman movie .",
																													 "release_date": "1966-08-30"]]]
		
		let map = Map.init(mappingType: MappingType.fromJSON, JSON: testSuccessfulJSON)
		let movieListModel = MovieListModel.init(map: map)!
		movieListModel.mapping(map: map)
		return movieListModel
	}
}
