//
//  MovieCacheResultController.swift
//  MovieFinder
//
//  Created by Arshad on 16/07/18.
//  Copyright © 2018 Ab'initio. All rights reserved.
//

import UIKit

protocol MovieCacheResultControllerDelegate {
	func didSelectCache(_ cache:String)
}

class MovieCacheResultController: UITableViewController {
	
	var delegate:MovieCacheResultControllerDelegate? = nil
	
	private var caches: [String]!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		caches = MovieCacheManager.caches.reversed()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		// Reverse the cache to show recent search on first
		caches = MovieCacheManager.caches.reversed()
		tableView.reloadData()
	}
	
	// MARK: - Table view data source
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
		return caches.count
	}
	
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: CellReuseIdentifier.cell, for: indexPath)
		
		// Configure the cell...
		cell.textLabel?.text = caches[indexPath.row]
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		delegate?.didSelectCache(caches[indexPath.row])
	}
}
