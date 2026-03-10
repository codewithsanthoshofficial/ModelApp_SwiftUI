//
//  NewsModel.swift
//  ModelApp_SwiftUI
//
//  Created by Santhosh K on 21/02/26.
//

import Foundation


struct NewsModelRes: Codable {
    
    var status = String()
    var totalResults:Int
    var articles:[Articles]
    
    enum CodingKeys: String, CodingKey {
        case status
        case totalResults
        case articles
    }
}


struct Articles:Codable, Identifiable {
    var id: String { url ?? UUID().uuidString }
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    
    enum CodingKeys: String, CodingKey {
        
        case author
        case title
        case description
        case url
        case urlToImage
    }
}
