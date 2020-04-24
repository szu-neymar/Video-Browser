//
//  WKSniffer.swift
//  Video Browser
//
//  Created by mayc on 2020/4/23.
//  Copyright © 2020 MC Equipment. All rights reserved.
//

import UIKit

/**
 WKWebView 网络嗅探器
 */
class WKSniffer: URLProtocol {
    override class func canInit(with request: URLRequest) -> Bool {
        if let urlString = request.url?.absoluteString {
            if urlString.contains(".m3u8") || urlString.contains(".mp4") {
                print("嗅探到视频：\(urlString)")
            }
            
        }
        return false
    }
}
