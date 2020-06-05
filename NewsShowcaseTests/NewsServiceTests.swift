//
//  NewsServiceTests.swift
//  NewsShowcaseTests
//
//  Created by Yunus Alkan on 4.06.2020.
//  Copyright © 2020 Yunus Alkan. All rights reserved.
//

import XCTest
@testable import NewsShowcase

class NewsServiceTests: XCTestCase {

    func testResponseMapping() throws {
        let newsServiceProvider = ServiceFactory.getServiceProvider(for: NewsService.self, mock: true)

        // sources
        let sourcesRequest = SourcesRequestModel()

        newsServiceProvider.request(.getSources(sourcesRequest),
                                    model: SourcesResponseModel.self) { (result) in
            switch result {
            case .success(let sourcesResponse):
                XCTAssertEqual(sourcesResponse.status, "ok")
                XCTAssertGreaterThan(sourcesResponse.sources.count, 0)
            case .failure(let error):
                XCTFail(error.message ?? "failed")
            }
        }

        // mapping error case
        newsServiceProvider.request(.getSources(sourcesRequest),
                                    model: TopHeadlinesResponseModel.self) { (result) in
            switch result {
            case .success:
                XCTFail("Mapping should have been failed")
            case .failure(let error):
                XCTAssertEqual(error.status, "error")
            }
        }

        // topHeadline
        let topHeadlinesRequest = TopHeadlinesRequestModel()

        newsServiceProvider.request(.getTopHeadlines(topHeadlinesRequest),
                                    model: TopHeadlinesResponseModel.self) { (result) in
            switch result {
            case .success(let topHeadlinesResponse):
                XCTAssertEqual(topHeadlinesResponse.status, "ok")
                XCTAssertGreaterThan(topHeadlinesResponse.totalResults, 0)
            case .failure(let error):
                XCTFail(error.message ?? "failed")
            }
        }
    }

    func testErrorResponse() throws {
        let newsServiceProvider = ServiceFactory.getServiceProvider(for: NewsService.self, mock: true, forceFail: true)

        // mapping error response as unauthorized(401)
        let sourcesRequest = SourcesRequestModel()

        newsServiceProvider.request(.getSources(sourcesRequest),
                                    model: SourcesResponseModel.self) { (result) in
            switch result {
            case .success:
               XCTFail("Mapping should have been failed")
            case .failure(let error):
                XCTAssertEqual(error.status, "error")
            }
        }
    }

}
