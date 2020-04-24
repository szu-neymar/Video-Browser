//
//  BrowserTabBar.swift
//  Video Browser
//
//  Created by Ken Liao on 2020/4/24.
//  Copyright © 2020 MC Equipment. All rights reserved.
//

import UIKit

protocol BrowserTabBarDelegate: class {
    func browserTabBar(_: BrowserTabBar, tapBack button: UIButton)
    func browserTabBar(_: BrowserTabBar, tapRefresh button: UIButton)
    func browserTabBar(_: BrowserTabBar, tapSearch button: UIButton)
    func browserTabBar(_: BrowserTabBar, tapMenu button: UIButton)
    func browserTabBar(_: BrowserTabBar, tapHome button:UIButton)
}

extension BrowserTabBarDelegate {
    func browserTabBar(_: BrowserTabBar, tapBack button: UIButton) {}
    func browserTabBar(_: BrowserTabBar, tapRefresh button: UIButton) {}
    func browserTabBar(_: BrowserTabBar, tapSearch button: UIButton) {}
    func browserTabBar(_: BrowserTabBar, tapMenu button: UIButton) {}
    func browserTabBar(_: BrowserTabBar, tapHome button:UIButton) {}
}

class BrowserTabBar: UIView {
    
    weak var delegate: BrowserTabBarDelegate?
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "tab_back"), for: .normal)
        button.addTarget(self, action: #selector(backAction(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var refreshButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "tab_refresh"), for: .normal)
        button.addTarget(self, action: #selector(refreshAction(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightGray
        button.setTitle("微信", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.titleLabel?.lineBreakMode = .byTruncatingTail
        button.addTarget(self, action: #selector(searchAction(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var menuButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "tab_menu"), for: .normal)
        button.addTarget(self, action: #selector(menuAction(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var homeButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "tab_home"), for: .normal)
        button.addTarget(self, action: #selector(homeAction(_:)), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    private func initSubviews() {
        addSubview(backButton)
        addSubview(refreshButton)
        addSubview(searchButton)
        addSubview(menuButton)
        addSubview(homeButton)
        
        let baseWidth = UIScreen.main.bounds.width / 6.0
        backButton.snp.makeConstraints { (make) in
            make.height.equalTo(49)
            make.leading.top.equalToSuperview()
            make.width.equalTo(baseWidth)
        }
        
        refreshButton.snp.makeConstraints { (make) in
            make.height.equalTo(49)
            make.top.equalToSuperview()
            make.width.equalTo(baseWidth)
            make.left.equalTo(backButton.snp.right)
        }
        
        searchButton.snp.makeConstraints { (make) in
            make.height.equalTo(32)
            make.centerY.equalTo(refreshButton)
            make.width.equalTo(baseWidth * 2)
            make.left.equalTo(refreshButton.snp.right)
        }
        searchButton.layer.cornerRadius = 16
        
        menuButton.snp.makeConstraints { (make) in
            make.height.equalTo(49)
            make.top.equalToSuperview()
            make.width.equalTo(baseWidth)
            make.left.equalTo(searchButton.snp.right)
        }
        
        homeButton.snp.makeConstraints { (make) in
            make.height.equalTo(49)
            make.top.equalToSuperview()
            make.width.equalTo(baseWidth)
            make.left.equalTo(menuButton.snp.right)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    @objc private func backAction(_ sender: UIButton) {
        delegate?.browserTabBar(self, tapBack: sender)
    }
    
    @objc private func refreshAction(_ sender: UIButton) {
        delegate?.browserTabBar(self, tapRefresh: sender)
    }
    
    @objc private func searchAction(_ sender: UIButton) {
        delegate?.browserTabBar(self, tapSearch: sender)
    }
    
    @objc private func menuAction(_ sender: UIButton) {
        delegate?.browserTabBar(self, tapMenu: sender)
    }
    
    @objc private func homeAction(_ sender: UIButton) {
        delegate?.browserTabBar(self, tapHome: sender)
    }

}
