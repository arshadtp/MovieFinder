//
//  ViewController.swift
//  MovieFinder
//
//  Created by Arshad T P on 7/14/18.
//  Copyright © 2018 Ab'initio. All rights reserved.
//

import UIKit
import ObjectMapper

typealias SearchMovieCompletionBlock = (_ response: [MovieTableViewCellDisplayable]?, _ error: Error?) -> Void

protocol MoviesViewControllerDataSource {
	
  var currentPage: Int { get }
  var numberOfRows: Int {get}
	
	func movieDetailForIndexPath(_ index: Int) -> MovieTableViewCellDisplayable?
	func searchMovie(name: String, page:Int, _ completionBlock: @escaping SearchMovieCompletionBlock)
	func checkAndLoadNextPage(name: String, page:Int,_ completionBlock: @escaping SearchMovieCompletionBlock)
	func updateDataSourceArray(with array: [MovieTableViewCellDisplayable]?, byClearingExistingValues shouldClear: Bool)
}
class MoviesViewController: UIViewController {

	// ----------------------
	// MARK: - Variables
	// ----------------------
	private var viewModel = MovieListViewModel() // View Model
	@IBOutlet private weak var tableView: UITableView!
  private lazy var searchController = {
    return UISearchController(searchResultsController: self.storyboard?.instantiateViewController(withIdentifier: "MovieCacheResultController"))
  } ()

	// ----------------------
	// MARK: - Life Cycle
	// ----------------------
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.rowHeight = UITableViewAutomaticDimension
    setUpSearchController()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

  // -------------------------
  // MARK: - Configurations
  // -------------------------
  private func setUpSearchController()  {
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
      navigationItem.hidesSearchBarWhenScrolling = true
    } else {
      // Fallback on earlier versions
    }
    definesPresentationContext = true
    
    searchController.searchBar.delegate = self
    searchController.hidesNavigationBarDuringPresentation = true
    searchController.becomeFirstResponder()
  }
  
	// ----------------------
	// MARK: - API Helpers
	// ----------------------
	private func searchMovies(_ name: String)  {
		
    viewModel.searchMovie(name: name, page: 1) { [unowned self] (response, error) in
      
      if let error = error {
        
      } else if let response = response {
				self.viewModel.updateDataSourceArray(with: response, byClearingExistingValues: true)
				DispatchQueue.main.async {
					self.tableView.reloadData()
				}
      }
    }
	}
  
  private func loadNextPage() {
		
		guard let searchKey = self.searchController.searchBar.text else {
			return
		}
    viewModel.checkAndLoadNextPage(name: searchKey, page: viewModel.currentPage+1) { [unowned self] (response, error) in
      
      if let error = error {
        
      } else if let response = response  {
				DispatchQueue.main.async {
					if response.count > 0 {
						
						self.tableView.beginUpdates()
						
						var indexPaths = [IndexPath]()
						for i in 0..<response.count {
							indexPaths.append(IndexPath(row: self.viewModel.numberOfRows+i, section: 0))
						}
						self.viewModel.updateDataSourceArray(with: response, byClearingExistingValues: false)

						
						self.tableView.insertRows(at: indexPaths, with: .automatic)
						self.tableView.endUpdates()

					}

				}

      }
    }
  }
}

// ----------------------
// MARK: - Tableview DataSource and Delegate
// ----------------------

extension MoviesViewController: UITableViewDataSource, UITableViewDelegate {
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		return viewModel.numberOfRows
	}
	
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell            = tableView.dequeueReusableCell(withIdentifier: CellReuseIdentifier.movieTableViewCell, for: indexPath) as! MovieTableViewCell
		cell.selectionStyle = .none
		if let detail = viewModel.movieDetailForIndexPath(indexPath.row) {
			cell.loadData(detail)
		}
		return cell
	}
	


  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if indexPath.row == viewModel.numberOfRows - 1 {
      loadNextPage()
    }
  }
}

// -------------------------
// MARK: - UISearchBar Delegate
// -------------------------

extension MoviesViewController: UISearchBarDelegate {
  
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		if let text = searchBar.text {
			searchMovies(text)
		}
		searchController.dismiss(animated: true, completion: nil)
	}
}

// -------------------------
// MARK: - UISearchResultsUpdating Delegate
// -------------------------
extension MoviesViewController: UISearchResultsUpdating {
  
  func updateSearchResults(for searchController: UISearchController) {
    searchController.searchResultsController?.view.isHidden = false
  }
}
