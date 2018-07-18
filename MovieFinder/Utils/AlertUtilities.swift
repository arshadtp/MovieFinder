//
//  AlertUtilities.swift
//  MovieFinder
//
//  Created by Arshad T P on 7/18/18.
//  Copyright © 2018 Ab'initio. All rights reserved.
//

import UIKit

class AlertUtilities {
	
	
	/// Will present and alert view with the given error message.
	///
	/// - Parameters:
	///   - error: <#error description#>
	///   - cancelButtonTitle: <#cancelButtonTitle description#>
	///   - viewController: <#viewController description#>
	class func showErrorAlert(error: Error, cancelButtonTitle: String, inViewController viewController: UIViewController? = nil) {
    if  (error as NSError).code == -999 { // Don't
      return
    }
		DispatchQueue.main.async {
			var message = error.localizedDescription
			if let apiError = error as? APIError { // If error is kind of
				message = apiError.message
			}
			let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: nil))
			
			if let presentingVC = viewController {
				// presenting the alert on the top view controller
				presentingVC.present(alert, animated: true)
			}
			else if let topViewcontroller = CommonUtilities.getTopViewController() {
				// presenting the alert on the top view controller
				topViewcontroller.present(alert, animated: true)
			}
		}
	}

	
	/// Will present and alert view with the given title, message and names given for the 2 buttons.
	///
	/// - Parameters:
	///   - title: Alert title
	///   - message: Alert message
	///   - cancelButtonTitle: Cancel button title
	class func showAlert(withTitle title: String, message: String, cancelButtonTitle: String, inViewController viewController: UIViewController? = nil) {
		DispatchQueue.main.async {
			let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: nil))
			
			if let presentingVC = viewController {
				// presenting the alert on the top view controller
				presentingVC.present(alert, animated: true)
			}
			else if let topViewcontroller = CommonUtilities.getTopViewController() {
				// presenting the alert on the top view controller
				topViewcontroller.present(alert, animated: true)
			}
		}
	}

}
