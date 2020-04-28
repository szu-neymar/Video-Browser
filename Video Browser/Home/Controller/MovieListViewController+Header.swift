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
            
        if channelModel.channelURL.contains(FYURLField.all.rawValue) {
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
    
    func getURLReplaced() -> String {
        var url = channelModel.channelURL
        if let model = headerModel {
            for index in model.seletedHeaderIndexs {
                url = url.replacingOccurrences(of: model.fyReplaceKeys[index.row], with: model.headerReplaceValues[index.row][index.col])
            }
        }
        
        return url
    }
    
    var firstPageReplaced: String {
        var url = channelModel.firstPageUrl
        if let model = headerModel {
            for index in model.seletedHeaderIndexs {
                url = url.replacingOccurrences(of: model.fyReplaceKeys[index.row], with: model.headerReplaceValues[index.row][index.col])
            }
        }
        return url
    }
}


extension MovieListViewController: MovieListHeaderDelegate {
    func movieListHeader(_: MovieListHeader, selctedAt row: Int, index: Int) {
        
    }
    
}
