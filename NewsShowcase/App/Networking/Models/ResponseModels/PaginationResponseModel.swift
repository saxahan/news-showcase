//
//  PaginationResponseModel.swift
//  NewsShowcase
//
//  Created by Yunus Alkan on 4.06.2020.
//  Copyright © 2020 Yunus Alkan. All rights reserved.
//

import Foundation

protocol PaginationResponseModel: BaseResponseModel {
    var totalResults: Int { get set }
}
