//
//  ResultStatus.swift
//  NewsShowcase
//
//  Created by Yunus Alkan on 6.06.2020.
//  Copyright © 2020 Yunus Alkan. All rights reserved.
//

import UIKit

enum ResultStatus: String {
    case oops = "oops"
    case emptyList = "empty-result"

    var image: UIImage? {
        UIImage(named: self.rawValue)
    }
}
