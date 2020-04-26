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
    
    func configSegmentedView() {
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
        let movieListController = MovieListViewController()

        switch index {
        case 0:
            movieListController.rule = ".stui-vodlist&&li;.title&&Text;a&&data-original;.pic-text&&Text;a&&href"
            movieListController.urlString = "http://huubaa.com/lists/2_2.html"
            movieListController.baseUrl = "http://huubaa.com"
        case 1:
            movieListController.rule = ".tubiao&&.zu;a,1&&Text;img&&src;.kebo&&Text;a&&href"
            movieListController.urlString = "https://www.laodouban.com/dianshiju/0"
            movieListController.baseUrl = "https://www.laodouban.com"
        case 2:
            movieListController.urlString = "https://www.shenma4480.com/type/dianying-0/"
            movieListController.baseUrl = "https://www.shenma4480.com"
            movieListController.rule = "body&&.stui-vodlist__item;a&&title;a&&mip-img&&src;.pic-text&&Text;a&&href"
        case 3:
            movieListController.urlString = "https://www.novipnoad.com/movie/page/0"
            movieListController.baseUrl = "https://www.novipnoad.com"
            movieListController.rule = ".post_ajax_tm&&.row&&.col-md-3;.item-head&&a&&Text;img&&data-original;.item-content&&Text;.item-thumbnail&&a&&href"
        default:
            movieListController.rule = ".figures_list&&li;.figure_title&&Text;.figure&&style;.mask_txt&&Text!更新至;a&&href"
            movieListController.urlString =  "http://www.81ju.cn/?m=vod-type-id-1.html"
            movieListController.baseUrl = "http://www.81ju.cn"
        }
        return movieListController
    }
}
