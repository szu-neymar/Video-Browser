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
        configsegmentedView()
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
