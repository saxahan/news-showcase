//
//  Itemable.swift
//  NewsShowcase
//
//  Created by Yunus Alkan on 5.06.2020.
//  Copyright © 2020 Yunus Alkan. All rights reserved.
//

import Foundation

protocol Itemable {
    associatedtype Item

    var item: Item? { get set }
}
