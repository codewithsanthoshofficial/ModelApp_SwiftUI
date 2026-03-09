//
//  ModelApp_SwiftUIUITests.swift
//  ModelApp_SwiftUIUITests

//  Created by Santhosh K on 21/02/26.

import XCTest

final class ModelApp_SwiftUIUITests: XCTestCase {
    
    var app : XCUIApplication!

    override func setUpWithError() throws {
        // Stop immediately if a failure occurs
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }
    
    func testLoginValidationError() {
        let loginButton = app.buttons["loginButton"]
        
        // Ensure button exists before tapping
        XCTAssertTrue(loginButton.exists, "The login button should be visible.")
        loginButton.tap()

        // Wait for the error message to appear in the hierarchy
        let errorMessage = app.staticTexts["errorMessage"]
        XCTAssertTrue(errorMessage.waitForExistence(timeout: 2), "Error message should appear on invalid login attempt.")
    }
    

    @MainActor
    func testLoginFlow() {
        let emailField = app.textFields["emailTextField"]
        let passwordField = app.secureTextFields["passwordTextField"]
        let loginButton = app.buttons["loginButton"]
        
        XCTAssertTrue(emailField.exists)
        emailField.tap()
        emailField.typeText("test@mail.com")
        
        XCTAssertTrue(passwordField.exists)
        passwordField.tap()
        passwordField.typeText("123456")
        
        loginButton.tap()
        // Optional: If login triggers a change, assert the change here
    }
    
    func testLoginNavigatesToHome() {
        
        let emailField = app.textFields["emailTextField"]
        let passwordField = app.secureTextFields["passwordTextField"]
        let loginButton = app.buttons["loginButton"]
        
        emailField.tap()
        emailField.typeText("test@mail.com")
        
        passwordField.tap()
        passwordField.typeText("123456")
        
        // Dismiss keyboard if it's blocking the button
        if app.keyboards.element.exists {
            app.buttons["Return"].tap()
        }
        
        loginButton.tap()
        
        
        // 1. Look for the Navigation Bar named "Home"
        let navBar = app.navigationBars["Home"]
        
        // 2. Wait for the bar to appear (allows for transition animation)
        XCTAssertTrue(navBar.waitForExistence(timeout: 5), "Navigation bar with title 'Home' not found.")
        
        // 3. If you specifically need the text element inside the bar:
        let homeTitleText = navBar.staticTexts["Home"]
        XCTAssertTrue(homeTitleText.exists)
    }
}


//UI_Test Added
