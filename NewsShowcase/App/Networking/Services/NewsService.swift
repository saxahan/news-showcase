//
//  NewsService.swift
//  NewsShowcase
//
//  Created by Yunus Alkan on 4.06.2020.
//  Copyright © 2020 Yunus Alkan. All rights reserved.
//

import Foundation

enum NewsService {
    case getSources(SourcesRequestModel)
    case getTopHeadlines(TopHeadlinesRequestModel)
}

extension NewsService: ServiceDefinable {
    var path: String {
        switch self {
        case .getSources:
            return "/sources"
        case .getTopHeadlines:
            return "/top-headlines"
        }
    }

    var method: Method {
        return .get
    }

    var sampleData: Data {
        switch self {
        case .getSources:
            return Bundle.main.data(for: "sources-200.json") ?? Data()
        case .getTopHeadlines:
            return Bundle.main.data(for: "top-headlines-200.json") ?? Data()
        }
    }

    var sampleErrorData: (statusCode: Int, response: Data) {
        return (401, Bundle.main.data(for: "api-401.json") ?? Data())
    }

    var task: Task {
        switch self {
        case .getSources(let req):
            return requestParametersEncodableTask(req)
        case .getTopHeadlines(let req):
            return requestParametersEncodableTask(req)
        }
    }
}
