//
//  StampytUITests.swift
//  StampytUITests
//
//  Created by Pierre on 17/09/2018.
//  Copyright © 2018 Pierre. All rights reserved.
//

import XCTest

class StampytUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // Test en appuyant sur le bouton annuler lors de la prise de la première photo
    func testCancelFirstPicture() {
        
        let app = XCUIApplication()
        app.buttons["camera button"].tap()
        app.buttons["Annuler"].tap()
        
    }
    
    // Test en appuyant sur le bouton annuler lors de la prise de la deuxième photo
    func testCancelSecondPicture() {
        
        let app = XCUIApplication()
        let cameraButtonButton = app.buttons["camera button"]
        cameraButtonButton.tap()
        sleep(1) // Temps de réflexion de l'utilisateur avant validation
        app.buttons["Valider"].tap()
        cameraButtonButton.tap()
        app.buttons["Annuler"].tap()
        
    }
    
    // Test lors de l'appuie sur Annuler au moment de l'envoi
    func testCancelSending() {
        
        let app = XCUIApplication()
        let button = app.buttons["camera button"]
        button.tap()
        
        sleep(1) // Temps de réflexion de l'utilisateur avant validation
        let validerButton = app.buttons["Valider"]
        validerButton.tap()
        button.tap()
        
        sleep(1) // Temps de réflexion de l'utilisateur avant validation
        validerButton.tap()
        app.buttons["Annuler"].tap()

    }
    
    // Test la navigation entre les photos avant l'envoi
    func testArrows() {
        
        let app = XCUIApplication()
        let button = app.buttons["camera button"]
        button.tap()
        
        sleep(1) // Temps de réflexion de l'utilisateur avant validation
        let validerButton = app.buttons["Valider"]
        validerButton.tap()
        button.tap()
        
        sleep(1) // Temps de réflexion de l'utilisateur avant validation
        validerButton.tap()
        
        app.buttons["right arrow"].tap()
        app.buttons["left arrow"].tap()
        
    }
    
    // Test l'envoi de photo
    func testSendPicture() {
        
        let app = XCUIApplication()
        let button = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .button).element
        button.tap()
        
        let validerButton = app.buttons["Valider"]
        sleep(1) // Temps de réflexion de l'utilisateur avant validation
        validerButton.tap()
        button.tap()
        
        sleep(1) // Temps de réflexion de l'utilisateur avant validation
        validerButton.tap()
        
        app.buttons["Envoyer"].tap()
        
    }
    
}
