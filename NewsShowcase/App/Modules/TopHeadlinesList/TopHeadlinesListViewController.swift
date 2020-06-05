//
//  TopHeadlinesListViewController.swift
//  NewsShowcase
//
//  Created by Yunus Alkan on 5.06.2020.
//  Copyright © 2020 Yunus Alkan. All rights reserved.
//

import UIKit
import SVProgressHUD

private enum Consts {
    static let cellHeight: CGFloat = UIScreen.main.bounds.height / 3.3
}

class TopHeadlinesListViewController: BaseViewController<TopHeadlinesListPresenter> {

    @IBOutlet private weak var collectionView: UICollectionView!

    private var refreshControl: UIRefreshControl!
    private var resultStatusView: ResultStatusView = ResultStatusView()
    private var sliderItems: [ArticleCellItem] = []
    private var items: [ArticleCellItem] = []

    override func setupInitials() {
        collectionView.register(ArticleSliderCell.self)
        collectionView.register(ArticleCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self

        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        collectionView.addSubview(refreshControl)

        resultStatusView.frame = collectionView.frame
        collectionView.backgroundView = resultStatusView

        presenter?.loadSources(isPullToRefresh: false)
    }

    @objc private func refresh(_ sender: Any) {
        presenter?.loadSources(isPullToRefresh: true)
    }

    deinit {
        presenter?.stopSlider()
        presenter?.stopAutoRefresher()
    }
}

// MARK: - TopHeadlinesListViewProtocol

extension TopHeadlinesListViewController: TopHeadlinesListViewProtocol {
    func handle(_ output: TopHeadlinesListPresenterOutput) {
        switch output {
        case .loading:
            SVProgressHUD.show()
        case .hideLoading:
            SVProgressHUD.dismiss()
            refreshControl?.endRefreshing()
        case .failed(let reason, let status):
            SVProgressHUD.dismiss()
            resultStatusView.item = (status, reason)
        case .reloadSlider(let items):
            sliderItems = items
            collectionView.reloadData()
            presenter?.startSlideTimer()
        case .reloadData(let items):
            self.items = items
            collectionView.reloadData()
        case .slide(let section, let item):
            collectionView.cell(for: IndexPath(item: section, section: section),
                cellType: ArticleSliderCell.self)?.slide(to: item)
        }
    }
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource

extension TopHeadlinesListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return !sliderItems.isEmpty ? 1 : 0
        }

        return items.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: ArticleSliderCell.self)
            cell.item = sliderItems
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: ArticleCell.self)
            cell.item = items[safe: indexPath.row]
            cell.delegate = self
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension TopHeadlinesListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width,
                      height: Consts.cellHeight +
            CGFloat(indexPath.section == 0 ? 20 : 0))
    }
}

// MARK: - ArticleCellDelegate

extension TopHeadlinesListViewController: ArticleCellDelegate {
    func bookmarkTapped(item: ArticleCellItem) {
        presenter?.bookmarkTapped(item: item)
        collectionView.reloadData()
    }
}
