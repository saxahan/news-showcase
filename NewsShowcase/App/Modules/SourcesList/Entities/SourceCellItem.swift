//
//  SourceCellItem.swift
//  NewsShowcase
//
//  Created by Yunus Alkan on 5.06.2020.
//  Copyright © 2020 Yunus Alkan. All rights reserved.
//

import Foundation

struct SourceCellItem {
    let id: String?
    let name: String?
    let category: String?
    let description: String?
}

extension SourceCellItem: Equatable {
    static func == (lhs: SourceCellItem, rhs: SourceCellItem) -> Bool {
        return lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.category == rhs.category
    }
}
