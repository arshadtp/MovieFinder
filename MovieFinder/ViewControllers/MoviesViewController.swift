//
//  ViewController.swift
//  MovieFinder
//
//  Created by Arshad T P on 7/14/18.
//  Copyright © 2018 Ab'initio. All rights reserved.
//

import UIKit
import ObjectMapper
class MoviesViewController: UIViewController {

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

// ----------------------
// MARK: - Tableview DataSource
// ----------------------

extension MoviesViewController: UITableViewDataSource {
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell            = tableView.dequeueReusableCell(withIdentifier: CellReuseIdentifier.movieTableViewCell, for: indexPath) as! MovieTableViewCell
		cell.selectionStyle = .none
		
		return cell
	}
	
	
	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
	}

	
}
