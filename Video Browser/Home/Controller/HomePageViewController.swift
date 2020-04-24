//
//  HomePageViewController.swift
//  Video Browser
//
//  Created by mayc on 2020/4/20.
//  Copyright © 2020 MC Equipment. All rights reserved.
//

import UIKit
import SnapKit
import JXSegmentedView
import SwiftSoup

class HomePageViewController: UIViewController {
    
    // MARK: - Segment
    let segmentedView = JXSegmentedView()
    var segmentedDataSource: JXSegmentedTitleDataSource?
    lazy var listContainerView: JXSegmentedListContainerView! = {
        return JXSegmentedListContainerView(dataSource: self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configTabBar()
        configSegmentedView()
        
//        let rule = ".figures_list&&li;.figure_title&&Text;.figure&&style;.mask_txt&&Text!更新至;a&&href"
//        let urlString = "http://www.81ju.cn/?m=vod-type-id-1.html"
        
        let rule = "body&&.movie-item;.movie-name&&Text;img&&src;span,0&&Text!-;a&&href"
        let urlString = "http://www.k2938.com/type/1/1.html"

        
        let movies = Parser.getMovies(from: urlString, rule: rule)
        print(movies)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = (segmentedView.selectedIndex == 0)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    

}
