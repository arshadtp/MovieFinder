//
//  MovieQuerryWebService.swift
//  MovieFinder
//
//  Created by Arshad T P on 7/14/18.
//  Copyright © 2018 Ab'initio. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

enum MovieRequestType: RequestTypeProtocol {
	
	case movieSearch(query: String, page: Int)
	
	func getDataProvider() -> RequestDataProviderProtocol {
		return MovieRequestDataProvider()
	}
}


struct MovieRequestDataProvider: RequestDataProviderProtocol {
	
	func responseModel(_ type: RequestTypeProtocol,
										 response: [String : Any]) -> (response:APIResponse?, error:Error?)? {
		
		guard let type = type as? MovieRequestType else {
			fatalError("Expected MovieRequestType")
		}
		
		switch type {
		case .movieSearch(_,_): return MovieListModel.parse(JSON: response)
		}
	}
	
	func requestMethodForType(_ type: RequestTypeProtocol) -> HTTPMethod {
		guard let type = type as? MovieRequestType else {
			fatalError("Expected MovieRequestType")
		}
		switch type {
		case .movieSearch(_,_): return .get
		}
	}
	
	func requestUrlForType(_ type: RequestTypeProtocol) -> String {
		guard let type = type as? MovieRequestType else {
			fatalError("Expected MovieRequestType")
		}
		switch type {
		case .movieSearch(_,_): return APIPaths.searchMovie
		}
	}
	
	func requestParamsForType(_ type: RequestTypeProtocol) -> [String : Any]? {
		guard let type = type as? MovieRequestType else {
			fatalError("Expected MovieRequestType")
		}
		
		switch type {
			
		case .movieSearch(let query, let page):
      
      guard let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String else {
        fatalError("Please API_KEY in info.plist.")

      }
			return ["query" : query, "page" : page, "api_key": apiKey]
		}
	}
}

