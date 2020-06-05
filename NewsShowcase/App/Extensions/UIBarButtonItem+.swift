//
//  UIBarButtonItem+.swift
//  NewsShowcase
//
//  Created by Yunus Alkan on 5.06.2020.
//  Copyright © 2020 Yunus Alkan. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    static func createButton(image: UIImage,
                             target: Any?,
                             action: Selector) -> UIBarButtonItem {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        button.setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
        button.addTarget(target,
                         action: action,
                         for: .touchUpInside)

        let barItem = UIBarButtonItem(customView: button)

        return barItem
    }

    static func createButton(title: String,
                             target: Any?,
                             action: Selector) -> UIBarButtonItem {

        let barItem = UIBarButtonItem(title: title,
                                      style: .plain,
                                      target: target,
                                      action: action)

        return barItem
    }
}
