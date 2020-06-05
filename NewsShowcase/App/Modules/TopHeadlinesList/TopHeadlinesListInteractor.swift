//
//  TopHeadlinesListInteractor.swift
//  NewsShowcase
//
//  Created by Yunus Alkan on 5.06.2020.
//  Copyright © 2020 Yunus Alkan. All rights reserved.
//

import Foundation

private enum Consts {
    static let slideDuration: TimeInterval = 3
    static let autoRefreshDuration: TimeInterval = 60
}

final class TopHeadlinesListInteractor: BaseInteractor<NewsService>, TopHeadlinesListInteractorProtocol {
    weak var delegate: TopHeadlinesListInteractorDelegate?
    
    private var entity: ArticlesEntity
    private var topHeadlinesReqModel: TopHeadlinesRequestModel
    private weak var slideTimer: Timer?
    private weak var autoRefreshTimer: Timer?
    
    required init(source: SourceCellItem) {
        entity = ArticlesEntity(source: source, articles: [])
        topHeadlinesReqModel = TopHeadlinesRequestModel(sources: source.id ??
            source.name ??
            "")
    }
    
    func fetchHeadlines(_ isRefresh: Bool) {
        if !isRefresh {
            delegate?.handle(.loading)
        }
        
        serviceProvider?.request(.getTopHeadlines(topHeadlinesReqModel),
                                 model: [Article].self,
                                 path: "articles", { [weak self] (result) in
                                    self?.delegate?.handle(.finishLoading)
                                    
                                    switch result {
                                    case .success(let articles):
                                        self?.updateData(articles: articles)
                                        self?.setupAutoRefreshTimer()
                                    case .failure(let err):
                                        self?.delegate?.handle(.failed(err.message ?? ""))
                                    }
        })
    }
    
    func startSlideTimer() {
        if slideTimer != nil {
            stopSlider()
        }
        
        slideTimer = Timer.scheduledTimer(timeInterval: Consts.slideDuration,
                                          target: self,
                                          selector: #selector(slide),
                                          userInfo: nil,
                                          repeats: true)
    }
    
    func stopSlider() {
        slideTimer?.invalidate()
        slideTimer = nil
    }
    
    func stopAutoRefresher() {
        autoRefreshTimer?.invalidate()
        autoRefreshTimer = nil
    }
    
    private func updateData(articles: [Article]) {
        let items = articles.map { ArticleCellItem(author: $0.author,
                                                   title: $0.title,
                                                   description: $0.description,
                                                   content: $0.content,
                                                   imageUrl: $0.urlToImage,
                                                   publishedAt: $0.publishedAt,
                                                   isBookmarked: false) }
        
        var sliderItems: [ArticleCellItem] = []
        var restItems: [ArticleCellItem] = []
        
        for idx in items.indices {
            let itm = items[idx]
            
            if idx < 3 {
                sliderItems.append(itm)
            } else {
                restItems.append(itm)
            }
        }
        
        entity.sliderItems = sliderItems
        entity.articles = restItems
        
        delegate?.handle(.reloadSlider(sliderItems))
        delegate?.handle(.reloadData(restItems))
    }
    
    private func setupAutoRefreshTimer() {
        if autoRefreshTimer != nil {
            stopAutoRefresher()
        }
        
        autoRefreshTimer = Timer.scheduledTimer(timeInterval: Consts.autoRefreshDuration,
                                                target: self,
                                                selector: #selector(checkNewData),
                                                userInfo: nil,
                                                repeats: true)
    }
    
    @objc private func slide() {
        guard !entity.sliderItems.isEmpty else {
            stopSlider()
            return
        }
        
        let position = entity.currentSlideIndex + 1 <= entity.sliderItems.count - 1 ?
            entity.currentSlideIndex + 1 : 0
        
        entity.currentSlideIndex = position
        delegate?.handle(.slide(section: 0, item: position))
    }
    
    @objc private func checkNewData() {
        serviceProvider?.request(.getTopHeadlines(topHeadlinesReqModel),
                                 model: [Article].self,
                                 path: "articles", { [weak self] (result) in
                                    guard let self = self else {
                                        return
                                    }
                                    
                                    switch result {
                                    case .success(let articles):
                                        guard self.entity.sliderItems.first?.title != articles.first?.title else {
                                            return
                                        }
                                        
                                        self.updateData(articles: articles)
                                    case .failure(let err):
                                        Logger.log(.error(message: err.localizedDescription, error: err))
                                    }
        })
    }
}
