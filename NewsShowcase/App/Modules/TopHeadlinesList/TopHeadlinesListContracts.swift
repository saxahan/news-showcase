//
//  TopHeadlinesListContracts.swift
//  NewsShowcase
//
//  Created by Yunus Alkan on 5.06.2020.
//  Copyright © 2020 Yunus Alkan. All rights reserved.
//

import Foundation

// MARK: Interactor

protocol TopHeadlinesListInteractorProtocol: BaseInteractor<NewsService> {
    var delegate: TopHeadlinesListInteractorDelegate? { get set }

    func fetchHeadlines(_ isRefresh: Bool)
    func startSlideTimer()
    func stopSlider()
    func stopAutoRefresher()
    func bookmarkTapped(item: ArticleCellItem)
}

enum TopHeadlinesListInteractorOutput: Equatable {
    case loading
    case finishLoading
    case reloadSlider(_ items: [ArticleCellItem])
    case reloadData(_ items: [ArticleCellItem])
    case failed(_ reason: String, status: ResultStatus)
    case slide(section: Int, item: Int)
}

protocol TopHeadlinesListInteractorDelegate: AnyObject {
    func handle(_ output: TopHeadlinesListInteractorOutput)
}

// MARK: Presenter

protocol TopHeadlinesListPresenterProtocol {
    func loadSources(isPullToRefresh: Bool)
    func startSlideTimer()
    func stopSlider()
    func stopAutoRefresher()
    func bookmarkTapped(item: ArticleCellItem)
}

enum TopHeadlinesListPresenterOutput {
    case loading
    case hideLoading
    case failed(_ reason: String, status: ResultStatus)
    case reloadSlider(_ items: [ArticleCellItem])
    case reloadData(_ items: [ArticleCellItem])
    case slide(section: Int, item: Int)
}

// MARK: View

protocol TopHeadlinesListViewProtocol: AnyObject {
    func handle(_ output: TopHeadlinesListPresenterOutput)
}

// MARK: Router

enum TopHeadlinesListRoute: Equatable {
    case openTopHeadlines(_ item: SourceCellItem)
}

protocol TopHeadlinesListRouterProtocol: AnyObject {
    func navigate(to route: TopHeadlinesListRoute)
}
