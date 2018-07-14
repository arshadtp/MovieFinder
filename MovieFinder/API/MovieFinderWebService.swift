//
//  MovieFinderWebService.swift
//  MovieFinder
//
//  Created by Arshad T P on 7/14/18.
//  Copyright © 2018 Ab'initio. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class MovieFinderWebService {
	
	private var alamofireManager = Alamofire.SessionManager.default

	/// Create a webservice request for given type.
	///
	/// - Parameters:
	///   - type: request type as RequestTypeProtocol
	///   - completion: response as Response model
	func request(type: RequestTypeProtocol,
							 completion: @escaping (_ response:APIResponse?, _ error:APIError?) -> Void ) {
		if NetworkReachabilityManager()!.isReachable {
				let method = type.getHTTPMethod()
				let requestURL = URL(string: getURLString(type: type))!
				debugPrint(requestURL)
				let parameters = type.params()
				debugPrint(parameters ?? "Empty Parameter")
				let request = alamofireManager.request(requestURL,
																							 method: method,
																							 parameters: parameters,
																							 encoding: URLEncoding.default,
																							 headers: nil)
				alamofireManager.session.configuration.timeoutIntervalForRequest = 10
				request.responseData(completionHandler: { response in
					

					self.validateResponse(response,
																type: type,
																completion)
				})
		} else {
			completion(nil, APIError(kind: .noNetworkConnection, message: "No Network"))
		}
	}
	
	/// Validate the webservice response and generate a Response model obeject.
	///
	/// - Parameters:
	///   - response: DataResponse
	///   - type: request type conforming RequestTypeProtocol
	///   - callback: Response model object with success/error details
	func validateResponse(_ response: DataResponse<Data>,
												type: RequestTypeProtocol,
												_ callback: @escaping (_ response:APIResponse?, _ error:APIError?) -> Void) {
		switch response.result {
		case .success(let data):
			do {
				if let responseJSON =  try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] {
					debugPrint(responseJSON)
					if let model = type.responseModel(responseJSON) {
						callback(model.response, model.error)
					}
				}
			}
			catch {
//				callback(Result.failure(error))
			}
		case .failure(let error):
			debugPrint("Request failed with error: \(error)")
//			callback(Result.failure(error))

		}
	}
	
	/// Cancell all webservice requests
	public func cancelAllRequests() {
		alamofireManager.session.getAllTasks { (dataTask) in
			dataTask.forEach { $0.cancel() }
		}
	}

		
	/// Generate request URL with base URL and type. If the environment is DEBUG, get the base URL from
	/// Constants.baseURL. Else get the base URL from info.plist
	///
	/// - Parameters:
	///   - type: request type conforming RequestTypeProtocol
	/// - Returns: Request URL as String
	func getURLString(type: RequestTypeProtocol) -> String {
		let urlString =  getbaseURL() + type.getRequestUrl()
		return urlString
	}
	
	func getbaseURL() -> String {
	  guard let baseURL =  Bundle.main.infoDictionary!["BASE_URL"] as? String  else {
			fatalError("Invalid BASE URL")
		}
		return baseURL

	}



}
