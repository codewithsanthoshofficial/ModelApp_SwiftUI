//
//  NewsViewModel.swift
//  ModelApp_SwiftUI
//
//  Created by Santhosh K on 21/02/26.
//

import SwiftUI
import Combine


//class NewsViewModel:ObservableObject {
//    @Published var news: [Articles] = []
//    
////    init() {
////        Task {
////            do {
////                try await fetchNews()
////            } catch {
////                print("Failed to fetch news: \(error)")
////            }
////        }
////    }
//    
//    func fetchNews() async throws {
//        
//        do {
//            let response:NewsModelRes = try await ApiService.shared.request(endURL: APIEndPoint.news.path, httpMethod: .get)
//            self.news = response.articles
//        }
//        catch {
//            print("API Failed to load news")
//        }
//        
//        
//    }
//    
//}


import Foundation


class NewsViewModel:ObservableObject {
    
    @Published var newList:[Articles] = []
    @Published var errorMessage: String?
    
    init() {
//        Task {await self.getNews()}
    }
    
    @MainActor
    func getNews() async {
        do {
            let response:NewsModelRes = try await ApiService.shared.request(endURL:APIEndPoint.news.path)
            self.newList = response.articles
            print(self.newList.count)
        }
        catch {
            self.errorMessage = "Request failed:\(error)"
        }
    }
}

