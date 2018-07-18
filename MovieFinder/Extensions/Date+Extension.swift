//
//  Date+Extension.swift
//  MovieFinder
//
//  Created by Arshad T P on 7/18/18.
//  Copyright © 2018 Ab'initio. All rights reserved.
//

import Foundation

extension Date {
	
	
	/// Method converts given date to date string in device time zone
	///
	/// - Parameter format: format to be converted
	/// - Returns: date string
	func toString(format: String) -> String? {
		let dateFormatter        = DateFormatter()
		dateFormatter.locale     = Locale.current//Locale(identifier: "en_US")
		dateFormatter.dateFormat = format // Your New Date format as per requirement change it own
		let newDate              = dateFormatter.string(from: self) //pass Date here
		return newDate
	}
	
	
	/// Methods covert date string to Date. This method assumes that date string passed is in GMT
	///
	/// - Parameters:
	///   - dateString: date tring to be converted
	///   - format: date string format
	/// - Returns: returns date
	static func date(from dateString: String, withFormat format : String) -> Date? {
		let dateFormatter        = DateFormatter()
		dateFormatter.dateFormat = format // Your date format
		dateFormatter.locale     = Locale(identifier: "en_US")
		dateFormatter.timeZone   = TimeZone(abbreviation: "GMT+0:00") // Current time zone
		let date                 = dateFormatter.date(from: dateString) // According to date format your date string
		return date
	}

}
