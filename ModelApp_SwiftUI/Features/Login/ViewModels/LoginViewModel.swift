//
//  LoginViewModel.swift
//  ModelApp_SwiftUI
//
//  Created by Santhosh K on 05/03/26.
//

import Foundation
import Combine


@MainActor
class LoginViewModel: ObservableObject {
    
    @Published var email:String = ""
    @Published var password:String = ""
    @Published var name:String = ""
    
    @Published var isLoginScreen = true
    @Published var isLoading = false
    @Published var showError = false
    @Published var errorMessage = ""
    @Published var loginSuccess = false
    
    
    private let service: LoginServiceProtocol
    
    init(service: LoginServiceProtocol) {
        self.service = service
    }
    
    convenience init() {
        self.init(service: LoginService())
    }
    
    var isEmailInvalid: Bool {
        email.isEmpty || !email.contains("@")
    }
    
    func validate() -> Bool {
        
        showError = false
        
        if !isLoginScreen && name.trimmingCharacters(in: .whitespaces).isEmpty {
            errorMessage = "Please enter your name."
            showError = true
            return false
        }
        
        if email.isEmpty || isEmailInvalid {
            errorMessage = "Please enter a valid email."
            showError = true
            return false
        }
        
        if password.count < 6 {
            errorMessage = "Password must be at least 6 characters."
            showError = true
            return false
        }
        
        return true
    }
    
}

extension LoginViewModel {
    
    func login() async {
        
        guard validate() else { return }
        isLoading = true
        
        do {
            let response = try await service.login(request: LoginRequest(email: email, password: password))
            print(response.token)
            loginSuccess = true
            isLoading = false
        } catch {
            isLoading = false
            errorMessage = "Login Failed"
            showError = true
        }
    }
}
