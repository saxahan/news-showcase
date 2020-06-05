//
//  ArticleSliderCell.swift
//  NewsShowcase
//
//  Created by Yunus Alkan on 5.06.2020.
//  Copyright © 2020 Yunus Alkan. All rights reserved.
//

import UIKit

private enum Consts {
    static let slideDuration: TimeInterval = 3
}

class ArticleSliderCell: UICollectionViewCell, Itemable {
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var pageControl: UIPageControl!

    private weak var slideTimer: Timer?

    var item: [ArticleCellItem]? {
        didSet {
            pageControl.numberOfPages = item?.count ?? 0
            collectionView.reloadData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        collectionView.register(ArticleCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    func slide(to item: Int) {
        let indexPath = IndexPath(item: item,
                                  section: 0)
        collectionView.scrollToItem(at: indexPath,
                                    at: .centeredHorizontally,
                                    animated: true)
    }
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource

extension ArticleSliderCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let items = item {
            return items.count
        }

        return 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: ArticleCell.self)
        let sliderItem = item?[safe: indexPath.row]
        cell.item = sliderItem
        cell.delegate = self

        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        pageControl.currentPage = indexPath.row
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ArticleSliderCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width,
                              height: collectionView.frame.height)
    }
}

// MARK: - ArticleCellDelegate

extension ArticleSliderCell: ArticleCellDelegate {
    func bookmarkTapped(item: ArticleCellItem) {
        if let id = item.title, let desc = item.description {
            let bookmark = BookmarkItem(id: id, description: desc)

            if !item.isBookmarked {
                BookmarkManager.add(item: bookmark)
            } else {
                BookmarkManager.remove(item: bookmark)
            }
            
            collectionView.reloadData()
        }
    }
}
