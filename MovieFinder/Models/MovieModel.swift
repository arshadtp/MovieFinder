//
//  MovieModel.swift
//  MovieFinder
//
//  Created by Arshad T P on 7/14/18.
//  Copyright © 2018 Ab'initio. All rights reserved.
//

import Foundation
import ObjectMapper

class MovieModel: Mappable {

	// Properties
	var title: String?
	var overview: String?
	var relaseDateString: String?
	var posterPath: String?
	
	public required init?(map: Map) {
		
	}

	// Mapping method
	public func mapping(map: Map) {
		title    <- map["title"]
		overview <- map["overview"]
		relaseDateString <- map["release_date"]
		posterPath <- map["poster_path"]
	}
}
