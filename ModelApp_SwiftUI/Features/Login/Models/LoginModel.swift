//
//  LoginModel.swift
//  ModelApp_SwiftUI
//
//  Created by Santhosh K on 05/03/26.
//

import Foundation


struct LoginRequest:Codable {
    let email:String
    let password:String
}


struct LoginResponse: Codable {
    let token:String
    let user:User
}

struct User:Codable {
    let id : Int
    let name:String
    let email:String
}

