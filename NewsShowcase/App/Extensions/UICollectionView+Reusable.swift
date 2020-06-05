//
//  UICollectionView+Reusable.swift
//  NewsShowcase
//
//  Created by Yunus Alkan on 5.06.2020.
//  Copyright © 2020 Yunus Alkan. All rights reserved.
//

import UIKit

// MARK: Reusable support for UICollectionView

//extension UICollectionViewCell: Reusable {
//
//}

extension UICollectionReusableView: Reusable {

}

extension UICollectionView {
    func register<T: UICollectionViewCell>(_ cellType: T.Type, reuseIdentifier: String? = nil) {
        let identifier = reuseIdentifier ?? cellType.reuseIdentifier
        self.register(cellType.nib, forCellWithReuseIdentifier: identifier)
    }

    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath,
                                                      cellType: T.Type = T.self,
                                                      reuseIdentifier: String? = nil) -> T {
        let identifier = reuseIdentifier ?? cellType.reuseIdentifier

        guard let cell = self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T else {
            fatalError(
                "Failed to dequeue a cell view with identifier \(cellType.reuseIdentifier) "
                    + "matching type \(cellType.self). "
                    + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                    + "and that you registered the cell view beforehand"
            )
        }

        return cell
    }

    func register<T: UICollectionReusableView>(supplementaryViewType: T.Type,
                                               ofKind elementKind: String,
                                               reuseIdentifier: String? = nil) {
        let identifier = reuseIdentifier ?? supplementaryViewType.reuseIdentifier

        if supplementaryViewType.nibName == "UICollectionReusableView" {
            self.register(supplementaryViewType.classForCoder(),
                          forSupplementaryViewOfKind: elementKind,
                          withReuseIdentifier: identifier)
        } else {
            self.register(
                supplementaryViewType.nib,
                forSupplementaryViewOfKind: elementKind,
                withReuseIdentifier: identifier
            )
        }
    }

    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind elementKind: String,
                                                                       for indexPath: IndexPath,
                                                                       viewType: T.Type = T.self,
                                                                       reuseIdentifier: String? = nil) -> T {
        let identifier = reuseIdentifier ?? viewType.reuseIdentifier

        let view = self.dequeueReusableSupplementaryView(
            ofKind: elementKind,
            withReuseIdentifier: identifier,
            for: indexPath)

        guard let typedView = view as? T else {
            fatalError(
                "Failed to dequeue a supplementary view with identifier \(viewType.reuseIdentifier) "
                    + "matching type \(viewType.self). "
                    + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                    + "and that you registered the supplementary view beforehand"
            )
        }
        return typedView
    }

    func cell<T: UICollectionViewCell>(for indexPath: IndexPath, cellType: T.Type) -> T? {
        return cellForItem(at: indexPath) as? T
    }
}
