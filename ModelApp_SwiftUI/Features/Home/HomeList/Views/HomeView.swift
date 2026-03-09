//
//  HomeView.swift
//  ModelApp_SwiftUI
//
//  Created by Santhosh K on 21/02/26.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewmodel:HomeViewModel
    
    init(viewmodel: HomeViewModel = HomeViewModel()) {
        _viewmodel = StateObject(wrappedValue: viewmodel)
    }
    
    @ViewBuilder
    private func destinationView(for item: MenuItem) -> some View {
        if item.title == "News API" {
            NewsView()
        } else {
            DetailView(item: item)
        }
    }
    
    
    var body: some View {
        
        List {
            ForEach(viewmodel.sections) { (section: MenuSection) in
                Section(section.title) {
                    ForEach(section.items) { (item: MenuItem) in
                        NavigationLink(destination: destinationView(for: item)) {
                            Text(item.title)
                        }
                    }
                }
            }
        }
        .navigationTitle("Home")
        .accessibilityIdentifier("homeTitle")
        .safeAreaInset(edge: .bottom) {
            Color.clear.frame(height: 80)
        }
    }
    
}


#Preview {
    HomeView()
}

