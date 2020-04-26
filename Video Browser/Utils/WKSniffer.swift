//
//  WKSniffer.swift
//  Video Browser
//
//  Created by mayc on 2020/4/23.
//  Copyright © 2020 MC Equipment. All rights reserved.
//

import UIKit

enum VideoExt: String, CaseIterable {
    case mp4
    case avi
    case flv
    case threeGP = "3gp"
    case mpg
    case mpeg
    case wmv
    case mov
    case rm
    case rmvb
    case dat
    
    case m3u8
    
    var extWithDot: String {
        return "." + rawValue
    }
    
    static var allExts: [String] {
        return allCases.map{ $0.rawValue }
    }
    
    static var allExtsWithDot: [String] {
        return allCases.map{ "." + $0.rawValue }
    }
}

enum IgnoreExt: String, CaseIterable {
    case js
    case html
    case css
    case ttf
    case ico
    case png
    case jpg
    case jpeg
    case cnzz
    
    var extWithDot: String {
        return "." + rawValue
    }
    
    static var allExts: [String] {
        return allCases.map{ $0.rawValue }
    }
    
    static var allExtsWithDot: [String] {
        return allCases.map{ "." + $0.rawValue }
    }
}

extension Notification.Name {
    static let SniffUrlNotification = Notification.Name("WKSniffer.SniffUrlNotification")
    static let SniffVideoUrlNotification = Notification.Name("WKSniffer.SniffVideoUrlNotification")
    static let SniffUrlKey = "url"
}

/**
 视频资源嗅探
 */
class WKSniffer: URLProtocol {
    
    override class func canInit(with request: URLRequest) -> Bool {
        guard let urlString = request.url?.absoluteString else {
            return false
        }
        
        let videoExts = VideoExt.allExtsWithDot
        let ignoreExts = IgnoreExt.allExtsWithDot
        
        for ext in ignoreExts {
            if urlString.hasSuffix(ext) {
                return false
            }
        }
        
        for ext in videoExts {
            if urlString.contains(ext) {
                NotificationCenter.default.post(name: .SniffVideoUrlNotification, object: nil, userInfo: [Notification.Name.SniffUrlKey: urlString])
                print("sniff: " + urlString)
                return false
            }
        }
        
        NotificationCenter.default.post(name: .SniffUrlNotification, object: nil, userInfo: [Notification.Name.SniffUrlKey: urlString])
        
        return false
    }
}
