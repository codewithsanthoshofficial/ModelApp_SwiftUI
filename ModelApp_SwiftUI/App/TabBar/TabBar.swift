//
//  TabBar.swift
//  ModelApp_SwiftUI
//
//  Created by Santhosh K on 21/02/26.
//

import SwiftUI

 enum AppTab: Hashable, CaseIterable {
     case home
     case settings
 }

 //Default Tabbar + Custom

 struct TabBar: View {
     @Binding var isLoggedIn: Bool
     @State private var selectedTab: AppTab = .home
     @State private var showTabBar: Bool = true
     
     
     var body: some View {
         ZStack(alignment: .bottom) {
             TabView(selection: $selectedTab) {
                 NavigationStack { HomeView() }
                     .tag(AppTab.home)
                     .toolbar(.hidden, for: .tabBar)
                 
                 NavigationStack { SettingView(isLoggedin: $isLoggedIn ) }
                     .tag(AppTab.settings)
                     .toolbar(.hidden, for: .tabBar)
             }
             .ignoresSafeArea(.keyboard, edges: .bottom)
             
             if showTabBar {
                 CustomTabBar(selectedTab: $selectedTab)
             }
         }
         .animation(nil, value: showTabBar)
         .environment(\.tabBarVisibility, $showTabBar)
     }
 }

 #Preview {
     TabBar(isLoggedIn: .constant(false))
 }




 struct TabBarVisibilityKey: EnvironmentKey {
     static let defaultValue: Binding<Bool>? = nil
 }

 extension EnvironmentValues {
     var tabBarVisibility: Binding<Bool>? {
         get { self[TabBarVisibilityKey.self] }
         set { self[TabBarVisibilityKey.self] = newValue }
     }
 }

