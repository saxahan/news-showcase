//
//  BaseViewController.swift
//  NewsShowcase
//
//  Created by Yunus Alkan on 5.06.2020.
//  Copyright © 2020 Yunus Alkan. All rights reserved.
//

import UIKit

class BaseViewController<Presenter: BasePresenterProtocol>: UIViewController {
    internal var presenter: Presenter?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupInitials()
    }

    internal func setupInitials() {
        fatalError("You must override \(#function) in child class")
    }
}
