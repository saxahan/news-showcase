//
//  NetworkError.swift
//  NewsShowcase
//
//  Created by Yunus Alkan on 4.06.2020.
//  Copyright © 2020 Yunus Alkan. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case badRequest
    case unauthorized
    case tooManyRequests
    case internalServer
    case notConnectedToInternet
    case somethingWentWrong

    static func mapError(_ statusCode: Int, statusMessage: String? = "") -> NetworkError {
        switch statusCode {
        case 400:
            return .unauthorized
        case 401:
            return .unauthorized
        case 429:
            return .tooManyRequests
        case 500:
            return .internalServer
        case -1009:
            return .notConnectedToInternet
        default:
            return .somethingWentWrong
        }
    }
}
