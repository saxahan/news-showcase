//
//  ErrorResponseModel.swift
//  NewsShowcase
//
//  Created by Yunus Alkan on 4.06.2020.
//  Copyright © 2020 Yunus Alkan. All rights reserved.
//

import Foundation

struct ErrorResponseModel: BaseResponseModel, Error {
    var status: String
    let code: String?
    let message: String?

    init() {
        self.init(status: "error", code: nil, message: nil)
    }

    init(message: String, code: String? = nil) {
        self.init(status: "error", code: code, message: message)
    }

    init(status: String, code: String? = nil, message: String? = nil) {
        self.status = status
        self.code = code
        self.message = message
    }

    init(status: String, code: String? = nil, error: Error) {
        self.status = status
        self.code = code
        self.message = error.localizedDescription
    }

    init(error: Error) {
        self.status = "error"
        self.code = nil
        self.message = error.localizedDescription
    }
}
