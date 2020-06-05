//
//  SourcesListInteractor.swift
//  NewsShowcase
//
//  Created by Yunus Alkan on 5.06.2020.
//  Copyright © 2020 Yunus Alkan. All rights reserved.
//

import Foundation

final class SourcesListInteractor: BaseInteractor<NewsService>, SourcesListInteractorProtocol {

    weak var delegate: SourcesListInteractorDelegate?

    private var entity: SourcesEntity = SourcesEntity(sources: [])
    private var sourcesReqModel = SourcesRequestModel()

    func fetchSources() {
        delegate?.handle(.loading)
        serviceProvider?.request(.getSources(sourcesReqModel),
                                 model: [Source].self,
                                 path: "sources", { [weak self] (result) in
                                    self?.delegate?.handle(.finishLoading)

                                    switch result {
                                    case .success(let sources):
                                        let entity = SourcesEntity(sources: sources)
                                        self?.entity = entity
                                        self?.delegate?.handle(.filteredCategories(entity.categories))
                                        self?.delegate?.handle(.filteredSources(entity.sources))
                                    case .failure(let err):
                                        self?.delegate?.handle(.failed(err.message ?? ""))
                                    }
        })
    }

    private func updateSources() {
        delegate?.handle(.filteredSources(entity.sourcesForSelectedCategories))
    }

    func didTapped(category: SourceCategoryCellItem, at indexPath: IndexPath) {
        entity.categories[safe: indexPath.row] = category
        updateSources()
    }

    func didTapped(source: SourceCellItem, at indexPath: IndexPath) {
        
    }

    func didChangeLanguage(newLanguage: String) {

    }
}
