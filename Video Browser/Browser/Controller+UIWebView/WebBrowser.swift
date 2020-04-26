//
//  WebBrowser.swift
//  Video Browser
//
//  Created by mayc on 2020/4/26.
//  Copyright © 2020 MC Equipment. All rights reserved.
//

import UIKit

class WebBrowser: UIViewController {
    
    let webView = UIWebView()
    let tabBar: BrowserTabBar = BrowserTabBar()
    var urlString: String?
    
    var videoUrls: [String] = []

    convenience init(urlString: String?) {
        self.init(nibName: nil, bundle: nil)
        self.urlString = urlString
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        initSubviews()
        if let url = urlString {
            load(urlString: url)
        }
        
        URLProtocol.registerClass(WKSniffer.self)
    }
    
    deinit {
        URLProtocol.unregisterClass(WKSniffer.self)
    }
    
    private func initSubviews() {
            
        view.addSubview(tabBar)
        view.addSubview(webView)
        
        tabBar.delegate = self
        tabBar.snp.makeConstraints { (make) in
            make.width.bottom.leading.equalToSuperview()
            make.height.equalTo(49 + 34)
        }
            
        webView.delegate = self
        webView.mediaPlaybackRequiresUserAction = false
        webView.snp.makeConstraints { (make) in
                make.width.leading.equalToSuperview()
                make.top.equalTo(44)
                make.bottom.equalTo(tabBar.snp.top)
        }
    }
    
}

