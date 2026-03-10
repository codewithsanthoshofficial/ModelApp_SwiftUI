//
//  MockNewsService.swift
//  ModelApp_SwiftUITests
//
//  Created by Koneti Santhosh Kumar on 10/03/26.
//

import Foundation
import XCTest
@testable import ModelApp_SwiftUI


class MockNewsService : NewsProtocolService {
    
    var shouldFail = false
    var mockArticles:[Articles] = []
    
    var delayLoading:UInt64 = 0
    
    func newsResponse() async throws -> NewsModelRes {
        
        if delayLoading > 0 {
            try await Task.sleep(nanoseconds: delayLoading)
        }
        
        if shouldFail {
            throw URLError(.badServerResponse)
        }
        
        return NewsModelRes(status: "ok", totalResults: mockArticles.count, articles: mockArticles)
    }
    
}
