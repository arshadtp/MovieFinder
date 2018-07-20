//
//  AlertUtilities.swift
//  MovieFinder
//
//  Created by Arshad T P on 7/18/18.
//  Copyright © 2018 Ab'initio. All rights reserved.
//

import UIKit

class AlertUtilities {
	 static let requestCanceledByUser = -999
	
	/// Will present and alert view with the given error message.
	///
	/// - Parameters:
	///   - error: <#error description#>
	///   - cancelButtonTitle: <#cancelButtonTitle description#>
	///   - viewController: <#viewController description#>
	class func showErrorAlert(error: Error, cancelButtonTitle: String, inViewController viewController: UIViewController) {
    if  (error as NSError).code ==  requestCanceledByUser { // Don't show error if user cancelled the request
      return
    }
		DispatchQueue.main.async {
			var message = error.localizedDescription
			if let apiError = error as? APIError { // If error is kind of
				message = apiError.message
			}
			let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: nil))
      viewController.present(alert, animated: true)
		}
	}
}
