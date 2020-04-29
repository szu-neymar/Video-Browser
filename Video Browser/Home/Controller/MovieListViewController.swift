//
//  MovieListViewController.swift
//  Video Browser
//
//  Created by mayc on 2020/4/24.
//  Copyright © 2020 MC Equipment. All rights reserved.
//

import UIKit
import JXSegmentedView
import MJRefresh

class MovieListViewController: UIViewController {
    
    var movieCollectionView: UICollectionView!
    
    private var movieInfos: [MovieInfo] = []    // 视频列表
    private var currentPage = 1     // 最新加载的页码
    
    var channelModel: FYChannelModel!
    
    var headerModel: MovieListHeaderModel?
    
    convenience init(channelModel: FYChannelModel) {
        self.init(nibName: nil, bundle: nil)
        self.channelModel = channelModel
        parseChannelInfos()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
    }
    
    private func configCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let screenWidth = UIScreen.main.bounds.width
        let itemWidth = (screenWidth - 4 * 10) / 3.0
        let itemHeight = itemWidth * 4.0 / 3.0 + 30
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        if let headerRows = headerModel?.headerTitles.count {
            layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: CGFloat(30 * headerRows + 5))
        }
        layout.sectionInset = UIEdgeInsets(top: 5, left: 10, bottom: 10, right: 10)
        layout.scrollDirection = .vertical
        
        movieCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        movieCollectionView.backgroundColor = .white
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        
        movieCollectionView.register(MovieInfoCell.self, forCellWithReuseIdentifier: NSStringFromClass(MovieInfoCell.self))
        movieCollectionView.register(MovieListHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: NSStringFromClass(MovieListHeader.self))
        
        view.addSubview(movieCollectionView)
        movieCollectionView.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        let mjHeader = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(loadFirstPage))
        mjHeader.lastUpdatedTimeLabel?.isHidden = true
        mjHeader.stateLabel?.isHidden = true
        movieCollectionView.mj_header = mjHeader
        movieCollectionView.mj_header?.beginRefreshing()
    }
    
    @objc private func loadFirstPage() {
        Parser.getMovies(from: firstPageReplaced, rule: channelModel.htmlParseRule) { (result) in
            self.movieCollectionView.mj_header?.endRefreshing()
            switch result {
            case .success(let movies):
                if movies.count > 0 {
                    self.movieInfos = movies
                    // 有些网页页码索引从 1 开始，对这种情况做一个简单兼容
                    if self.firstPageReplaced.elementsEqual(self.getURLReplaced().url(ofPage: 1)) {
                        self.currentPage = 1
                    } else {
                        self.currentPage = 0
                    }
                    self.movieCollectionView.reloadData()
                    self.configFooterIfNeed()
                }
            case .failure(let error):
                self.movieCollectionView.mj_footer = nil
                print(error.desc)
            }
        }
    }
    
    @objc private func loadMore() {
        Parser.getMovies(from: getURLReplaced().url(ofPage: currentPage + 1), rule: channelModel.htmlParseRule) { (result) in
            switch result {
            case .success(let movies):
                if movies.count > 0 {
                    self.currentPage += 1
                    self.movieInfos.append(contentsOf: movies)
                    self.movieCollectionView.reloadData()
                    self.movieCollectionView.mj_footer?.endRefreshing()
                }
            case .failure(let error):
                self.movieCollectionView.mj_footer?.endRefreshingWithNoMoreData()
                print(error.desc)
            }
        }
    }
    
    private func configFooterIfNeed() {
        if getURLReplaced().canLoadMorePage {
            let footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(self.loadMore))
            footer.isRefreshingTitleHidden = true
            self.movieCollectionView.mj_footer = footer
        }
    }

}

extension MovieListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieInfos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(MovieInfoCell.self), for: indexPath) as? MovieInfoCell {
            cell.config(with: movieInfos[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? MovieInfoCell,
            let movie = cell.movieInfo, let href = movie.href {
            let browserController = WebBrowser(urlString: href)
            navigationController?.pushViewController(browserController, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader{
            if let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: NSStringFromClass(MovieListHeader.self), for: indexPath) as? MovieListHeader {
                header.delegate = self
                if let model = headerModel {
                    header.config(with: model.headerTitles, allowsMultiSelected: channelModel.allowsMultiSelected)
                }
                return header
            }
        }
        return UICollectionReusableView()
    }
    
}

extension MovieListViewController: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}
