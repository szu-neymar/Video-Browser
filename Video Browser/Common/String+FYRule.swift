//
//  String+FYRule.swift
//  Video Browser
//
//  Created by mayc on 2020/4/27.
//  Copyright © 2020 MC Equipment. All rights reserved.
//

import Foundation

extension String {
    
    var canLoadMorePage: Bool {
        return contains(FYURLField.Other.page.rawValue)
    }
    
    var firstPageUrl: String {
        if containFirstPage, let firstPageRange = range(of: "firstPage=") {
            var str = self
            let start = firstPageRange.upperBound
            str = String(str[start...])
            if let range = str.range(of: "]", options: .backwards) {
                str = String(str[str.startIndex..<range.lowerBound])
                return str
            }
        }
        return url(ofPage: 0)
    }
    
    func replaceFyAll(with value: String) -> String {
        return replace(field: .all, with: value)
    }
    
    func replace(withType type: String? = nil, area: String? = nil, year: String? = nil) -> String {
        var res = realUrl
        if let fyClass = type {
            res = res.replace(field: .type, with: fyClass)
        }
        
        if let fyArea = area {
            res = res.replace(field: .area, with: fyArea)
        }
        
        if let fyYear = year {
            res = res.replace(field: .year, with: fyYear)
        }
        
        return res
    }
    
    private func replace(field: FYURLField, with value: String) -> String {
        return replacingOccurrences(of: field.rawValue, with: value)
    }
    
    func url(ofPage: Int) -> String {
        if canLoadMorePage {
            return realUrl.replacingOccurrences(of: FYURLField.Other.page.rawValue, with: String(ofPage))
        }
        return self
    }
    
    private var realUrl: String {
        if containFirstPage, let range = range(of: "[") {
            let str = self
            return String(str[startIndex..<range.lowerBound])
        }
        return self
    }
    
    private var containFirstPage: Bool {
        return contains("firstPage=") && contains("[") && contains("]")
    }
}
