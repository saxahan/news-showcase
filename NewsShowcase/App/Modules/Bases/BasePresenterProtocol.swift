//
//  BasePresenterProtocol.swift
//  NewsShowcase
//
//  Created by Yunus Alkan on 5.06.2020.
//  Copyright © 2020 Yunus Alkan. All rights reserved.
//

import Foundation

protocol BasePresenterProtocol: AnyObject {
    associatedtype InteractorProtocol
    associatedtype ViewProtocol
    associatedtype RouterProtocol

    var interactor: InteractorProtocol? { get set }
    var view: ViewProtocol? { get set }
    var router: RouterProtocol? { get set }

    init(interactor: InteractorProtocol, view: ViewProtocol, router: RouterProtocol)
}
