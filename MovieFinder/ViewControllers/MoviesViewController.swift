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

	// ----------------------
	// MARK: - Variables
	// ----------------------
	private var viewModel: MovieListViewModel!
	
	@IBOutlet weak var tableView: UITableView!
	// ----------------------
	// MARK: - Life Cycle
	// ----------------------

	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.rowHeight = UITableViewAutomaticDimension
		searchMovies()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	// ----------------------
	// MARK: - API Helpers
	// ----------------------
	func searchMovies()  {
		
		let request = MovieRequestType.movieSearch(query: "batman", page: 1)
		MovieFinderWebService().request(type: request) { [unowned self](response, error) in
			
			if let error = error {
				debugPrint(error)
			} else if let response = response as? MovieList {
				debugPrint(response)
				self.viewModel = MovieListViewModel.init(from: response)
				self.tableView.reloadData()
			}
		}
	}
	
	func loadMore()  {
		
	}

}

// ----------------------
// MARK: - Tableview DataSource
// ----------------------
extension MoviesViewController: MovieTableViewCellDelegate {

	func contentDidChange(cell: MovieTableViewCell) {
		tableView.beginUpdates()
		tableView.endUpdates()
	}

}
extension MoviesViewController: UITableViewDataSource {
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		return viewModel == nil ? 0 :  viewModel.numberOfRows
	}
	
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell            = tableView.dequeueReusableCell(withIdentifier: CellReuseIdentifier.movieTableViewCell, for: indexPath) as! MovieTableViewCell
		cell.selectionStyle = .none
		cell.loadData(viewModel.movieDetailForIndexPath(indexPath))
		cell.delegate = self
		return cell
	}
	
	
	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
	}

	
}
