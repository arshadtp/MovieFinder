//
//  MovieListModel.swift
//  MovieFinder
//
//  Created by Arshad T P on 7/18/18.
//  Copyright © 2018 Ab'initio. All rights reserved.
//

import Foundation
import ObjectMapper

class MovieListModel: Mappable {
	
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

extension MovieListModel: APIResponse {
	
	static func parse(JSON: [String : Any]) -> (response: APIResponse?, error: Error?)? {
		if let erros = JSON["errors"] as? [String], erros.count > 0 {
			return (nil, APIError.init(kind: .overFlow, message: erros.first!))
		}
		else if let success = JSON["success"] as? Bool, !success {
			return (nil, APIError.init(kind: .overFlow, message: (JSON["status_message"] as? String) ?? StringConstants.defaultServerErrorMessage))
		} else if let response = Mapper<MovieListModel>().map(JSON: JSON), let resultCount = response.totalResults, resultCount > 0 {
			return (response, nil)
		}
		return (nil, APIError.init(kind: .noData, message: StringConstants.noResultMessage))
		
	}
	
}

