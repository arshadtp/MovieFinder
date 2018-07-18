//
//  MovieCacheManager.swift
//  MovieFinder
//
//  Created by Arshad T P on 7/16/18.
//  Copyright © 2018 Ab'initio. All rights reserved.
//

import Foundation

let cacheSize: Int = 10
let cacheKey = "MovieCache"


struct MovieCacheManager {
	
	static var caches = { () -> [String] in
		guard let cache = UserDefaults.standard.value(forKey: cacheKey) as? [String]  else {
			return [String]()
		}
		return cache
	}() // Cache array with recent at last position
	
	
	/// Add data to cache
	///
	/// - Parameter name: name to be cached
	static func addToCache(name: String) {
		// Making case insensitive
		let chacheName = name.capitalized
		// Remove the data if already chache and re-add to top
		if caches.contains(chacheName) {
			caches.remove(at: caches.index(of: chacheName)!)
		}
		caches.append(chacheName)
		if caches.count > cacheSize {
			caches = Array(caches[caches.count-cacheSize...caches.count-1])
		}
		UserDefaults.standard.set(caches, forKey: cacheKey)
		UserDefaults.standard.synchronize()
	}
	
}
