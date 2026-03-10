//
//  NewsService.swift
//  ModelApp_SwiftUI
//
//  Created by Koneti Santhosh Kumar on 10/03/26.
//

import Foundation

protocol NewsProtocolService {
    func newsResponse() async throws -> NewsModelRes
}


class NewsService: NewsProtocolService {
    
    func newsResponse() async throws -> NewsModelRes {
        let response:NewsModelRes = try await ApiService.shared.request(endURL:APIEndPoint.news.path)
        return response
    }
}
