//
//  WebBrowser+TabBar.swift
//  Video Browser
//
//  Created by mayc on 2020/4/26.
//  Copyright © 2020 MC Equipment. All rights reserved.
//

import UIKit

extension WebBrowser: BrowserTabBarDelegate {
    func browserTabBar(_: BrowserTabBar, tapBack button: UIButton) {
        if webView.canGoBack {
            webView.goBack()
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    func browserTabBar(_: BrowserTabBar, tapRefresh button: UIButton) {
        webView.reload()
    }
    
    func browserTabBarTapSearch(_: BrowserTabBar) {
        
    }
    
    func browserTabBarTapSniffResult(_: BrowserTabBar) {
        if let url = videoUrls.last {
            let playerController = PlayerViewController(urlString: url)
            navigationController?.pushViewController(playerController, animated: true)
        }
    }
    
    func browserTabBar(_: BrowserTabBar, tapMenu button: UIButton) {
        
    }
    
    func browserTabBar(_: BrowserTabBar, tapHome button: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
