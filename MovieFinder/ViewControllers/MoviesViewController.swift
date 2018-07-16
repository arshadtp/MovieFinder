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
	private var viewModel = MovieListViewModel()
	
	@IBOutlet weak var tableView: UITableView!
  lazy var searchController = {
    return UISearchController(searchResultsController: self.storyboard?.instantiateViewController(withIdentifier: "MovieCacheResultController"))
  } ()

	// ----------------------
	// MARK: - Life Cycle
	// ----------------------

	override func viewDidLoad() {
		super.viewDidLoad()
    
		tableView.rowHeight = UITableViewAutomaticDimension
		searchMovies()
    
    // Setup the Search Controller
    searchController.searchResultsUpdater = self
    if #available(iOS 9.1, *) {
      searchController.obscuresBackgroundDuringPresentation = false
    } else {
      // Fallback on earlier versions
    }
    searchController.searchBar.placeholder = "Search Movies"
    if #available(iOS 11.0, *) {
      navigationItem.searchController = searchController
    } else {
      // Fallback on earlier versions
    }
    definesPresentationContext = true
    
    searchController.searchBar.delegate = self
    searchController.hidesNavigationBarDuringPresentation = true
    searchController.becomeFirstResponder()
    
		// Do any additional setup after loading the view, typically from a nib.
	}

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    if #available(iOS 11.0, *) {
      navigationItem.hidesSearchBarWhenScrolling = true

    } else {
      // Fallback on earlier versions
    }
  }
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	// ----------------------
	// MARK: - API Helpers
	// ----------------------
	func searchMovies()  {
		
		viewModel.retrieveMovie(name: "batman") { [unowned self](success, error) in
			self.tableView.reloadData()
		}
	}
	
	func loadMoreIfNeeded()  {
		
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
		
		return viewModel.numberOfRows
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

extension MoviesViewController: UISearchBarDelegate {
  // MARK: - UISearchBar Delegate
  func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
  }
}

extension MoviesViewController: UISearchResultsUpdating {
  // MARK: - UISearchResultsUpdating Delegate
  func updateSearchResults(for searchController: UISearchController) {
    searchController.searchResultsController?.view.isHidden = false
  }
}
