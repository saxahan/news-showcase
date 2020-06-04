//
//  PaginationRequestModel.swift
//  NewsShowcase
//
//  Created by Yunus Alkan on 4.06.2020.
//  Copyright © 2020 Yunus Alkan. All rights reserved.
//

import Foundation

protocol PaginationRequestModel: Encodable {
    var page: Int! { get set }
    var pageSize: Int! { get set }
}

extension PaginationRequestModel {
    var page: Int! {
        return 1
    }

    var pageSize: Int! {
        return 20
    }
}
