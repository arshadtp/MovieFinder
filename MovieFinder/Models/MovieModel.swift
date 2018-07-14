//
//  MovieModel.swift
//  MovieFinder
//
//  Created by Arshad T P on 7/14/18.
//  Copyright © 2018 Ab'initio. All rights reserved.
//

import Foundation
import ObjectMapper

class MovieList: Mappable {

	var page: Int?
	var totalPages: Int?
	var totalResults: Int?
	
	var movies: [MovieModel]? = nil
	
	func mapping(map: Map) {
		page    <- map["page"]
		totalPages <- map["total_pages"]
		totalResults <- map["total_results"]
		movies <- map["results"]
	}
	
	required init?(map: Map) {
	}
}

extension MovieList: APIResponse {
	
	static func parse(JSON: [String : Any]) -> (response: APIResponse?, error: APIError?)? {
		if let erros = JSON["errors"] as? [String], erros.count > 0 {
			return (nil, APIError.init(kind: .overFlow, message: erros.first))
		}
		else if let success = JSON["success"] as? Bool, !success {
			return (nil, APIError.init(kind: .overFlow, message: JSON["status_message"] as? String))
		}
		return (Mapper<MovieList>().map(JSON: JSON), nil)
	}

}

class MovieModel: Mappable {

	// Properties
	var title: String?
	var overview: String?
	
	public required init?(map: Map) {
		
	}

	// Mapping method
	public func mapping(map: Map) {
		title    <- map["title"]
		overview <- map["overview"]
	}
}
