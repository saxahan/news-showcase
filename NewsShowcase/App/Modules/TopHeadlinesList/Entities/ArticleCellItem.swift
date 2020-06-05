//
//  ArticleCellItem.swift
//  NewsShowcase
//
//  Created by Yunus Alkan on 5.06.2020.
//  Copyright © 2020 Yunus Alkan. All rights reserved.
//

import Foundation

struct ArticleCellItem {
    let author: String?
    let title: String?
    let description: String?
    let content: String?
    let imageUrl: URL?
    let publishedAt: Date?
    let isBookmarked: Bool
}

extension ArticleCellItem: Equatable {
    static func == (lhs: ArticleCellItem, rhs: ArticleCellItem) -> Bool {
        return lhs.author == rhs.author &&
            lhs.title == rhs.title
    }
}
