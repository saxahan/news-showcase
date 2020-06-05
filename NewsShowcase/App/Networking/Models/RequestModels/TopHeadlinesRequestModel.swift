//
//  TopHeadlinesRequestModel.swift
//  NewsShowcase
//
//  Created by Yunus Alkan on 4.06.2020.
//  Copyright © 2020 Yunus Alkan. All rights reserved.
//

import Foundation

struct TopHeadlinesRequestModel: PaginationRequestModel {
    var page: Int!
    var pageSize: Int!
    var q: String?
    var sources: String?
}
