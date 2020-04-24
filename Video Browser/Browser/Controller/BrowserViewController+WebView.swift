//
//  BrowserViewController+WebView.swift
//  Video Browser
//
//  Created by Ken Liao on 2020/4/24.
//  Copyright © 2020 MC Equipment. All rights reserved.
//

import UIKit
import WebKit

extension BrowserViewController {
    func load(urlString: String) {
        if let url = URL(string: urlString) {
            webView.load(URLRequest(url: url))
        }
    }
}
