//
//  LoginView.swift
//  ModelApp_SwiftUI
//
//  Created by Santhosh K on 21/02/26.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject private var viewmodel = LoginViewModel()
    @Binding var isLoggedIn: Bool
    
    private var buttonTitle: String { viewmodel.isLoginScreen ? "Log In" : "Sign up" }
    
    var body: some View {
        NavigationStack {
            ZStack {
                //Background Gradient
                LinearGradient(colors: [Color.yellow.opacity(0.4), .white], startPoint: .top, endPoint: .center)
                    .ignoresSafeArea()
                
                VStack(spacing:25){
                    //Header
                    VStack(spacing:8) {
                        Text("Hello,\nWelcome back!")
                            .font(.system(size: 32, weight: .bold))
                            .multilineTextAlignment(.center)
                        Text("Please enter your email and password details to access your account.")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                    }
                    .padding(.top, 40)
                    
                    //Main Card
                    SegmentButton(isLogin: $viewmodel.isLoginScreen)
                    
                    
                    VStack(spacing: 15) {
                        if  !viewmodel.isLoginScreen {
                            InputField(icon: "person", placeholder: "Name", text: $viewmodel.name, isError: viewmodel.showError && viewmodel.name.isEmpty, textIdentifier: "nameTextField")
                            
                        }
                        
                        InputField(icon: "envelope", placeholder: "Email Address", text: $viewmodel.email, isError: viewmodel.showError && viewmodel.isEmailInvalid, textIdentifier: "emailTextField")
                            .accessibilityIdentifier("emailTextField")
                    }
                    
                    VStack(alignment: .trailing) {
                        InputField(icon: "lock", placeholder: "Password", text: $viewmodel.password, isSecure: true, isError: viewmodel.showError && viewmodel.password.count < 6, textIdentifier: "passwordTextField")
                            .accessibilityIdentifier("passwordTextField") // <--- Add this
                        
                        
                        
                        Button("Forgot Password") {
                            print("Forgot password")
                        }
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .padding(.top, 5)
                        .padding(.horizontal, 40)
                    }
                    
                    if viewmodel.showError {
                        Text(viewmodel.errorMessage)
                            .font(.caption)
                            .foregroundStyle(.red)
                            .multilineTextAlignment(.center)
                            .accessibilityIdentifier("errorMessage")
                    }
                    
                    Button {
                        Task {
                            await viewmodel.login()
                            viewmodel.loginSuccess = true
                            if viewmodel.loginSuccess {
                                isLoggedIn = true
                            }
                        }
                    } label: {
                        Text(buttonTitle)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.black)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .padding(20)
                    }
                    .accessibilityIdentifier("loginButton")
                }
            }
            
        }
    }
}

#Preview {
    LoginView(isLoggedIn: .constant(false))
}

