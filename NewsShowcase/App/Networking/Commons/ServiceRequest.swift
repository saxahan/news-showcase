//
//  ServiceRequest.swift
//  NewsShowcase
//
//  Created by Yunus Alkan on 4.06.2020.
//  Copyright © 2020 Yunus Alkan. All rights reserved.
//

import Foundation
import Moya

extension MoyaProvider {
    @discardableResult
    func request<T: Decodable>(_ target: Target,
                               model: T.Type,
                               path: String? = nil,
                               _ completion: @escaping (Result<T, ErrorResponseModel>) -> Void) -> Cancellable? {

        return request(target) { (result) in
            switch result {
            case .failure(let error):
                let err = ErrorResponseModel(error: error)
                Logger.log(.error(message: error.localizedDescription,
                                  error: err))

                completion(.failure(err))
            case .success(let response):
                do {
                    if let errorResponse = try? response.filter(statusCodes: 400...511)
                        .map(ErrorResponseModel.self) {
                        Logger.log(.error(message: errorResponse.status,
                                          error: errorResponse))

                        completion(.failure(errorResponse))
                    }

                    let mappedResponse = try response
                        .map(T.self, path: path)

                    completion(.success(mappedResponse))
                } catch {
                    let errorResponse = ErrorResponseModel(error: error)
                    Logger.log(.error(message: error.localizedDescription,
                                      error: errorResponse))

                    completion(.failure(errorResponse))
                }
            }
        }
    }
}

// MARK: - Response generic mapping

extension Response {
    private static let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
            let container = try decoder.singleValueContainer()
            let dateStr = try container.decode(String.self)

            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"

            if dateStr.count > 20 {
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            }

            guard let date = formatter.date(from: dateStr) else {
                throw DecodingError.dataCorruptedError(in: container,
                                                       debugDescription: "Cannot decode date string \(dateStr)")
            }

            return date
        })

        return decoder
    }()

    func map<T: Decodable>(_ type: T.Type, path: String? = nil) throws -> T {
        do {
            return try map(T.self,
                           atKeyPath: path,
                           using: Response.jsonDecoder)
        } catch {
            Logger.log(.error(message: "Object Mapping Error", error: error))
            throw MoyaError.objectMapping(error, self)
        }
    }
}
