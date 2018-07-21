//
//  AtomicBool.swift
//  MovieFinder
//
//  Created by Arshad T P on 7/15/18.
//  Copyright © 2018 Ab'initio. All rights reserved.
//

import Foundation


/// Generic type whose value is atomic
let q = DispatchQueue(label: "print")

struct AtomicType <T> {
	
	private var semaphore = DispatchSemaphore(value: 1)
	private var b: T
	init(_ type: T) {
		b = type
	}
	var val: T  {
		get {
			semaphore.wait()
			let tmp = b
			semaphore.signal()
			return tmp
		}
		set {
			semaphore.wait()
			b = newValue
			semaphore.signal()
		}
	}
	
}
