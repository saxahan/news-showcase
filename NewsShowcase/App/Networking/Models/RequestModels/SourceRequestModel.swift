//
//  SourceRequestModel.swift
//  NewsShowcase
//
//  Created by Yunus Alkan on 4.06.2020.
//  Copyright © 2020 Yunus Alkan. All rights reserved.
//

import Foundation

struct SourceRequestModel: Encodable {
    let language: String
    let category: String?
    let country: String?

    init(language: String = "en", category: String? = nil, country: String? = nil) {
        self.language = language
        self.category = category
        self.country = country
    }
}
