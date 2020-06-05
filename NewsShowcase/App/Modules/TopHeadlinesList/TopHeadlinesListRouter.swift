//
//  TopHeadlinesListRouter.swift
//  NewsShowcase
//
//  Created by Yunus Alkan on 5.06.2020.
//  Copyright © 2020 Yunus Alkan. All rights reserved.
//

import UIKit

final class TopHeadlinesListRouter: BaseRouterProtocol, TopHeadlinesListRouterProtocol {
    weak var view: TopHeadlinesListViewController?

    init(view: TopHeadlinesListViewController) {
        self.view = view
    }

    static func makeWith(source: SourceCellItem) -> TopHeadlinesListViewController {
        let viewController = TopHeadlinesListViewController()
        let router = TopHeadlinesListRouter(view: viewController)
        let interactor = TopHeadlinesListInteractor(source: source)

        let presenter = TopHeadlinesListPresenter(interactor: interactor,
                                                  view: viewController,
                                                  router: router)
        viewController.presenter = presenter
        viewController.title = source.name

        return viewController
    }

    func navigate(to route: TopHeadlinesListRoute) {

    }
}
