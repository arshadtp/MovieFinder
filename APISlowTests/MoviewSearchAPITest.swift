//
//  APISlowTests.swift
//  APISlowTests
//
//  Created by Arshad on 19/07/18.
//  Copyright © 2018 Ab'initio. All rights reserved.
//

import XCTest
@testable import MovieFinder

class MoviewSearchAPITest: XCTestCase {
  
  var webServiceClient:MovieFinderWebService!
  
    override func setUp() {
        super.setUp()
        webServiceClient = MovieFinderWebService()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        webServiceClient = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMovieFetchAPIInIdealCase() {
      
      let promise = expectation(description: "Completion handler invoked")
      var responseType: MovieListModel?
      var responseError: Error?

      let request = MovieRequestType.movieSearch(query: "Batman", page: 1)
      MovieFinderWebService().request(type: request) { (response, error) in
        
        responseError = error
        responseType = response as? MovieListModel
        promise.fulfill()
      }
      waitForExpectations(timeout: 5, handler: nil)
      XCTAssertNil(responseError)
      XCTAssertNotNil(responseType)
    }
  
  func testMovieFetchAPIOverflowError() {
    
    let promise = expectation(description: "Completion handler invoked")
    var responseType: MovieListModel?
    var responseError: Error?
    
    let request = MovieRequestType.movieSearch(query: "Batman", page: Int.max)
    MovieFinderWebService().request(type: request) { (response, error) in
      
      responseError = error
      responseType = response as? MovieListModel
      promise.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
    XCTAssertNotNil(responseError)
    XCTAssertNil(responseType)
  }
  
  func testMovieFetchAPINoQueryError() {
    
    let promise = expectation(description: "Completion handler invoked")
    var responseType: MovieListModel?
    var responseError: Error?
    
    let request = MovieRequestType.movieSearch(query: "Batman", page: Int.max)
    MovieFinderWebService().request(type: request) { (response, error) in
      
      responseError = error
      responseType = response as? MovieListModel
      promise.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
    XCTAssertNotNil(responseError)
    XCTAssertNil(responseType)
  }
  
  func testMovieFetchAPINoResultError() {
    
    let promise = expectation(description: "Completion handler invoked")
    var responseType: MovieListModel?
    var responseError: Error?
    
    let request = MovieRequestType.movieSearch(query: "zxzcczczczzzxzxczxzczxczxczxczxczxczxczxczxczxczxczxczxczxczxczxczxczxc", page: Int.max)
    MovieFinderWebService().request(type: request) { (response, error) in
      
      responseError = error
      responseType = response as? MovieListModel
      promise.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
    XCTAssertNotNil(responseError)
    XCTAssertNil(responseType)
  }
      
}
