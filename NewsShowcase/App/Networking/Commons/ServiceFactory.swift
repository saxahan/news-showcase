//
//  ServiceFactory.swift
//  NewsShowcase
//
//  Created by Yunus Alkan on 4.06.2020.
//  Copyright © 2020 Yunus Alkan. All rights reserved.
//

import Foundation
import Moya

enum ServiceFactory {
    static func getServiceProvider<S: ServiceDefinable>(for type: S.Type,
                                                        mock: Bool = false,
                                                        forceFail: Bool = false) -> MoyaProvider<S> {

        let endpointClosure = { (target: S) -> Endpoint in
            return Endpoint(url: URL(target: target).absoluteString,
                            sampleResponseClosure: {
                                return mock && forceFail ?
                                    .networkResponse(target.sampleErrorData.statusCode,
                                                     target.sampleErrorData.response) :
                                    .networkResponse(200, target.sampleData)},
                            method: target.method,
                            task: target.task,
                            httpHeaderFields: target.headers)
        }

        let service = MoyaProvider<S>(endpointClosure: endpointClosure, stubClosure: { (_) -> StubBehavior in
            return mock ? .immediate : .never
        }, plugins: AppConfig.isDebug ? [NetworkLoggerPlugin()] : [])

        return service
    }
}
