//
//  BrowserViewController.swift
//  Video Browser
//
//  Created by Ken Liao on 2020/4/24.
//  Copyright © 2020 MC Equipment. All rights reserved.
//

import UIKit
import WebKit

class BrowserViewController: UIViewController {
    
    let tabBar: BrowserTabBar = BrowserTabBar()
    let webView: WKWebView = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        URLProtocol.registerClass(WKSniffer.self)
        initSubviews()
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
        
        webView.snp.makeConstraints { (make) in
            make.width.leading.equalToSuperview()
            make.top.equalTo(44)
            make.bottom.equalTo(tabBar.snp.top)
        }
    }
    
}
