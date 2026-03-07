//
//  LoginService.swift
//  ModelApp_SwiftUI
//
//  Created by Santhosh K on 05/03/26.
//

import Foundation

protocol LoginServiceProtocol {
    func login(request: LoginRequest) async throws -> LoginResponse
}

class LoginService: LoginServiceProtocol {
    
    func login(request: LoginRequest) async throws -> LoginResponse {
        
        let params: [String: Any] = [
            "email": request.email,
            "password": request.password
        ]
        
        let response: LoginResponse = try await ApiService.shared.request(
            endURL: "",
            httpMethod: .POST,
            params: params
        )
        
        return response
    }
}
