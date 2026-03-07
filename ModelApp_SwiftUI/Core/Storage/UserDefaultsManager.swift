//
//  UserDefaultsManager.swift
//  ModelApp_SwiftUI
//
//  Created by Santhosh K on 05/03/26.
//

import Foundation


private enum Keys {
    static let isLoggedIn = "isLoggedIn"
    static let userid = "user_id"
}

class UserDefaultsManager {
    
    private let defaults = UserDefaults.standard
    
    func saveLoginStatus(_ value: Bool) {
        defaults.set(value, forKey: Keys.isLoggedIn)
    }
    
    func getLoginStatus() -> Bool {
        defaults.bool(forKey: Keys.isLoggedIn)
    }
    
    func saveUserID(_ userid: String) {
        defaults.set(userid, forKey: Keys.userid)
    }
    
    func getUserID() -> String? {
        defaults.string(forKey: Keys.userid)
    }
}
