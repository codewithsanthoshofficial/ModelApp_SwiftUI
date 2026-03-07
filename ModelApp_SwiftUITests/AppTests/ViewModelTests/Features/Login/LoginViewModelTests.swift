//
//  LoginViewModelTests.swift
//  ModelApp_SwiftUITests
//
//  Created by Santhosh K on 05/03/26.
//

import XCTest
@testable import ModelApp_SwiftUI

@MainActor
final class LoginViewModelTests: XCTestCase {

    var viewModel:LoginViewModel!
    var mockService:MockLoginService!
    
    
    override func setUp() {
        super.setUp()
        mockService = MockLoginService()
        viewModel = LoginViewModel(service: mockService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }
    
    func testValidationFailWithEmptyEmail() {
        viewModel.email = ""
        viewModel.password = "1234"
        let result = viewModel.validate()
        
        XCTAssertFalse(result)
        XCTAssertTrue(viewModel.showError)
    }
    
    func testValidationFailsWithInvalidEmail() {
        viewModel.email = "t"
        viewModel.password = "1234"
        let result = viewModel.validate()
        
        XCTAssertFalse(result)
        XCTAssertTrue(viewModel.showError)
    }
    
    func testValidationSuccess() {
        viewModel.email = "test@mail.com"
        viewModel.password = "1234567"
        
        let result = viewModel.validate()
        XCTAssertTrue(result)
    }
    
    
    func testValidationFailsWithShortPassword() {
        viewModel.email = "test@mail.com"
        viewModel.password = "123"
        
        let result = viewModel.validate()
        XCTAssertFalse(result)
        XCTAssertTrue(viewModel.showError)
    }
    
    func testValidationFailsWithEmptyNameInSignup() {
        viewModel.isLoginScreen = false
        viewModel.name = ""
        viewModel.email = "test@mail.com"
        viewModel.password = "123456"
        
        let result = viewModel.validate()
        XCTAssertFalse(result)
        XCTAssertTrue(viewModel.showError)
    }
    
    
    func testLoadingStateDuringLogin() async {
        viewModel.email = "test@mail.com"
        viewModel.password = "123456"

        await viewModel.login()

        XCTAssertFalse(viewModel.isLoading)
    }
 
        
    func testLoginFailure() async  {
        mockService.shouldFail = true
        viewModel.email = "test@mail.com"
        viewModel.password = "1234567"
        
        await viewModel.login()
        XCTAssertTrue(viewModel.showError)
    }
    
    
    func testLoginSuccess() async {
        mockService.shouldFail = false
        viewModel.email = "test@mail.com"
        viewModel.password = "123456"
        
        await viewModel.login()
        XCTAssertFalse(viewModel.showError)
    }

}
