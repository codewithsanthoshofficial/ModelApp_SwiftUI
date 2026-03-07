//
//  SettingView.swift
//  ModelApp_SwiftUI
//
//  Created by Santhosh K on 21/02/26.
//

import SwiftUI

struct SettingView: View {
    
    @Binding var isLoggedin:Bool
    @State private var showingLogoutAlert:Bool = false
    
    var body: some View {
            List {
                Section("Account") {
                    Button(role: .destructive) {
                        showingLogoutAlert = true
                    } label: {
                        HStack {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                            Text("Log Out")
                        }
                    }
                }
            }
            .navigationBarTitle("Settings")
            .alert("Logout", isPresented: $showingLogoutAlert) {
                Button("Logout", role: .destructive) {isLoggedin = false}
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("Are you sure want to logout")
            }
    }
}

#Preview {
    SettingView(isLoggedin: .constant(false))
}
