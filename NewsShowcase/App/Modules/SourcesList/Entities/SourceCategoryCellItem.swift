//
//  SourceCategoryCellItem.swift
//  NewsShowcase
//
//  Created by Yunus Alkan on 5.06.2020.
//  Copyright © 2020 Yunus Alkan. All rights reserved.
//

import Foundation

struct SourceCategoryCellItem {
    var isSelected: Bool
    let name: String
}

extension SourceCategoryCellItem: Equatable, Hashable {
    static func == (lhs: SourceCategoryCellItem, rhs: SourceCategoryCellItem) -> Bool {
        return lhs.name == rhs.name
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
