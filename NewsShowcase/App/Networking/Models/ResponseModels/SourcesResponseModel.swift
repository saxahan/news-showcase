//
//  SourcesResponseModel.swift
//  NewsShowcase
//
//  Created by Yunus Alkan on 4.06.2020.
//  Copyright © 2020 Yunus Alkan. All rights reserved.
//

import Foundation

struct SourcesResponseModel: BaseResponseModel {
    var status: String
    let sources: [Source]
}

struct Source: Decodable {
    let id: String?
    let name: String?
    let description: String?
    let url: URL?
    let category: String?
    let language: String?
    let country: String?
}
