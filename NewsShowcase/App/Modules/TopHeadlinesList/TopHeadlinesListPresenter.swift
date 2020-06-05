//
//  TopHeadlinesListPresenter.swift
//  NewsShowcase
//
//  Created by Yunus Alkan on 5.06.2020.
//  Copyright © 2020 Yunus Alkan. All rights reserved.
//

import Foundation

final class TopHeadlinesListPresenter: BasePresenterProtocol, TopHeadlinesListPresenterProtocol {
    internal var interactor: TopHeadlinesListInteractorProtocol?
    internal weak var view: TopHeadlinesListViewProtocol?
    internal var router: TopHeadlinesListRouterProtocol?

    required init(interactor: TopHeadlinesListInteractorProtocol,
                  view: TopHeadlinesListViewProtocol,
                  router: TopHeadlinesListRouterProtocol) {
        self.interactor = interactor
        self.view = view
        self.router = router
        self.interactor?.delegate = self
    }

    func loadSources(isPullToRefresh: Bool) {
        interactor?.fetchHeadlines(isPullToRefresh)
    }

    func startSlideTimer() {
        interactor?.startSlideTimer()
    }

    func stopSlider() {
        interactor?.stopSlider()
    }

    func stopAutoRefresher() {
        interactor?.stopAutoRefresher()
    }

    func bookmarkTapped(item: ArticleCellItem) {
        interactor?.bookmarkTapped(item: item)
    }
}

extension TopHeadlinesListPresenter: TopHeadlinesListInteractorDelegate {
    func handle(_ output: TopHeadlinesListInteractorOutput) {
        switch output {
        case .failed(let reason, let status):
            view?.handle(.failed(reason, status: status))
        case .loading:
            view?.handle(.loading)
        case .finishLoading:
            view?.handle(.hideLoading)
        case .reloadSlider(let items):
            view?.handle(.reloadSlider(items))
        case .reloadData(let items):
            view?.handle(.reloadData(items))
        case .slide(let section, let item):
            view?.handle(.slide(section: section, item: item))
        }
    }
}
