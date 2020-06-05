//
//  BookmarkManager.swift
//  NewsShowcase
//
//  Created by Yunus Alkan on 6.06.2020.
//  Copyright © 2020 Yunus Alkan. All rights reserved.
//

import Foundation

struct BookmarkItem: Codable {
    let id: String
    let description: String
}

extension BookmarkItem: Equatable, Hashable {
    static func == (lhs: BookmarkItem, rhs: BookmarkItem) -> Bool {
        return lhs.id == rhs.id &&
            lhs.description == rhs.description
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct BookmarkManager {
    @UserProperties(key: "bookmarks", defaultValue: [])
    private static var persistedItems: Set<BookmarkItem>
    
    static var items: Set<BookmarkItem> = persistedItems

    static func add(item: BookmarkItem) {
        items.insert(item)
    }

    static func remove(item: BookmarkItem) {
        items.remove(item)
    }

    static func has(forId id: String) -> Bool {
        return items.contains { $0.id == id }
    }

    /// Persist on the userdefaults
    static func persist() {
        persistedItems = items
    }
}
