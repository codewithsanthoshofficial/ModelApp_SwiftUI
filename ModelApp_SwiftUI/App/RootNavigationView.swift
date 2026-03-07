//
//  RootNavigationView.swift
//  ModelApp_SwiftUI
//
//  Created by Santhosh K on 24/02/26.
//

import SwiftUI

struct RootNavigationView: View {
    
    //@State private var isLoggedIn:Bool = false
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false
    
    var body: some View {
        Group {
            if isLoggedIn {
                TabBar(isLoggedIn: $isLoggedIn)
            } else {
                LoginView(isLoggedIn: $isLoggedIn)
            }
        }
        .animation(.easeInOut, value: isLoggedIn)
    }
}

#Preview {
    RootNavigationView()
}
