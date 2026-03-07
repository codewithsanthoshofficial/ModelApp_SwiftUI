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
    
    private var isShowingError: Binding<Bool> {
        Binding(get: {
            (viewModel.errorMessage?.isEmpty == false)
        }, set: { newValue in
            if !newValue {
                viewModel.errorMessage = nil
            }
        })
    }
    
    var body: some View {
        
        Group{
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage).foregroundColor(.red).padding()
            }
            
            List(viewModel.newList) { news in
                NewsListView(alrticles: news)
            }
            .task {
                await viewModel.getNews()
            }
        }
        .navigationTitle("News")
        .onAppear {tabBarVisibility?.wrappedValue = false}
        .onDisappear {tabBarVisibility?.wrappedValue = true}
        .alert("Error", isPresented: isShowingError) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(viewModel.errorMessage ?? "Something went wrong")
        }
    }
    
}

#Preview {
    NewsView()
}


struct NewsListView: View {
    
    var alrticles: Articles
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top) {
                AsyncImage(url: URL(string: alrticles.urlToImage ?? "")) { image in
                    image.resizable().clipShape(Circle())
                } placeholder: {
                    Circle().foregroundStyle(.gray)
                }
                .frame(width: 60, height: 60)
                
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Text(alrticles.author ?? "")
                            .bold()
                        Spacer()
                        Text(Date.now.formatted(date: .numeric, time: .omitted))
                            .font(.caption)
                    }
                    Text(alrticles.description ?? "")
                        .font(.subheadline)
                }
            }
        }
        .padding(.vertical, 6)
        //.navigationTitle(item.title)
    }
}

//#Preview {
//    NewsListView(alrticles: Articles(author: "", title: "", description: "", url: "", urlToImage: ""))
//}
