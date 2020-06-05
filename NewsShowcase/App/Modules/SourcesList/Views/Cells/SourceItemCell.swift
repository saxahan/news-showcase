//
//  SourceItemCell.swift
//  NewsShowcase
//
//  Created by Yunus Alkan on 5.06.2020.
//  Copyright © 2020 Yunus Alkan. All rights reserved.
//

import UIKit

struct SourceCellItem {
    let id: String?
    let name: String?
    let category: String?
    let description: String?
}

extension SourceCellItem: Equatable {
    static func == (lhs: SourceCellItem, rhs: SourceCellItem) -> Bool {
        return lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.category == rhs.category
    }
}

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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
