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
    var webView: WKWebView!
    var urlString: String?

    convenience init(urlString: String?) {
        self.init(nibName: nil, bundle: nil)
        self.urlString = urlString
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        URLProtocol.registerClass(WKSniffer.self)
        view.backgroundColor = .white
        initSubviews()
        if let url = urlString {
            load(urlString: url)
        }
    }
    
    deinit {
        URLProtocol.unregisterClass(WKSniffer.self)
    }
    
    private func initSubviews() {
        let configuration = WKWebViewConfiguration()
//        if #available(iOS 10.0, *) {
//           configuration.mediaTypesRequiringUserActionForPlayback = []
//        }
//        configuration.allowsInlineMediaPlayback = true
        webView = WKWebView(frame: .zero, configuration: configuration)
        
        view.addSubview(tabBar)
        view.addSubview(webView)
        
        tabBar.delegate = self
        tabBar.snp.makeConstraints { (make) in
            make.width.bottom.leading.equalToSuperview()
            make.height.equalTo(49 + 34)
        }
        
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.snp.makeConstraints { (make) in
            make.width.leading.equalToSuperview()
            make.top.equalTo(44)
            make.bottom.equalTo(tabBar.snp.top)
        }
    }
    
}
