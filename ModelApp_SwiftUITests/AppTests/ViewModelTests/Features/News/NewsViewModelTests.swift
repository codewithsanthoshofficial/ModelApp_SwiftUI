//
//  NewsViewModelTests.swift
//  ModelApp_SwiftUITests
//
//  Created by Koneti Santhosh Kumar on 10/03/26.
//

import XCTest
@testable import ModelApp_SwiftUI

@MainActor
final class NewsViewModelTests: XCTestCase {
    
    var viewModel:NewsViewModel!
    var mockService:MockNewsService!
    
    override func setUp() {
        super.setUp()
        mockService = MockNewsService()
        viewModel = NewsViewModel(service: mockService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }
    
    
    func testsFechNewsSuccess() async {
        let article = Articles(author: "santhosh", title: "Test Title", description: "Test Desc", url: "test.com", urlToImage: nil)
        
        mockService.mockArticles = [article]
        await viewModel.loadNews()
        XCTAssertEqual(viewModel.state.articles.count, 1)
    }
    
    
    func testsFetchNewsFailure() async {
        mockService.shouldFail = true
        await viewModel.loadNews()
        XCTAssertNotNil(viewModel.state.errorMessage)
    }
    
    func testLoadingState() async {
        
        mockService.delayLoading = 2_000_000_000 //2sec
        Task {
            await viewModel.loadNews()
        }
        
        try? await Task.sleep(nanoseconds: 100_000_000)
        XCTAssertTrue(viewModel.state.isLoading)
    }
}



// Performance Test measures

extension NewsViewModelTests {
    //Basic Performance Test (Execution Time)
    //Measuring JSON decoding or API response handling:
    func testNewsDecodingPerformance() {

        measure {

            let articles = (0..<1000).map {_ in 
                Articles(
                    author: "Author",
                    title: "Title",
                    description: "Desc",
                    url: "test.com",
                    urlToImage: nil
                )
            }

            let response = NewsModelRes(
                status: "ok",
                totalResults: articles.count,
                articles: articles
            )

            XCTAssertEqual(response.articles.count, 1000)
        }
    }
    
    //Performance Test for ViewModel
    //Example measuring your NewsViewModel.
    func testNewsViewModelPerformance() {

        measure {

            let service = MockNewsService()
            let viewModel = NewsViewModel(service: service)

            let expectation = expectation(description: "Load News")

            Task {
                await viewModel.loadNews()
                expectation.fulfill()
            }

            wait(for: [expectation], timeout: 2)
        }
    }
    
    //Measuring Specific Metrics
  //  Modern XCTest allows measuring metrics like:
    // CPU , Memory, Disk, App launch time
   // Example:
    func testPerformance() {

        measure(metrics: [XCTClockMetric()]) {

            for _ in 0..<1000 {
                _ = UUID().uuidString
            }
        }
    }
    
    
    //Performance Test for App Launch
    func testAppLaunchPerformance() {

        measure(metrics: [XCTApplicationLaunchMetric()]) {

            XCUIApplication().launch()
        }
    }
    
}
