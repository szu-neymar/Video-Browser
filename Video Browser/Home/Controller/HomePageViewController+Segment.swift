//
//  HomePageViewController+Segment.swift
//  Video Browser
//
//  Created by mayc on 2020/4/23.
//  Copyright © 2020 MC Equipment. All rights reserved.
//

import UIKit
import JXSegmentedView

extension HomePageViewController: JXSegmentedListContainerViewDataSource {
    
    func configsegmentedView() {
        let titles = ["首页", "视频", "腾讯视频", "爱奇艺", "芒果TV", "优酷视频", "爱土豆", "抖音", "快手"]
        segmentedDataSource = JXSegmentedTitleDataSource()
        segmentedDataSource?.isTitleColorGradientEnabled = true
        segmentedDataSource?.titles = titles
        segmentedDataSource?.titleSelectedZoomScale = 1.2
        segmentedDataSource?.isTitleStrokeWidthEnabled = true
        segmentedDataSource?.isTitleZoomEnabled = true
        segmentedDataSource?.isSelectedAnimable = true
        segmentedView.dataSource = segmentedDataSource
        let indicator = JXSegmentedIndicatorLineView()
        indicator.indicatorWidth = 15
        indicator.verticalOffset = 3
        indicator.lineStyle = .lengthen
        segmentedView.indicators = [indicator]
        view.addSubview(segmentedView)
        
        segmentedView.listContainer = listContainerView
        view.addSubview(listContainerView)
        
        segmentedView.snp.makeConstraints { (make) in
            make.leading.width.equalToSuperview()
            make.top.equalTo(44)
            make.height.equalTo(40)
        }
        
        listContainerView.snp.makeConstraints { (make) in
            make.leading.width.equalToSuperview()
            make.top.equalTo(segmentedView.snp.bottom)
            make.bottom.equalTo(-49 - 34)
        }
    }
    
    // MARK: - JXSegmentedListContainerViewDataSource
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        if let dataSource = segmentedDataSource {
            return dataSource.dataSource.count
        }
        return 0
    }
    
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        return ListBaseViewController()
    }
}
