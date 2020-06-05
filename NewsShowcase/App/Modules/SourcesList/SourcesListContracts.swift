//
//  SourcesListContracts.swift
//  NewsShowcase
//
//  Created by Yunus Alkan on 5.06.2020.
//  Copyright © 2020 Yunus Alkan. All rights reserved.
//

import Foundation

// MARK: Interactor

protocol SourcesListInteractorProtocol: BaseInteractor<NewsService> {
    var delegate: SourcesListInteractorDelegate? { get set }

    func fetchSources(_ isRefresh: Bool)
    func didTapped(category: SourceCategoryCellItem, at indexPath: IndexPath)
    func didChangeLanguage(newLanguage: String)
}

enum SourcesListInteractorOutput: Equatable {
    case loading
    case finishLoading
    case filteredCategories(_ items: [SourceCategoryCellItem])
    case filteredSources(_ items: [SourceCellItem])
    case failed(_ reason: String)
}

protocol SourcesListInteractorDelegate: AnyObject {
    func handle(_ output: SourcesListInteractorOutput)
}

// MARK: Presenter

protocol SourcesListPresenterProtocol {
    func loadSources(isPullToRefresh: Bool)
    func didTapped(category: SourceCategoryCellItem, at indexPath: IndexPath)
    func didTapped(source: SourceCellItem, at indexPath: IndexPath)
    func didChangeLanguage(newLanguage: String)
}

enum SourcesListPresenterOutput {
    case loading
    case hideLoading
    case failed(_ reason: String)
    case reloadCategories(_ categories: [SourceCategoryCellItem])
    case reloadSources(_ sources: [SourceCellItem])
}

// MARK: View

protocol SourcesListViewProtocol: AnyObject {
    func handle(_ output: SourcesListPresenterOutput)
}

// MARK: Router

enum SourcesListRoute: Equatable {
    case openTopHeadlines(_ item: SourceCellItem)
}

protocol SourcesListRouterProtocol: AnyObject {
    func navigate(to route: SourcesListRoute)
}
