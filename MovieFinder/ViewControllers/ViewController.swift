//
//  ViewController.swift
//  MovieFinder
//
//  Created by Arshad T P on 7/14/18.
//  Copyright © 2018 Ab'initio. All rights reserved.
//

import UIKit
import ObjectMapper
class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		let request = MovieRequestType.movieSearch(query: "batman", page: 1)
		MovieFinderWebService().request(type: request) { (response, error) in
			
			if let error = error {
				debugPrint(error)
			} else if let response = response as? MovieList {
				debugPrint(response)

			}
		}
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

