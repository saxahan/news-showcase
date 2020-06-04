//
//  RequestHeaders.swift
//  NewsShowcase
//
//  Created by Yunus Alkan on 4.06.2020.
//  Copyright © 2020 Yunus Alkan. All rights reserved.
//

import Foundation

enum RequestHeaders {
    static func defaults() -> [String: String] {
        return [
            "X-Api-Key": AppConfig.environment.apiKey
        ]
    }
}
