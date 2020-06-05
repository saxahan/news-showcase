//
//  UITableView+Reusable.swift
//  NewsShowcase
//
//  Created by Yunus Alkan on 5.06.2020.
//  Copyright © 2020 Yunus Alkan. All rights reserved.
//

import Foundation

import UIKit

// MARK: Reusable support for UITableView

extension UITableViewCell: Reusable {

}

extension UITableViewHeaderFooterView: Reusable {

}

extension UITableView {

    func register<T: UITableViewCell>(_ cellType: T.Type,
                                      reuseIdentifier: String? = nil) {
        let identifier = reuseIdentifier ?? cellType.reuseIdentifier
        self.register(cellType.nib, forCellReuseIdentifier: identifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath,
                                                 cellType: T.Type = T.self,
                                                 reuseIdentifier: String? = nil) -> T {
        let identifier = reuseIdentifier ?? cellType.reuseIdentifier

        guard let cell = self.dequeueReusableCell(withIdentifier: identifier,
                                                  for: indexPath) as? T else {
            fatalError(
                "Failed to dequeue a cell view with identifier \(cellType.reuseIdentifier) "
                    + "matching type \(cellType.self). "
                    + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                    + "and that you registered the cell view beforehand"
            )
        }

        return cell
    }

    func register<T: UITableViewHeaderFooterView>(headerFooterViewType: T.Type,
                                                  reuseIdentifier: String? = nil) {
        let identifier = reuseIdentifier ?? headerFooterViewType.reuseIdentifier

        if headerFooterViewType.nibName == "UITableViewHeaderFooterView" {
            self.register(headerFooterViewType.classForCoder(), forHeaderFooterViewReuseIdentifier: identifier)
        } else {
            self.register(headerFooterViewType.nib,
                          forHeaderFooterViewReuseIdentifier: identifier)
        }
    }

    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_ viewType: T.Type = T.self,
                                                                         reuseIdentifier: String? = nil) -> T? {
        let identifier = reuseIdentifier ?? viewType.reuseIdentifier

        guard let view = self.dequeueReusableHeaderFooterView(withIdentifier: identifier) as? T? else {
            fatalError(
                "Failed to dequeue a header/footer with identifier \(viewType.reuseIdentifier) "
                    + "matching type \(viewType.self). "
                    + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                    + "and that you registered the header/footer beforehand"
            )
        }

        return view
    }

    func cell<T: UITableViewCell>(for indexPath: IndexPath, cellType: T.Type) -> T? {
        return cellForRow(at: indexPath) as? T
    }
}
