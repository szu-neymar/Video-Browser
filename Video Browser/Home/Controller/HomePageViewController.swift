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
    
    var channelModels: [FYChannelModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "首页"
        view.backgroundColor = .white
        configTabBar()
        fetchChannelModels()
        configSegmentedView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    private func fetchChannelModels() {
        let rule0 = """
        海阔视界规则分享，当前分享的是：首页频道￥home_rule￥{"firstHeader":"class","title":"菲菲影视","url":"https://lm.didibib.ml/index.php/vod/type/id/fyAll/page/fypage.html","col_type":"movie_3","class_name":"电影&连续剧&综艺&动漫","class_url":"1&2&3&4","area_name":"","area_url":"","year_name":"","year_url":"","find_rule":".stui-vodlist&&li;h4&&Text;.lazyload&&data-original;.pic-text&&Text;a&&href","search_url":"https://lm.didibib.ml/index.php/vod/search.html?wd=**","titleColor":"#f20c00","group":"③影视","searchFind":".stui-vodlist&&li;h4&&a&&Text;h4&&a&&href;.pic-text&&Text;*;.lazyload&&data-original"}
        """
        let rule1 = """
        海阔视界规则分享，当前分享的是：首页频道￥home_rule￥{"firstHeader":"class","title":"90后影视","url":"http://kan1990.com/vodshow/fyclass-fyarea-------fypage---fyyear/","col_type":"movie_3","class_name":"电影&剧集&综艺&动漫&|&动作&喜剧&爱情&科幻&恐怖&战争&剧情&纪录&|&国产剧&港台剧&海外剧&日韩剧&日本剧&欧美剧&台湾剧&韩国剧","class_url":"dianying&lianxuju&zongyi&dongman&|&dongzuopian&xijupian&aiqingpian&kehuanpian&kongbupian&zhanzhengpian&juqingpian&jilupian&|&guochanju&gangtaiju&haiwaiju&rihanju&ribenju&oumeiju&taiwanju&hanguoju","area_name":"全部&大陆&香港&台湾&美国&法国&英国&日本&韩国&德国&泰国&印度&意大利&西班牙&加拿大&其他","area_url":"&大陆&香港&台湾&美国&法国&英国&日本&韩国&德国&泰国&印度&意大利&西班牙&加拿大&其他","year_name":"全部&2020&2019&2018&2017&2016&2015&2014&2013&2012&2011&2010&","year_url":"&2020&2019&2018&2017&2016&2015&2014&2013&2012&2011&2010&","find_rule":"body&&.fed-list-item;.fed-list-title&&Text;.fed-list-pics&&data-original;.fed-list-remarks&&Text;a&&href","search_url":"","titleColor":"#f20c00","group":"③影视","searchFind":""}
        """
        let rule2 = """
        海阔视界规则分享，当前分享的是：首页频道￥home_rule￥{"firstHeader":"class","title":"91影院","url":"https://www.91cinema.cn/vshow/fyAll--------fypage---.html;get;utf-8;{User-Agent@Windows}","col_type":"movie_3","class_name":"电影&剧集&综艺&动漫&写真","class_url":"1&2&3&4&20","area_name":"动作&喜剧&爱情&科幻&恐怖&剧情&战争","area_url":"6&7&8&9&10&11&12","year_name":"国产剧&港台剧&日韩剧&欧美剧","year_url":"13&14&15&16","find_rule":"body&&.yk-pack;a&&title;img&&src;.playshow&&Text;a&&href","search_url":"https://www.91cinema.cn/vsearch/**-------------.html","titleColor":"#ff0000","group":"③影视"}
        """
        
        let rule3 = """
        海阔视界规则分享，当前分享的是：首页频道￥home_rule￥{"firstHeader":"class","title":"Q2002影视","url":"http://www.k2938.com/type/fyclass/fypage.html;get;utf-8;{User-Agent@Mozilla 5.0}","col_type":"movie_3","class_name":"电影&剧集&综艺&动漫&恐怖&福利","class_url":"1&2&4&7&9&13","area_name":"","area_url":"","year_name":"","year_url":"","find_rule":"body&&.movie-item;img&&alt;img&&src;.hdtag&&Text;a&&href","search_url":"http://www.k2938.com/search?wd=**","titleColor":"#ffa400","group":"③影视"}
        """
        
        let rule4 = """
        海阔视界规则分享，当前分享的是：首页频道￥home_rule￥{"firstHeader":"class","title":"TVB云播","url":"https://m.hktvyb.com/vod/show/fyarea/fyclass/page/fypage/fyyear.html","col_type":"movie_3","class_name":"电影&电视剧&综艺&动漫&|&动作片&喜剧片&爱情片&科幻片&恐怖片&剧情片&战争片&|&国产剧&港台剧&日韩剧&欧美剧","class_url":"id/1&id/2&id/3&id/4&&id/6&id/7&id/8&id/9&id/10&id/11&id/12&&id/13&id/14&id/15&id/16","area_name":"地区&大陆&香港&台湾&香港&台湾&美国&法国&英国&日本&韩国&德国&泰国&印度&意大利&西班牙&加拿大&其他","area_url":"&/area/大陆&/area/香港&/area/台湾&/area/香港&/area/台湾&/area/美国&/area/法国&/area/英国&/area/日本&/area/韩国&/area/德国&/area/泰国&/area/印度&/area/意大利&/area/西班牙&/area/加拿大&/area/其他","year_name":"年代&2019&2018&2017&2016&2015&2014&2013&2012&2011&2010&2009&2008&2007&2006&2005&2004","year_url":"&/year/2019&/year/2018&/year/2017&/year/2016&/year/2015&/year/2014/&year/2013/&year/2012/&year/2011&/year/2010&/year/2009&/year/2008&/year/2007&/year/2006&/year/2005&/year/2004","find_rule":".myui-vodlist&&li;a&&title;a&&data-original;.pic-text&&Text;a&&href","search_url":"https://m.hktvyb.com/vod/search.html?wd=**","titleColor":"#f20c00","group":"③影视"}
        """
        
        let rule5 = """
        海阔视界规则分享，当前分享的是：首页频道￥home_rule￥{"firstHeader":"class","title":"VIP电影网","url":"http://www.vip1280.net/frim/indexfyAll-fypage.html","col_type":"movie_3","class_name":"电影&电视剧&港台&欧美&日韩&泰剧","class_url":"1&2&3&4&28&29","area_name":"动作片&爱情片&科幻片&恐怖片&战争片&喜剧片&纪录片&剧情片","area_url":"5&6&7&8&9&10&11&12","year_name":"微电影&冒险片&悬疑片&犯罪片&灾难片&魔幻片&青春片&音乐片&惊悚片&动画片&奇幻片","year_url":"30&31&32&33&34&35&36&37&38&39&40","find_rule":"body&&.col-md-6;a&&title;a&&style;.pic-text&&Text;a&&href","search_url":"http://www.vip1280.net/search.php?searchword=**","titleColor":"#f20c00","group":"③影视","searchFind":""}
        """
        
        let rules = [rule0, rule1, rule2, rule3, rule4, rule5]
        
        rules.forEach { (rule) in
            if let str = Parser.getDictString(from: rule, ruleType: .home), let dict = str.dictValue, let data = try? JSONSerialization.data(withJSONObject: dict, options: []) {
                if let model = try? JSONDecoder().decode(FYSourceModel.self, from: data) {
                    let channelModel = FYChannelModel(with: model)
                    channelModels.append(channelModel)
                }
            }
        }
        
    }

}
