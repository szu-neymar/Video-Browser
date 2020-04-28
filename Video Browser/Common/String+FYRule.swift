//
//  String+FYRule.swift
//  Video Browser
//
//  Created by mayc on 2020/4/27.
//  Copyright © 2020 MC Equipment. All rights reserved.
//

import Foundation

extension String {
    
    /**
     去除 url 中的所有路径
     schema://host[:port] 如：https://www.google.com
     */
    var baseUrl: String? {
        if let url = URL(string: self) {
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
            components.path = ""
            return components.url?.absoluteString
        }
        return nil
    }
    
    /**
     如果路径包含关键字 fypage，则可以加载多页
     */
    var canLoadMorePage: Bool {
        return contains(FYURLField.Other.page.rawValue)
    }
    
    /**
     网站首页路径
     */
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
    
    /**
     url 去除 fistPage 字段
     */
    var urlWithoutFirstPageInfo: String {
        if containFirstPage, let range = range(of: "[") {
            let str = self
            return String(str[startIndex..<range.lowerBound])
        }
        return self
    }
    
    func replaceFyAll(with value: String) -> String {
        return replace(field: .all, with: value)
    }
    
    func replace(withType type: String? = nil, area: String? = nil, year: String? = nil) -> String {
        var res = urlWithoutFirstPageInfo
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
            return urlWithoutFirstPageInfo.replacingOccurrences(of: FYURLField.Other.page.rawValue, with: String(ofPage))
        }
        return self
    }
    
    private var containFirstPage: Bool {
        return contains("firstPage=") && contains("[") && contains("]")
    }
}

extension String {
    var dictValue: [String: String]? {
        guard let jsonData = data(using: .utf8) else { return nil }
        
        if let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? [String: String] {
            return dict
        }
        
        return nil
    }
}
