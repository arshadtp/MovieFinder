//
//  CommonUtilities.swift
//  MovieFinder
//
//  Created by Arshad T P on 7/18/18.
//  Copyright © 2018 Ab'initio. All rights reserved.
//

import UIKit

class CommonUtilities {
	
	// ---------------
	// MARK: - General
	// ---------------
	
	/// Return the top view controller to the given view controller or to the root window if no view controller given.
	///
	/// - Returns: Top most UIViewController object in the view presenting stack.
	class func getTopViewController(of viewController: UIViewController? = nil) -> UIViewController? {
		if var topController = viewController ?? UIApplication.shared.keyWindow?.rootViewController {
			while let presentedViewController = topController.presentedViewController {
				topController = presentedViewController
			}
			// TopController should now be your topmost view controller
			return topController
		}
		return nil
	}

}
