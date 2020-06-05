//
//  SourcesEntity.swift
//  NewsShowcase
//
//  Created by Yunus Alkan on 5.06.2020.
//  Copyright © 2020 Yunus Alkan. All rights reserved.
//

import Foundation

struct SourcesEntity {
    var categories: [SourceCategoryCellItem]
    var sources: [SourceCellItem]

    var selectedCategories: [SourceCategoryCellItem] {
        return categories.filter { $0.isSelected }
    }

    var sourcesForSelectedCategories: [SourceCellItem] {
        let categories = selectedCategories

        guard !categories.isEmpty else {
            return sources
        }

        var newSources: [SourceCellItem] = []
        for source in sources {
            if categories.contains(where: { (itm) -> Bool in
                itm.name == source.category
            }) {
                newSources.append(source)
            }
        }

        return newSources
    }

    init(sources: [Source]) {
        self.categories = sources.filter { $0.category?.isEmpty == false }
            .map { $0.category ?? "" }
            .uniques
            .map { SourceCategoryCellItem(isSelected: false,
                                          name: $0) }
        self.sources = sources.map { SourceCellItem(id: $0.id,
                                                    name: $0.name,
                                                    category: $0.category,
                                                    description: $0.description) }
    }
}

extension SourcesEntity: Equatable {
    static func == (lhs: SourcesEntity, rhs: SourcesEntity) -> Bool {
        return lhs.categories == rhs.categories && lhs.sources == rhs.sources
    }
}
