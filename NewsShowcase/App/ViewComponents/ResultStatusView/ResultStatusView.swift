//
//  ResultStatusView.swift
//  NewsShowcase
//
//  Created by Yunus Alkan on 6.06.2020.
//  Copyright © 2020 Yunus Alkan. All rights reserved.
//

import UIKit

class ResultStatusView: UIView, Itemable {
    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var imgView: UIImageView!
    @IBOutlet private weak var labelMessage: UILabel!

    var item: (status: ResultStatus, message: String?)? {
        didSet {
            if let item = item {
                imgView.image = item.status.image
                labelMessage.text = item.message
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        commonInit()
    }

    private func commonInit() {
        Bundle.main.loadNibNamed("ResultStatusView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
