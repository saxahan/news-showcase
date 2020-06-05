//
//  TopHeadlinesResponseModel.swift
//  NewsShowcase
//
//  Created by Yunus Alkan on 4.06.2020.
//  Copyright © 2020 Yunus Alkan. All rights reserved.
//

import Foundation

struct TopHeadlinesResponseModel: PaginationResponseModel {
    var status: String
    var totalResults: Int
    var articles: [Article] = []
}

struct Article: Decodable {
    let source: Source
    let author: String?
    let title: String?
    let description: String?
    let url: URL?
    let urlToImage: URL?
    let publishedAt: Date?
    let content: String?
}
