//
//  NewsViewModel.swift
//  ModelApp_SwiftUI
//
//  Created by Santhosh K on 21/02/26.
//

import SwiftUI
import Combine


class NewsViewModel:ObservableObject {
    
    //    @Published var newList:[Articles] = []
    //    @Published var errorMessage: String?
    //    @Published var isLoading = false
    
    @Published var state: NewsViewState = .idle
    private let service:NewsProtocolService
    
    init (service : NewsProtocolService = NewsService()) {
        self.service = service
    }
    
    func loadNews() async {
        await getNews()
    }
    
    @MainActor
    func getNews() async {
        
        state = .loading
        
        do {
            let response:NewsModelRes = try await service.newsResponse()
            state = .success(response.articles)
            //self.newList = response.articles
            //print(self.newList.count)
        }
        catch {
            // self.errorMessage = "Request failed:\(error)"
            state = .error("Request failed:\(error)")
        }
    }
}




enum NewsViewState {
    case idle
    case loading
    case success([Articles])
    case error(String)
}


extension NewsViewState {

    var articles: [Articles] {
        if case .success(let articles) = self {
            return articles
        }
        return []
    }

    var errorMessage: String? {
        if case .error(let message) = self {
            return message
        }
        return nil
    }

    var isLoading: Bool {
        if case .loading = self {
            return true
        }
        return false
    }
}

