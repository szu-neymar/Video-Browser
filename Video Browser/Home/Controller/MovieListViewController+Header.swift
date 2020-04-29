//
//  MovieListViewController+Parse.swift
//  Video Browser
//
//  Created by mayc on 2020/4/28.
//  Copyright © 2020 MC Equipment. All rights reserved.
//

import UIKit

struct ChannelHeaderIndex {
    var row: Int
    var col: Int
}

extension MovieListViewController {
    
    func parseChannelInfos() {
        var headerTitles: [[String]] = []
        var headerReplaceValues: [[String]] = []
        var headerReplaceKeys: [String] = []
        var selectedIndexs: [ChannelHeaderIndex] = []
        
        if let types = channelModel.videoClasses, let typeReplaces = channelModel.videoClasseReplaces, types.count == typeReplaces.count, types.count > 0 {
            headerTitles.append(types)
            headerReplaceValues.append(typeReplaces)
            headerReplaceKeys.append(FYURLField.type.rawValue)
        }
        if let areas = channelModel.videoAreas, let areaReplaces = channelModel.videoAreaReplaces, areas.count == areaReplaces.count, areas.count > 0 {
            headerTitles.append(areas)
            headerReplaceValues.append(areaReplaces)
            headerReplaceKeys.append(FYURLField.area.rawValue)
        }
        if let years = channelModel.videoYears, let yearReplaces = channelModel.videoYearReplaces, years.count == yearReplaces.count, years.count > 0 {
            headerTitles.append(years)
            headerReplaceValues.append(yearReplaces)
            headerReplaceKeys.append(FYURLField.year.rawValue)
        }
        
        guard headerTitles.count > 0 else { return }
            
        if !channelModel.allowsMultiSelected {
            headerReplaceKeys = [FYURLField.all.rawValue]
            selectedIndexs = [ChannelHeaderIndex(row: 0, col: 0)]
        } else {
            for row in 0..<headerTitles.count {
                selectedIndexs.append(ChannelHeaderIndex(row: row, col: 0))
            }
        }
        
        let model = MovieListHeaderModel(headerTitles: headerTitles, fyReplaceKeys: headerReplaceKeys, headerReplaceValues: headerReplaceValues, seletedHeaderIndexs: selectedIndexs)
        self.headerModel = model
    }
    
    func getFirstPageURL() -> String {
        return channelModel.firstPageUrl
    }
        
    func getURLString(of page: Int) -> String? {
        
        
        return nil
    }
    
    var channelURLReplaced: String {
        return getURLReplaced(with: channelModel.channelURL)
    }
    
    var firstPageReplaced: String {
        return getURLReplaced(with: channelModel.firstPageUrl)
        
    }
    
    private func getURLReplaced(with url: String) -> String {
        var res = url
        if let model = headerModel {
            for index in model.seletedHeaderIndexs {
                let row = channelModel.allowsMultiSelected ? index.row : 0
                res = res.replacingOccurrences(of: model.fyReplaceKeys[row], with: model.headerReplaceValues[index.row][index.col])
            }
        }
        return res
    }
}


extension MovieListViewController: MovieListHeaderDelegate {
    func movieListHeader(_: MovieListHeader, selctedAt row: Int, index: Int) {
        if channelModel.allowsMultiSelected {
            if let indexs = headerModel?.seletedHeaderIndexs, row < indexs.count, indexs[row].col != index {
                headerModel?.seletedHeaderIndexs[row] = ChannelHeaderIndex(row: row, col: index)
                movieCollectionView.mj_header?.beginRefreshing()
            }
        } else {
            if let lastSelectedIndex = headerModel?.seletedHeaderIndexs.first, (lastSelectedIndex.row != row || lastSelectedIndex.col != index) {
                headerModel?.seletedHeaderIndexs[0] = ChannelHeaderIndex(row: row, col: index)
                movieCollectionView.mj_header?.beginRefreshing()
            }
        }
    }
    
}
