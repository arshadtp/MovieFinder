//
//  APIConstants.swift
//  MovieFinder
//
//  Created by Arshad T P on 7/15/18.
//  Copyright © 2018 Ab'initio. All rights reserved.
//

import Foundation

struct URLConstant {
  
  // Add new flag in Other Linker Flag section of Project settings
  #if Debug
  static let apiBaseURL = "http://api.themoviedb.org/3" // Debug  (Dev/QA server URLs)
  #elseif Release
  static let apiBaseURL = "http://api.themoviedb.org/3" // Produnction URL
  #endif
  
	static let movieImageBaseURL = "http://image.tmdb.org/t/p/"
}

struct APIPaths {
  static let searchMovie = "/search/movie/"
}
struct MovieImageSize {
	static let small = "w92"
	static let medium = "w185"
	static let large = "w500"
	static let xtraLarge = "w780"
}


/// Date formats returned from API, UPDATE ONLY IF API CHANGED
struct APIDateFormats {
	static let commonFormat = "yyyy-MM-dd"
}
