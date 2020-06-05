//
//  ArticlesEntity.swift
//  NewsShowcase
//
//  Created by Yunus Alkan on 5.06.2020.
//  Copyright © 2020 Yunus Alkan. All rights reserved.
//

import Foundation

struct ArticlesEntity {
    let source: SourceCellItem
    var sliderItems: [ArticleCellItem] = []
    var articles: [ArticleCellItem]
    var currentSlideIndex: Int = 0

    init(source: SourceCellItem, articles: [Article]) {
        self.source = source
        self.articles = articles.map { ArticleCellItem(author: $0.author,
                                                       title: $0.title,
                                                       description: $0.description,
                                                       content: $0.content,
                                                       imageUrl: $0.urlToImage,
                                                       publishedAt: $0.publishedAt, isBookmarked: true) }
    }
}
