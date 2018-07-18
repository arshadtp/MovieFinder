//
//  MovieViewModel.swift
//  MovieFinder
//
//  Created by Arshad T P on 7/15/18.
//  Copyright © 2018 Ab'initio. All rights reserved.
//

import Foundation
import SDWebImage

final class MovieViewModel: MovieTableViewCellDisplayable {

	/// Lazy var to store image base URL, and fail if URL is not configured correctly
	private (set) lazy var imageBaseURL:URL = {
		guard let url = URL.init(string: URLConstant.movieImageBaseURL + MovieImageSize.large) else {
			fatalError("Please configure image base URL")
		}
		return url
	}()
	
	private (set) var imageURL: URL?
	private (set) var name: String?
	private (set) var summary: String?
	private var releaseRawDate: String?

	private (set) lazy var releaseDate: String? = {
		if let rawDate = releaseRawDate {
			if let date = Date.date(from: rawDate, withFormat: APIDateFormats.commonFormat) {
				return date.toString(format:AppDateFormats.commonFormat)
			}
		}
		return nil}()
	
	
	init(from movie: MovieModel) {
		name = movie.title
		summary = movie.overview
		releaseRawDate = movie.relaseDateString
		if let imagePath = movie.posterPath {
			imageURL = imageBaseURL.appendingPathComponent(imagePath)
		}
	}
}
