//
//  ArticleCell.swift
//  NewsShowcase
//
//  Created by Yunus Alkan on 5.06.2020.
//  Copyright © 2020 Yunus Alkan. All rights reserved.
//

import UIKit
import SDWebImage

protocol ArticleCellDelegate: AnyObject {
    func bookmarkTapped(item: ArticleCellItem)
}

class ArticleCell: UICollectionViewCell, Itemable {
    @IBOutlet private weak var imgView: UIImageView!
    @IBOutlet private weak var labelContent: UILabel!
    @IBOutlet private weak var labelDate: UILabel!
    @IBOutlet private weak var buttonBookmark: UIButton!

    weak var delegate: ArticleCellDelegate?

    var item: ArticleCellItem? {
        didSet {
            if let item = item {
                imgView.sd_setImage(with: item.imageUrl)
                labelContent.text = item.description
                buttonBookmark.tintColor = item.isBookmarked ? .systemBlue : .white
                labelDate.text = item.publishedAt?.toString()
            }
        }
    }

    @IBAction private func tappedBookmark(_ sender: Any) {
        if let item = item {
            delegate?.bookmarkTapped(item: item)
        }
    }
}
