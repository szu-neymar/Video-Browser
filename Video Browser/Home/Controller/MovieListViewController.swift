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
        view.backgroundColor = UIColor(red: CGFloat(arc4random()%255)/255, green: CGFloat(arc4random()%255)/255, blue: CGFloat(arc4random()%255)/255, alpha: 1)
        configCollectionView()
        loadMovieList()
    }
    
    private func configCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let screenWidth = UIScreen.main.bounds.width
        let itemWidth = (screenWidth - 4 * 10) / 3.0
        let itemHeight = itemWidth * 16.0 / 9.0 + 30
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        movieCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        movieCollectionView.backgroundColor = .white
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        
        movieCollectionView.register(MovieInfoCell.self, forCellWithReuseIdentifier: NSStringFromClass(MovieInfoCell.self))
        
        view.addSubview(movieCollectionView)
        movieCollectionView.frame = view.bounds
    }
    
    private func loadMovieList() {
        let rule = "body&&.movie-item;.movie-name&&Text;img&&src;span,0&&Text!- ;a&&href"
        let urlString = "http://www.k2938.com/type/1/1.html"

        
        let movies = Parser.getMovies(from: urlString, rule: rule, baseUrl: "http://www.k2938.com")
        movieInfos = movies
        movieCollectionView.reloadData()
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
    
    
}

extension MovieListViewController: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}
