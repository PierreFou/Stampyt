//
//  StampytTests.swift
//  StampytTests
//
//  Created by Pierre on 17/09/2018.
//  Copyright © 2018 Pierre. All rights reserved.
//

import XCTest
@testable import Stampyt

class StampytTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBody() {
        let imageDetails = ShootingService.shared.createImagesDetails(numberOfPhoto: 1)
        let body = ShootingService.shared.createBody(withImageDetails: imageDetails)
        
        var correctBody = true
        
        for key in body.keys {
            correctBody = correctBody && key.contains(Constants.Web.ParameterOriginal) ||
                key.contains(Constants.Web.ParameterStamped) ||
                key.contains(Constants.Web.ParameterProcesses) ||
                key.contains(Constants.Web.ParameterImagesDetails)
        }
        
        XCTAssertTrue(correctBody, "Le body est incorrect")
    }
    
}
