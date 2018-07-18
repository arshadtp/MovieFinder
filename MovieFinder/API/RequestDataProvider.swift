//
//  RequestDataProvider.swift
//  MovieFinder
//
//  Created by Arshad T P on 7/14/18.
//  Copyright © 2018 Ab'initio. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

/// Request Type Protocol
protocol RequestTypeProtocol  {
	
	/// Get the data provider for a request
	///
	/// - Returns: RequestDataProviderProtocol
	func getDataProvider() -> RequestDataProviderProtocol
	
	/// Get request type
	///
	/// - Returns: HTTPMethod
	func getHTTPMethod() -> HTTPMethod
	
	/// Get request URL
	///
	/// - Returns: URL string
	func getRequestUrl() -> String
	
	/// Get request parameters
	///
	/// - Returns: [String : Any]
	func params() -> [String: Any]?
	
	/// Response model for the request
	///
	/// - Parameter json: JSON data
	/// - Returns: Model
	func responseModel(_ json: [String : Any]) -> (response:APIResponse?, error:APIError?)?
}

extension RequestTypeProtocol {
	
	func getHTTPMethod() -> HTTPMethod {
		return getDataProvider().requestMethodForType(self)
	}
	
	func getRequestUrl() -> String {
		return getDataProvider().requestUrlForType(self)
	}
	
	func params() -> [String: Any]? {
		return getDataProvider().requestParamsForType(self)
	}
	
	func responseModel(_ response: [String : Any]) -> (response:APIResponse?, error:APIError?)? {
		return getDataProvider().responseModel(self,
																					 response: response)
	}
}

protocol RequestDataProviderProtocol {
	func requestMethodForType(_ type: RequestTypeProtocol) -> HTTPMethod
	func requestUrlForType(_ type: RequestTypeProtocol) -> String
	func requestParamsForType(_ type: RequestTypeProtocol) -> [String: Any]?
	func responseModel(_ type: RequestTypeProtocol,
										 response: [String : Any]) -> (response:APIResponse?, error:APIError?)?
}

struct APIError:Error  {
	enum ErrorKind: Error {
		case noNetworkConnection
		case overFlow
	}
	
	let kind: ErrorKind
	var message: String
	
	init(kind: ErrorKind, message: String) {
		self.kind = kind
		self.message = message
	}
}


protocol APIResponse {
	static func parse(JSON: [String: Any]) -> (response:APIResponse?, error:APIError?)? 
}



