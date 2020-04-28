//
//  Parser.swift
//  Video Browser
//
//  Created by mayc on 2020/4/24.
//  Copyright © 2020 MC Equipment. All rights reserved.
//

import Foundation
import SwiftSoup

enum ParseError: Error {
    case parseFailed
    case noData
    
    var desc: String {
        switch self {
        case .parseFailed:
            return "解析失败"
        case .noData:
            return "无数据"
        }
    }
}

typealias ParseMovieComplete =  (Result<[MovieInfo], ParseError>) -> Void

struct Parser {
    
    /**
     解析远程 HTML 获取电影列表信息
     */
    static func getMovies(from urlString: String,
                                    rule: String,
                                complete: @escaping ParseMovieComplete) {
        var movies: [MovieInfo] = []
        movies = []
        guard let url = URL(string: urlString), let baseUrl = urlString.baseUrl else {
            print("\(urlString) is not a url")
            return complete(.failure(.parseFailed))
        }
        
        let selector = MovieInfoSelector(string: rule)
        
        DispatchQueue.global().async {
            do {
                let html = try String(contentsOf: url, encoding: .utf8)
                let doc = try SwiftSoup.parse(html)
                
                // list
                guard let listSelectors = selector.listSelectors else { return complete(.failure(.noData)) }
                var movieElements: Elements?
                for (index, selector) in listSelectors.enumerated() {
                    if (index == 0) {
                        movieElements = try doc.select(selector)
                    } else {
                        movieElements = try movieElements!.select(selector)
                    }
                }
                guard let items = movieElements else { return complete(.failure(.noData)) }
                
                // Movie info
                for item in items {
                    var movie = MovieInfo()
                    // title
                    if let titleSelectors = selector.titleSelectors {
                        movie.title = getContent(from: item, selectors: titleSelectors)
                    }
                    // imageUrl
                    if let imageSelectors = selector.imageSelectors {
                        let content = getContent(from: item, selectors: imageSelectors)
                        let imageURL = getImageUrl(from: content)
                        movie.imageURL = getRealUrl(from: imageURL, baseUrl: baseUrl)
                    }
                    // desc
                    if let descSelectors = selector.descSelectors {
                        movie.description = getContent(from: item, selectors: descSelectors)
                    }
                    // href
                    if let hrefSelectors = selector.hrefSelectors {
                        let href = getContent(from: item, selectors: hrefSelectors)
                        movie.href = getRealUrl(from: href, baseUrl: baseUrl)
                    }
                    movies.append(movie)
                }
                DispatchQueue.main.async {
                    return complete(.success(movies))
                }
            } catch {
                let error = ParseError.parseFailed
                return complete(.failure(error))
            }
        }
    }
    
    static func getDictString(from paste: String, ruleType: FYRuleType) -> String? {
        if let index = paste.range(of: ruleType.rawValue)?.upperBound {
            return String(paste[index..<paste.endIndex])
        }
        
        return nil
    }
    
    // MARK: - Private
    private static func getContent(from item: Element, selectors: [String]) -> String? {
        var content: String?
        do {
            var elements = try item.getAllElements()
            for (index, selector) in selectors.enumerated() {
                if index == selectors.count - 1 {
                    if selector.hasPrefix("Text") {
                        content = try elements.text()
                        if selector.contains("!") {
                            let index = selector.index(selector.firstIndex(of: "!")!, offsetBy: 1)
                            let removeStr = selector[index...]
                            content = content?.replacingOccurrences(of: removeStr, with: "")
                        }
                    } else if selector.hasPrefix("Html") {
                        content = try elements.html()
                    } else {
                        content = try elements.attr(selector)
                    }
                }
                
                else {
                    if selector.contains(",") {
                        let subSelectors = selector.components(separatedBy: ",")
                        if subSelectors.count == 2, let index = Int(subSelectors[1]) {
                            if index < elements.count {
                                elements = try elements.select(subSelectors[0])
                                elements = Elements([elements[index]])
                            }
                        }
                    } else {
                        elements = try elements.select(selector)
                    }
                }
            }
            
            
        } catch {
            print("cannot get content")
        }
        return content
    }
    
    private static func getImageUrl(from content: String?) -> String? {
        if let originContent = content, originContent.contains("background-image: url") {
            if let start = originContent.firstIndex(of: "("), let end = originContent.lastIndex(of: ")") {
                return String(originContent[originContent.index(start, offsetBy: 1)..<end])
            }
        }
        
        return content
    }
    
    private static func getRealUrl(from urlString: String?, baseUrl: String) -> String? {
        guard let urlStr = urlString, let url = URL(string: urlStr) else { return nil }
        if url.scheme == nil && url.host == nil {
            return baseUrl + urlStr
        }
        return urlStr
    }
    
}
