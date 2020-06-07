//
//  SourcesListRouter.swift
//  NewsShowcase
//
//  Created by Yunus Alkan on 5.06.2020.
//  Copyright © 2020 Yunus Alkan. All rights reserved.
//

import UIKit

private enum Consts {
    static let viewTitle = "Sources"
}

final class SourcesListRouter: BaseRouterProtocol, SourcesListRouterProtocol {
    weak var view: SourcesListViewController?

    init(view: SourcesListViewController) {
        self.view = view
    }

    static func makeWithNavigation() -> UINavigationController {
        let viewController = SourcesListViewController()
        let router = SourcesListRouter(view: viewController)
        let interactor = SourcesListInteractor()

        let presenter = SourcesListPresenter(interactor: interactor,
                                             view: viewController,
                                             router: router)
        viewController.presenter = presenter
        viewController.title = Consts.viewTitle

        let navigator = UINavigationController(rootViewController: viewController)
        navigator.navigationBar.tintColor = .systemBlue

        if #available(iOS 11.0, *) {
            navigator.navigationBar.prefersLargeTitles = true
        } else {
            // Fallback on earlier versions
        }

        return navigator
    }

    func navigate(to route: SourcesListRoute) {
        switch route {
        case .openTopHeadlines(let source):
            let topHeadlineVc = TopHeadlinesListRouter.makeWith(source: source)
            view?.navigationController?.pushViewController(topHeadlineVc, animated: true)
        }
    }
}
