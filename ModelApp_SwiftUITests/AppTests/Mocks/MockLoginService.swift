
import Foundation
@testable import ModelApp_SwiftUI


class MockLoginService: LoginServiceProtocol {
    
    var shouldFail = false
    
    func login(request: LoginRequest) async throws -> LoginResponse {
        
        if shouldFail {
            throw URLError(.badServerResponse)
        }
        
        return LoginResponse(token: "mock_token", user: User(id: 1, name: "Test User", email: request.email))
    }
}
































//import Foundation
//
//final class MockLoginService: LoginServiceProtocol {
//    // Configure these in tests to control outcomes
//    var shouldSucceed: Bool = true
//    var errorToThrow: Error?
//
//    enum MockError: Error { case forcedFailure }
//
//    init(shouldSucceed: Bool = true, errorToThrow: Error? = nil) {
//        self.shouldSucceed = shouldSucceed
//        self.errorToThrow = errorToThrow
//    }
//
//    func login(username: String, password: String) async throws -> Bool {
//        if let error = errorToThrow {
//            throw error
//        }
//        if shouldSucceed {
//            return true
//        } else {
//            throw MockError.forcedFailure
//        }
//    }
//}


