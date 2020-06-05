//
//  ServiceDefinable.swift
//  NewsShowcase
//
//  Created by Yunus Alkan on 4.06.2020.
//  Copyright © 2020 Yunus Alkan. All rights reserved.
//

import Moya

typealias ServiceProvider = MoyaProvider
typealias Method = Moya.Method
typealias Task = Moya.Task
typealias ParameterEncoding = Moya.ParameterEncoding
typealias JSONEncoding = Moya.JSONEncoding
typealias URLEncoding = Moya.URLEncoding

protocol ServiceDefinable: TargetType {
    var sampleErrorData: (statusCode: Int, response: Data) { get }
}

extension ServiceDefinable {
    var baseURL: URL {
        return AppConfig.environment.baseUrl
    }

    var sampleData: Data {
        return Data()
    }

    var sampleErrorData: (statusCode: Int, response: Data) {
        return (400, Data())
    }

    var headers: [String: String]? {
        return RequestHeaders.defaults()
    }

    /// Converts given encodable request model to a requestParameters task.
    func requestParametersEncodableTask(_ parametersObject: Encodable) -> Task {
        guard let dictParams = parametersObject.dictionary else {
            return .requestPlain
        }

        return .requestParameters(parameters: dictParams, encoding: URLEncoding.default)
    }
}
