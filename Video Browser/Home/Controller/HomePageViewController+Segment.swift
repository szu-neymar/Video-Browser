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
        
        let line = UIView()
        line.backgroundColor = .lightGray
        segmentedView.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.leading.bottom.trailing.equalToSuperview()
            make.height.equalTo(0.5)
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
        var movieListController = MovieListViewController()

        switch index {
//        case 0:
//            
//            break
        default:
            let copy = """
            海阔视界规则分享，当前分享的是：首页频道￥home_rule￥{"firstHeader":"class","title":"菲菲影视","url":"https://lm.didibib.ml/index.php/vod/type/id/fyAll/page/fypage.html","col_type":"movie_3","class_name":"电影&连续剧&综艺&动漫","class_url":"1&2&3&4","area_name":"","area_url":"","year_name":"","year_url":"","find_rule":".stui-vodlist&&li;h4&&Text;.lazyload&&data-original;.pic-text&&Text;a&&href","search_url":"https://lm.didibib.ml/index.php/vod/search.html?wd=**","titleColor":"#f20c00","group":"③影视","searchFind":".stui-vodlist&&li;h4&&a&&Text;h4&&a&&href;.pic-text&&Text;*;.lazyload&&data-original"}
            """
            if let str = Parser.getDictString(from: copy, ruleType: .home), let dict = str.dictValue, let data = try? JSONSerialization.data(withJSONObject: dict, options: []) {
                if let model = try? JSONDecoder().decode(FYSourceModel.self, from: data) {
                    let channelModel = FYChannelModel(with: model)
                    movieListController = MovieListViewController(channelModel: channelModel)
                }
                print(dict)
            }
            
        }
        return movieListController
    }
}
