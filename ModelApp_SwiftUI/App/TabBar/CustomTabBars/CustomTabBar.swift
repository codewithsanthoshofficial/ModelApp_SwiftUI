//
//  CustomTabBar.swift
//  ModelApp_SwiftUI
//
//  Created by Santhosh K on 24/02/26.
//

import SwiftUI


struct CustomTabBar: View {
    @Binding var selectedTab: AppTab

    var body: some View {
        HStack {
            ForEach([AppTab.home, .settings], id: \.self) { tab in
                Spacer()
                VStack(spacing: 4) {
                    Image(systemName: tab == .home ? "house.fill" : "gearshape.fill")
                        .font(.system(size: 24))
                    Text(tab == .home ? "Home" : "Settings")
                        .font(.caption2)
                }
                .foregroundColor(selectedTab == tab ? .yellow : .gray)
                .onTapGesture {
                    withAnimation(.spring()) {
                        selectedTab = tab
                    }
                }
                Spacer()
            }
        }
        .frame(height: 60)
        .background(Color.black.opacity(0.9))
        .clipShape(Capsule())
        .padding(.horizontal, 30)
        .padding(.bottom, 20) // Floating effect
    }
}


//#Preview {
//    CustomTabBar(selectedTab: .constant(AppTab.home))
//}

















/*
 
 import SwiftUI

 enum AppTab: Hashable, CaseIterable {
     case home
     case settings
 }


 struct TabBar: View {
     
     @Binding var isLoggedIn: Bool
     @State private var selectedTab: AppTab = .home
     @State private var navigationPath = NavigationPath()
     
     var body: some View {
         NavigationStack(path: $navigationPath) {
             
             ZStack(alignment: .bottom) {
                 // Switch root view manually
                 switch selectedTab {
                 case .home:
                     HomeView()
                 case .settings:
                     SettingView(isLoggedin: $isLoggedIn)
                 }
                 
                 // Hide tab bar when pushed
                 if navigationPath.isEmpty {
                     CustomTabBar(selectedTab: $selectedTab)
                 }
             }
             .navigationDestination(for: MenuItem.self) { item in
                 if item.title == "News API" {
                     NewsView()
                 } else {
                     DetailView(item: item)
                 }
             }
         }
     }
 }

 
 */
