//
//  MovieFinderUITests.swift
//  MovieFinderUITests
//
//  Created by Arshad T P on 7/14/18.
//  Copyright © 2018 Ab'initio. All rights reserved.
//

import XCTest

class MovieFinderUITests: XCTestCase {
  
  var app: XCUIApplication!
  let validSearchTerm = "IP"
  let invalidSearchTerm = "adadadaadadfgtrbfryhfhfhfdfghdfgffdgdfhgdfsfsdgdsfdgd"
  
  override func setUp() {
    super.setUp()
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    continueAfterFailure = false
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    app = XCUIApplication()
    app.launch()
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
  }
  
  override func tearDown() {
    app = nil
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  // -------------------------
  // MARK: - Tests
  // -------------------------

  func testMovieSearchSuccessScenario() {
    tapOnSearchField()
    enterSearchTerm(validSearchTerm)
    tapSearchButton()
    XCTAssert(waitForResultLoading(), "Data does not loaded correctly")
		// Load more test: Scroll to last cell
		
		let table = app.tables.element(boundBy: 0)
		let lastCellIndex = table.cells.count-1

		// Get the coordinate for the bottom of the table view
		let tableBottom = table.coordinate(withNormalizedOffset:CGVector(dx: 0.5, dy: 1.0))
		
		// Scroll from tableBottom to new coordinate
		let scrollVector = CGVector(dx: 0.0, dy: -30.0) // Use whatever vector you like
		tableBottom.press(forDuration: 0.5, thenDragTo: tableBottom.withOffset(scrollVector))

		
//		let lastCell = table.cells.element(boundBy:lastCellIndex)
//		table.scrollToElement(element: lastCell)
		// wait loads next cell
		let loadedNewCell = table.cells.element(boundBy:lastCellIndex+3).waitForExistence(timeout: 10)
		XCTAssert(loadedNewCell, "Loaded new cell")


  }
  
  func testMovieSearchFailureScenarioWithInvalidQuery() {
    tapOnSearchField()
    enterSearchTerm(invalidSearchTerm)
    tapSearchButton()
    XCTAssert(isErrorShowed(), "Alert didn't showed correctly")
		
  }
  
  func testIfSearchQueryCachedOnSuccess()  {
    tapOnSearchField()
    enterSearchTerm("Ip Man")
    tapSearchButton()
    waitForResultLoading()
    tapOnSearchField()
    let isCached = app.tables["cache_list"].cells.firstMatch.staticTexts["Ip Man"].exists
    XCTAssert(isCached, "Search didn't cached")
  }
  
  func testIfSearchQueryCachedOnFailure()  {
    tapOnSearchField()
    enterSearchTerm(invalidSearchTerm)
    tapSearchButton()
    waitForResultLoading()
    tapOnSearchField()
    let isCached = app.tables["cache_list"].cells.firstMatch.staticTexts[invalidSearchTerm].exists
    XCTAssert(!isCached, "Search term cached on failure")
  }
  // -------------------------
  // MARK: - Helper methods
  // -------------------------

  @discardableResult
  func waitForResultLoading() -> Bool {
    return app.tables.cells.firstMatch.waitForExistence(timeout: 10)
  }
  
  func isErrorShowed() -> Bool {
    return app.alerts["Error"].waitForExistence(timeout: 10)
  }
  
  func tapOnSearchField() {
    let searchField = app.searchFields["Search Movies"]
    searchField.tap()
  }
  
  func enterSearchTerm(_ term: String)  {
    let searchField = app.searchFields["Search Movies"]
    searchField.typeText(term)
    
  }
  
  func tapSearchButton() {
    app/*@START_MENU_TOKEN@*/.buttons["Search"]/*[[".keyboards.buttons[\"Search\"]",".buttons[\"Search\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
  }
  
}

extension XCUIElement {
	
	func scrollToElement(element: XCUIElement) {
		while !element.visible() {
			swipeUp()
		}
	}
	
	func visible() -> Bool {
		guard self.exists && !(self.frame).isEmpty else { return false }
		return XCUIApplication().windows.element(boundBy: 0).frame.contains(self.frame)
	}
	
}

