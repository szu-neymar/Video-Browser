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
}

// MARK: - FYHomeRule 首页规则

enum FYURLField: String {
    case type = "fyclass"
    case year = "fyyear"
    case area = "fyarea"
    case page = "fypage"
    case all = "fyAll"
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

struct FYHomeRule {
    var title: String?
    var group: String?
    var titleColorHex: String?
    var channelURL: String?
    var listStyle: FYListStyle
    
    var videoClasses: String?
    var videoClassesReplace: String?
    var videoAreas: String?
    var videoAreasReplace: String?
    var videoYears: String?
    var videoYearsReplace: String?
    
    var htmlParseRule: String?
    var searchUrl: String?
    var searchHtmlParseRule: String?
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

