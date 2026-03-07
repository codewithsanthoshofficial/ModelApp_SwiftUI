//
//  ApiService.swift
//  ModelApp_SwiftUI
//
//  Created by Santhosh K on 21/02/26.
//

import Foundation


enum HttpMethod: String {
    case get = "GET"
    case POST
}

enum NetworkError:Error  {
    case invalidURL
    case serverError(Int)
    case unknown
    case decodingError(Error)
}


//protocol ApiService {
//    func fetchData<T:Decodable>(_ request:URLRequest,type:T.Type,completion:@escaping (Result<T,NetworkError>)->())
//}

class ApiService {
    
    static let shared = ApiService()
    private let session:URLSession
    
    internal init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T:Codable>(endURL:String, httpMethod:HttpMethod? = .get, params:[String:Any]? = nil, header:[String:String]? = nil) async throws -> T {
        
        guard var urlcomponents = URLComponents(string: endURL) else {throw NetworkError.invalidURL}
        
        if httpMethod == .get, let params {
            urlcomponents.queryItems = params.map {
                URLQueryItem(name: $0.key, value: "\($0.value)")
            }
        }
        guard let url = urlcomponents.url else {throw NetworkError.invalidURL}
        var urlrequest = URLRequest(url: url)
    
        if httpMethod != .get , let params {
            urlrequest.httpBody = try JSONSerialization.data(withJSONObject: params)
            urlrequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        urlrequest.httpMethod = httpMethod?.rawValue
        header?.forEach {
            urlrequest.addValue("\($0.value)", forHTTPHeaderField: $0.key)
        }
        
        let (data,response) = try await session.data(for: urlrequest)
        
        guard let httpresponse = response as? HTTPURLResponse else {throw NetworkError.unknown}
        guard (200...299).contains(httpresponse.statusCode) else {throw NetworkError.serverError(httpresponse.statusCode)}
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            print(try JSONSerialization.jsonObject(with: data))
            return try decoder.decode(T.self, from: data)
        }
        catch {
            throw NetworkError.decodingError(error)
        }
  
    }

}
