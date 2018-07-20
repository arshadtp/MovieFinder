//
//  ViewController.swift
//  MovieFinder
//
//  Created by Arshad T P on 7/14/18.
//  Copyright © 2018 Ab'initio. All rights reserved.
//

import UIKit
import ObjectMapper

typealias SearchMovieCompletionBlock = (_ response: [MovieViewModel]?, _ error: Error?) -> Void

class MoviesViewController: UIViewController {

	// ----------------------
	// MARK: - Variables
	// ----------------------
	private let viewModel = MovieListViewModel() // View Model
	@IBOutlet private weak var tableView: UITableView!
	@IBOutlet private weak var activityIndicator: UIActivityIndicatorView! // Sample indicator, need to be replaced by new
	private lazy var searchController = {
    return UISearchController(searchResultsController: self.storyboard?.instantiateViewController(withIdentifier: VCIdentifier.movieCacheResultController))
  } ()

	// ----------------------
	// MARK: - Life Cycle
	// ----------------------
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.rowHeight = UITableViewAutomaticDimension
    activityIndicator.stopAnimating()
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
		
		(searchController.searchResultsController as? MovieCacheResultController)?.delegate = self
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
			view.isUserInteractionEnabled = false
			self.navigationItem.hidesSearchBarWhenScrolling = false
			DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2) {[unowned self] in
				self.navigationItem.hidesSearchBarWhenScrolling = true
				self.view.isUserInteractionEnabled = true
			}
    } else {
			self.tableView.tableHeaderView = searchController.searchBar
			self.tableView.tableHeaderView?.frame = CGRect.init(x: 0, y: 0, width: view.bounds.width, height: 40)
      // Fallback on earlier versions
    }
    definesPresentationContext = true
    searchController.searchBar.delegate = self
  }
  
	// ----------------------
	// MARK: - API Helpers
	// ----------------------
	private func searchMovies(_ name: String)  {
		
		activityIndicator.startAnimating()
    viewModel.searchMovie(name: name, page: 1) { [unowned self] (response, error) in
      
      if let error = error {
				DispatchQueue.main.async { [unowned self] in
					self.activityIndicator.stopAnimating()
					AlertUtilities.showErrorAlert(error: error, cancelButtonTitle: "OK", inViewController: self)
				}
      } else if let response = response {
				DispatchQueue.global().async { [unowned self] in
					self.viewModel.updateDataSourceArray(with: response, byClearingExistingValues: true)
					DispatchQueue.main.async { [unowned self] in
						self.activityIndicator.stopAnimating()
						self.tableView.reloadData()
					}
				}
      }
    }
	}
  
  private func loadNextPage() {
		
		guard let searchKey = self.searchController.searchBar.text else {
			return
		}
		viewModel.checkAndLoadNextPage(name: searchKey, page: viewModel.currentPage+1, { [unowned self] (response, error) in
			if  error != nil {
				DispatchQueue.main.async { [unowned self] in
					self.activityIndicator.stopAnimating()
				}
				
			} else if let response = response  {
				DispatchQueue.main.async { [unowned self] in
					if response.count > 0 {
						self.activityIndicator.stopAnimating()
						self.viewModel.updateDataSourceArray(with: response, byClearingExistingValues: false)
            self.tableView.reloadData()
					}
				}
			}
		}) { [unowned self] in
      DispatchQueue.main.async {
        self.activityIndicator.startAnimating()
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
  
  func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if let cell = cell as? MovieTableViewCell {
      cell.cancelImageDownLoad()
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
// ----------------------
// MARK: - MovieCacheResultControllerDelegate
// ----------------------

extension MoviesViewController: MovieCacheResultControllerDelegate {
	
	func didSelectCache(_ cache:String) {
    searchController.searchBar.text = cache
		searchMovies(cache)
		searchController.dismiss(animated: true, completion: nil)

	}

}
