//
//  NewsView.swift
//  ModelApp_SwiftUI
//
//  Created by Santhosh K on 21/02/26.
//

import SwiftUI

struct NewsView: View {
    
    @Environment(\.tabBarVisibility) var tabBarVisibility
    @StateObject var viewModel = NewsViewModel()
    

    var body: some View {
        
        ZStack {
            List(viewModel.state.articles) { news in
                NewsListView(alrticles: news)
            }
        }
        .task {
           await  viewModel.loadNews()
        }
        .navigationTitle("News")
        .onAppear {tabBarVisibility?.wrappedValue = false}
        .onDisappear {tabBarVisibility?.wrappedValue = true}
        .overlay {
            if viewModel.state.isLoading {ProgressView("Loading View....")}
        }
        .alert(
            "Error",
            isPresented:
                Binding(
                get: { viewModel.state.errorMessage != nil },
                set: { _ in viewModel.state = .idle }
            )
        ) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(viewModel.state.errorMessage ?? "")
        }
    }
    
}

#Preview {
    NewsView()
}

