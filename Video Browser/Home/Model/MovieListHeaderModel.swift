//
//  MovieListHeaderModel.swift
//  Video Browser
//
//  Created by mayc on 2020/4/28.
//  Copyright © 2020 MC Equipment. All rights reserved.
//

import Foundation

struct MovieListHeaderModel {
    var headerTitles: [[String]] = []   // 关键词(标题)
    var fyReplaceKeys: [String] = []  // 关键词替换键
    var headerReplaceValues: [[String]] = []      // 关键词替换词
    
    
    var seletedHeaderIndexs: [ChannelHeaderIndex]  // 被选中项
}
