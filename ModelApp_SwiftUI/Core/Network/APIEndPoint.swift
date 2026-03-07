//
//  APIEndPoint.swift
//  ModelApp_SwiftUI
//
//  Created by Santhosh K on 21/02/26.
//

import Foundation


enum APIEndPoint {
    
    static var baseURL: String = "https://newsapi.org/v2/everything?q=tesla&from=2026-01-27&sortBy=publishedAt&apiKey="
    
    case news
    
    var path:String {
        switch self {
        case .news: return "\(APIEndPoint.baseURL)452aad4896e34de98e566f53f812a39a"
        }
    }
    
}
