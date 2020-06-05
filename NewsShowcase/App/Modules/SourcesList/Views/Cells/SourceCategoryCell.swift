//
//  SourceCategoryCell.swift
//  NewsShowcase
//
//  Created by Yunus Alkan on 5.06.2020.
//  Copyright © 2020 Yunus Alkan. All rights reserved.
//

import UIKit

class SourceCategoryCell: UICollectionViewCell, Itemable {
    @IBOutlet private weak var viewContent: UIView!
    @IBOutlet private weak var imgViewLeftIcon: UIImageView!
    @IBOutlet private weak var labelTitle: UILabel!

    var item: SourceCategoryCellItem? {
        didSet {
            if let item = item {
                let color: UIColor = item.isSelected ? .systemBlue : .black
                imgViewLeftIcon.tintColor = color
                labelTitle.textColor = color
                labelTitle.text = item.name.localizedUppercase
                viewContent.layer.borderColor = color.cgColor
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        imgViewLeftIcon.image = imgViewLeftIcon.image?.withRenderingMode(.alwaysTemplate)
        viewContent.layer.cornerRadius = 8
        viewContent.layer.borderWidth = 1
        viewContent.layer.borderColor = UIColor.black.cgColor
    }
}
