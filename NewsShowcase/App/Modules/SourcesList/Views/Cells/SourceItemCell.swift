//
//  SourceItemCell.swift
//  NewsShowcase
//
//  Created by Yunus Alkan on 5.06.2020.
//  Copyright © 2020 Yunus Alkan. All rights reserved.
//

import UIKit

class SourceItemCell: UITableViewCell, Itemable {
    @IBOutlet private weak var labelTitle: UILabel!
    @IBOutlet private weak var labelCaption: UILabel!

    var item: SourceCellItem? {
        didSet {
            if let item = item {
                labelTitle.text = item.name
                labelCaption.text = item.description
            }
        }
    }
}
