//
//  SourcesListPresenter.swift
//  NewsShowcase
//
//  Created by Yunus Alkan on 5.06.2020.
//  Copyright © 2020 Yunus Alkan. All rights reserved.
//

import Foundation

final class SourcesListPresenter: BasePresenterProtocol, SourcesListPresenterProtocol {
    internal var interactor: SourcesListInteractorProtocol?
    internal weak var view: SourcesListViewProtocol?
    internal var router: SourcesListRouterProtocol?

    required init(interactor: SourcesListInteractorProtocol,
                  view: SourcesListViewProtocol,
                  router: SourcesListRouterProtocol) {
        self.interactor = interactor
        self.view = view
        self.router = router
        self.interactor?.delegate = self
    }

    func loadSources() {
        interactor?.fetchSources()
    }

    func didTapped(category: SourceCategoryCellItem, at indexPath: IndexPath) {
        interactor?.didTapped(category: category, at: indexPath)
    }

    func didTapped(source: SourceCellItem, at indexPath: IndexPath) {
        router?.navigate(to: .openTopHeadlines(source))
    }

    func didChangeLanguage(newLanguage: String) {
        interactor?.didChangeLanguage(newLanguage: newLanguage)
    }
}

extension SourcesListPresenter: SourcesListInteractorDelegate {
    func handle(_ output: SourcesListInteractorOutput) {
        switch output {
        case .failed(let reason):
            view?.handle(.failed(reason))
        case .loading:
            view?.handle(.loading)
        case .finishLoading:
            view?.handle(.hideLoading)
        case .filteredSources(let sources):
            view?.handle(.reloadSources(sources))
        case .filteredCategories(let categories):
            view?.handle(.reloadCategories(categories))
        }
    }
}
