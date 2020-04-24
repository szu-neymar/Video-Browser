//
//  MovieListViewController.swift
//  Video Browser
//
//  Created by mayc on 2020/4/24.
//  Copyright © 2020 MC Equipment. All rights reserved.
//

import UIKit
import JXSegmentedView

class MovieListViewController: UIViewController {
    
    var movieCollectionView: UICollectionView!
    
    var movieInfos: [MovieInfo] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
        loadMovieList()
    }
    
    private func configCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let screenWidth = UIScreen.main.bounds.width
        let itemWidth = (screenWidth - 4 * 10) / 3.0
        let itemHeight = itemWidth * 4.0 / 3.0 + 30
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.scrollDirection = .vertical
        
        movieCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        movieCollectionView.backgroundColor = .white
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        
        movieCollectionView.register(MovieInfoCell.self, forCellWithReuseIdentifier: NSStringFromClass(MovieInfoCell.self))
        
        view.addSubview(movieCollectionView)
        movieCollectionView.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    private func loadMovieList() {
        let rule = ".figures_list&&li;.figure_title&&Text;.figure&&style;.mask_txt&&Text!更新至;a&&href"
        let urlString = "http://www.81ju.cn/?m=vod-type-id-1.html"

        Parser.getMovies(from: urlString, rule: rule, baseUrl: "http://www.81ju.cn") { (movies) in
            self.movieInfos = movies
            self.movieCollectionView.reloadSections([0])
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
            let browserController = BrowserViewController()
            navigationController?.pushViewController(browserController, animated: true)
            browserController.load(urlString: href)
        }
    }
    
    
}

extension MovieListViewController: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}
