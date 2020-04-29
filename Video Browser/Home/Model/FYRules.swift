//
//  FYRules.swift
//  Video Browser
//
//  Created by mayc on 2020/4/24.
//  Copyright © 2020 MC Equipment. All rights reserved.
//

import Foundation

enum FYRuleType: String {
    case home = "￥home_rule￥"
    case homeURL = "￥home_rule_url￥"
    case source = "￥source￥"
}

// MARK: - FYHomeRule 首页规则

enum FYURLField: String {
    case type = "fyclass"
    case year = "fyyear"
    case area = "fyarea"
    
    case all = "fyAll"
    
    enum Other: String {
        case page = "fypage"
        case firstPage
    }
}

enum FYListStyle: String {
    case movie_1
    case movie_2
    case movie_3
    
    case text_1
    case text_2
    case text_3
    case text_4
    
    case pic_1
    case pic_2
    case pic_3
}

struct FYSourceModel: Codable {
    var title: String
    var group: String = "首页"
    var titleColorHex: String?
    
    var url: String
    var listStyle: String?
    var className: String?
    var classURL: String?
    var areaName: String?
    var areaURL: String?
    var yearName: String?
    var yearURL: String?
    
    var parseRule: String
    var searchURL: String?
    var searchParseRule: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case group
        case titleColorHex = "titleColor"
        case url
        case listStyle = "col_type"
        case className = "class_name"
        case classURL = "class_url"
        case areaName = "area_name"
        case areaURL = "area_url"
        case yearName = "year_name"
        case yearURL = "year_url"
        case parseRule = "find_rule"
        case searchURL = "search_url"
        case searchParseRule = "searchFind"
    }
}

struct FYChannelModel {
    var title: String
    var group: String
    var titleColorHex: String?
    var channelURL: String  // 待替换关键词的 url
    var firstPageUrl: String
    var listStyle: FYListStyle = .movie_3
    
    var videoClasses: [String]?
    var videoClasseReplaces: [String]?
    var videoAreas: [String]?
    var videoAreaReplaces: [String]?
    var videoYears: [String]?
    var videoYearReplaces: [String]?
    
    var htmlParseRule: String
    var searchUrl: String?
    var searchHtmlParseRule: String?
    
    init(with source: FYSourceModel) {
        title = source.title
        group = source.group
        titleColorHex = source.titleColorHex
        htmlParseRule = source.parseRule
        searchUrl = source.searchURL
        searchHtmlParseRule = source.searchParseRule
        
        if let index = source.url.range(of: ";")?.lowerBound {
            channelURL = String(source.url[source.url.startIndex..<index])
        } else {
            channelURL = source.url
        }
        
        firstPageUrl = channelURL.firstPageUrl
        channelURL = channelURL.urlWithoutFirstPageInfo
        
        var types: [String] = []
        var typeReplaces: [String] = []
        var areas: [String] = []
        var areaReplaces: [String] = []
        var years: [String] = []
        var yearReplaces: [String] = []
        
        if let typeString = source.className, let typeReplaceString = source.classURL, typeString.count > 0, typeReplaceString.count > 0 {
            types = typeString.components(separatedBy: "&")
            var replaces = typeReplaceString.components(separatedBy: "&")
            for (index, replace) in replaces.enumerated() {
                if replace.includeChinese {
                    replaces[index] = replace.urlEncoded()
                }
            }
            typeReplaces = replaces
        }
        if let areaString = source.areaName, let areaReplaceString  = source.areaURL, areaString.count > 0, areaReplaceString.count > 0 {
            areas = areaString.components(separatedBy: "&")
            var replaces = areaReplaceString.components(separatedBy: "&")
            for (index, replace) in replaces.enumerated() {
                if replace.includeChinese {
                    replaces[index] = replace.urlEncoded()
                }
            }
            areaReplaces = replaces
        }
        if let yearString = source.yearName, let yearReplaceString = source.yearURL, yearString.count > 0, yearReplaceString.count > 0 {
            years = yearString.components(separatedBy: "&")
            var replaces = yearReplaceString.components(separatedBy: "&")
            for (index, replace) in replaces.enumerated() {
                if replace.includeChinese {
                    replaces[index] = replace.urlEncoded()
                }
            }
            yearReplaces = replaces
        }
        
        if types.count > 0 && types.count == typeReplaces.count {
            videoClasses = types
            videoClasseReplaces = typeReplaces
        }
        if areas.count > 0 && areas.count == areaReplaces.count {
            videoAreas = areas
            videoAreaReplaces = areaReplaces
        }
        if years.count > 0 && years.count == yearReplaces.count {
            videoYears = years
            videoYearReplaces = yearReplaces
        }
    }
}

extension FYChannelModel {
    var allowsMultiSelected: Bool {
        return !channelURL.contains(FYURLField.all.rawValue)
    }
}

struct MovieInfoSelector {
    var listSelectors: [String]?
    var titleSelectors: [String]?
    var imageSelectors: [String]?
    var descSelectors: [String]?
    var hrefSelectors: [String]?
    
    init(string: String) {
        let rules = string.components(separatedBy: ";")
        for (index, rule) in rules.enumerated() {
            let selectors = rule.components(separatedBy: "&&")
            switch index {
            case 0:
                listSelectors = selectors
            case 1:
                titleSelectors = selectors
            case 2:
                imageSelectors = selectors
            case 3:
                descSelectors = selectors
            case 4:
                hrefSelectors = selectors
            default:
                break
            }
        }
    }
}

