# MovieFinder

Introduction
---------

MovieFinder is simple app which can be used to search movies. App cahces users last 10 successful search to make is easily accessible.

Architecture
--------
* MVVM pattern is followed.
**Model
****MovieListModel
* App has a seperate Network layer

Unit Tests
--------
* App has unit testing with ```95% code converage```.
* UI and Unit test have been implemented.

Features
-------
* Universal app
* Orientation Support

Libraries Used
-------

* Alamofire: For handling webservice calls
* ObjectMapper: Mapping JSON to object
* SDWebImage: Image loading and Disk image caching.

Steps to Run 
-------

* App uses COCOAPODS as dependency manager. Please install if it your first time [Install COCOAPODS](http://cocoapods.org)
* Open terminal, cd to project root directory (Directory which contains Podfile). Then run ```pod install``` command
* Download the project and open file ```MovieFinder.xcworkspace``` in XCode. 
* Compile and run the app.
