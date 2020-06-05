//
//  SourcesListViewController.swift
//  NewsShowcase
//
//  Created by Yunus Alkan on 5.06.2020.
//  Copyright © 2020 Yunus Alkan. All rights reserved.
//

import UIKit
import SVProgressHUD

private enum Consts {
    static let categorySectionInsets = UIEdgeInsets(top: 5, left: 12, bottom: 5, right: 12)
    static let categoryItemPadding: CGFloat = 5
}

class SourcesListViewController: BaseViewController<SourcesListPresenter> {

    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var tableView: UITableView!

    private var refreshControl: UIRefreshControl!

    private var categories: [SourceCategoryCellItem] = []
    private var sources: [SourceCellItem] = []

    override func setupInitials() {
        collectionView.register(SourceCategoryCell.self)
        collectionView.allowsMultipleSelection = true
        collectionView.dataSource = self
        collectionView.delegate = self

        tableView.register(SourceItemCell.self)
        tableView.dataSource = self
        tableView.delegate = self

        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)

        navigationController?.navigationItem.rightBarButtonItem = .createButton(title: "en",
                                                                                target: self,
                                                                                action: #selector(languageTapped))

        presenter?.loadSources(isPullToRefresh: false)
    }

    @objc private func refresh(_ sender: Any) {
        presenter?.loadSources(isPullToRefresh: true)
    }

    @objc private func languageTapped() {
//        presenter?.loadSources()
    }
}

// MARK: - SourcesListViewProtocol

extension SourcesListViewController: SourcesListViewProtocol {
    func handle(_ output: SourcesListPresenterOutput) {
        switch output {
        case .loading:
            SVProgressHUD.show()
        case .hideLoading:
            SVProgressHUD.dismiss()
            refreshControl?.endRefreshing()
        case .failed(let reason):
            SVProgressHUD.dismiss()
            SVProgressHUD.show(withStatus: reason)
            SVProgressHUD.dismiss(withDelay: 2)
        case .reloadCategories(let categories):
            self.categories = categories
            collectionView.reloadData()
        case .reloadSources(let sources):
            self.sources = sources
            tableView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource

extension SourcesListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: SourceCategoryCell.self)
        let item = categories[safe: indexPath.row]
        cell.item = item

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var item = categories[safe: indexPath.row]
        item?.isSelected = true
        categories[safe: indexPath.row] = item
        collectionView.cell(for: indexPath, cellType: SourceCategoryCell.self)?.item = item

        if let category = item {
            presenter?.didTapped(category: category, at: indexPath)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        var item = categories[safe: indexPath.row]
        item?.isSelected = false
        categories[safe: indexPath.row] = item
        collectionView.cell(for: indexPath, cellType: SourceCategoryCell.self)?.item = item

        if let category = item {
            presenter?.didTapped(category: category, at: indexPath)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension SourcesListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return Consts.categorySectionInsets
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Consts.categoryItemPadding
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Consts.categoryItemPadding
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let parentHeight = collectionView.frame.height
        var cellSize = CGSize(width: 0, height: parentHeight - 2 * Consts.categoryItemPadding)

        if let text = categories[safe: indexPath.row]?.name as NSString? {
            let textSize = text.size(withAttributes: [.font: UIFont.systemFont(ofSize: 16)])
            cellSize.width = 10 * Consts.categoryItemPadding + textSize.width
        }

        return cellSize
    }
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource

extension SourcesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sources.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: SourceItemCell.self)
        let item = sources[safe: indexPath.row]
        cell.item = item

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if let source = tableView.cell(for: indexPath, cellType: SourceItemCell.self)?.item {
            presenter?.didTapped(source: source, at: indexPath)
        }
    }
}
