//
//  ResourceManagerTests.swift
//  mv
//
//  Created by Anjani on 3/18/17.
//  Copyright © 2017 do. All rights reserved.
//

import XCTest

class ListModuleUnitTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testModel() {
        
        let dictionary = ["urls":["thumb":"abc.com"]]
        let displayItem = PinDisplayItem(dictionary: dictionary)
        
        XCTAssert(displayItem.imageUrl == "abc.com")
    }
    
    func testImageDownloaded() {
        let resourceManager = ResourceManager()
        let urlString = "http://www.freeiconspng.com/uploads/x-png-33.png"
        let expectation = self.expectation(description: "img_download_test")
        
        resourceManager.resource(forURL: urlString, completionHandler: { (data) in
            if data != nil {
                expectation.fulfill()
            }
        }, andSender:self)
        self.waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testService() {
        
        let expectation = self.expectation(description: "list_download")
        var resultList : [PinDisplayItem]? = nil
        ListService.shared.getPinDisplayList(pageNumber: 1) { (list) in
           resultList = list
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 5, handler: {(Void) in
            XCTAssert(resultList != nil)
        })
    }
    
    func testNetworkManager() {
        
        let expectation = self.expectation(description: "network_test")
        let urlString = ""
        NetworkManager.shared.initiateAPIGetCall(urlString: urlString){ (response) in
            if response != nil {
                expectation.fulfill()
            }
        }
        self.waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
