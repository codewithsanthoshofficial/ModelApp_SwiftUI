//
//  ApiServiceTests.swift
//  ModelApp_SwiftUITests
//
//  Created by Santhosh K on 06/03/26.
//

import XCTest
@testable import ModelApp_SwiftUI


@MainActor
final class ApiServiceTests: XCTestCase {
    
    var apiservice:ApiService!
    
    override func setUp() {
        super.setUp()
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        
        let session = URLSession(configuration: config)
        apiservice = ApiService(session: session)
    }
    
    override func tearDown() {
        apiservice = nil
        MockURLProtocol.mockData = nil
        MockURLProtocol.mockResponse = nil
        MockURLProtocol.mockError = nil
        MockURLProtocol.lastRequest = nil
        super.tearDown()
    }
    
    func testRequestSuccess() async throws {
        
        let json =
        """
        {
            "token":"abc123",
            "user":{
                "id":1,
                "name":"Test User",
                "email":"test@mail.com"
            }
        }
        """
        
        MockURLProtocol.mockData = json.data(using: .utf8)
        
        MockURLProtocol.mockResponse = HTTPURLResponse(
            url: URL(string: "https://test.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        
        let response: LoginResponse = try await apiservice.request( endURL: "https://test.com", httpMethod: .POST)
        
        XCTAssertEqual(response.token, "abc123")
        XCTAssertEqual(response.user.name, "Test User")
    }
    
    
    func testServerError() async {
        
        MockURLProtocol.mockResponse = HTTPURLResponse(
            url: URL(string: "https://test.com")!,
            statusCode: 500,
            httpVersion: nil,
            headerFields: nil
        )
        
        do {
            
            let _: LoginResponse = try await apiservice.request(
                endURL: "https://test.com"
            )
            
            XCTFail("Expected server error")
            
        } catch NetworkError.serverError(let code) {
            
            XCTAssertEqual(code, 500)
            
        } catch {
            
            XCTFail("Unexpected error")
        }
    }
    
    
//    func testInvalidURL() async {
//
//        do {
//
//            let _: LoginResponse = try await apiservice.request(
//                endURL: "invalid_url"
//            )
//
//            XCTFail("Expected invalidURL")
//
//        } catch NetworkError.invalidURL {
//
//            XCTAssertTrue(true)
//
//        } catch {
//
//            XCTFail("Unexpected error")
//        }
//    }
//    

    
    func testInvalidURL() async {

        do {
            let _: LoginResponse = try await apiservice.request(endURL: "")
            XCTFail("Expected invalidURL")

        } catch NetworkError.invalidURL {
            XCTAssertTrue(true)

        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    
    func testDecodingError() async {

        let invalidJSON = """
        { "invalid":"structure" }
        """

        MockURLProtocol.mockData = invalidJSON.data(using: .utf8)

        MockURLProtocol.mockResponse = HTTPURLResponse(
            url: URL(string: "https://test.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )

        do {

            let _: LoginResponse = try await apiservice.request(
                endURL: "https://test.com"
            )

            XCTFail("Expected decoding error")

        } catch NetworkError.decodingError {

            XCTAssertTrue(true)

        } catch {

            XCTFail("Unexpected error")
        }
    }
    
    
    func testNetworkFailure() async {

        MockURLProtocol.mockError = URLError(.notConnectedToInternet)

        do {

            let _: LoginResponse = try await apiservice.request(
                endURL: "https://test.com"
            )

            XCTFail("Expected network error")

        } catch {

            XCTAssertTrue(true)
        }
    }
}


struct DummyResponse: Codable {}

extension ApiServiceTests {
    //Verify GET parameters are added correctly.
    func testHTTPMethodPOST() async throws {

        MockURLProtocol.mockData = "{}".data(using: .utf8)

        MockURLProtocol.mockResponse = HTTPURLResponse(
            url: URL(string: "https://test.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )

        let _: DummyResponse = try await apiservice.request(
            endURL: "https://test.com",
            httpMethod: .POST
        )

        XCTAssertEqual(MockURLProtocol.lastRequest?.httpMethod, "POST")
    }
    
  
    
    //Verify GET parameters are added correctly.
    func testQueryParameters() async throws {

        MockURLProtocol.mockData = "{}".data(using: .utf8)

        MockURLProtocol.mockResponse = HTTPURLResponse(
            url: URL(string: "https://test.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )

        let _: DummyResponse = try await apiservice.request(
            endURL: "https://test.com",
            httpMethod: .get,
            params: ["page":1,"limit":10]
        )

        let url = MockURLProtocol.lastRequest?.url?.absoluteString

        XCTAssertTrue(url?.contains("page=1") ?? false)
        XCTAssertTrue(url?.contains("limit=10") ?? false)
    }
    
    func testHeaders() async throws {

        MockURLProtocol.mockData = "{}".data(using: .utf8)

        MockURLProtocol.mockResponse = HTTPURLResponse(
            url: URL(string: "https://test.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )

        let _: DummyResponse = try await apiservice.request(
            endURL: "https://test.com",
            header: ["Authorization":"Bearer token"]
        )

        let header = MockURLProtocol.lastRequest?
            .value(forHTTPHeaderField: "Authorization")

        XCTAssertEqual(header, "Bearer token")
    }
    
    
    func testJSONBody() async throws {

        MockURLProtocol.mockData = "{}".data(using: .utf8)

        MockURLProtocol.mockResponse = HTTPURLResponse(
            url: URL(string: "https://test.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )

        let params = [
            "email":"test@mail.com",
            "password":"123456"
        ]

        let _: DummyResponse = try await apiservice.request(
            endURL: "https://test.com",
            httpMethod: .POST,
            params: params
        )

        let body = MockURLProtocol.lastRequest?.httpBody

        XCTAssertNotNil(body)
    }
    
}
