//
//  MovieModelMock.swift
//  MovieFinderTests
//
//  Created by Arshad T P on 7/18/18.
//  Copyright © 2018 Ab'initio. All rights reserved.
//

import Foundation
import ObjectMapper
@testable import MovieFinder

extension MovieModel {
	
	static func mock(title: String = "Batman", overview: String = "Hollywood thriller",
									 relaseDateString:String = "2000-02-10",
									 posterPath: String = "posterPath.jpg" ) -> MovieModel {
		let model = MovieModel.init(map: Map.init(mappingType: .fromJSON, JSON: [:]))!
		model.title = title
		model.overview = overview
		model.relaseDateString = relaseDateString
		model.posterPath = posterPath
		return model
	}
}
