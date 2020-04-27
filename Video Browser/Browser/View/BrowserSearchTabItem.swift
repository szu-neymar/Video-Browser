//
//  BrowserSearchTabItem.swift
//  Video Browser
//
//  Created by Ken Liao on 2020/4/26.
//  Copyright © 2020 MC Equipment. All rights reserved.
//

import UIKit

protocol BrowserSearchTabItemDelegate: class {
    func searchItemDidTapSearch(_: BrowserSearchTabItem)
    func searchItemDidTapSniffList(_: BrowserSearchTabItem)
}

class BrowserSearchTabItem: UIView {
    
    weak var delegate: BrowserSearchTabItemDelegate?
    
    var title: String? {
        get {
            return searchButton.title(for: .normal)
        }
        set {
            searchButton.setTitle(newValue, for: .normal)
        }
    }
    
    var sniffVideoCount: Int {
        get {
            if let title = sniffButton.title(for: .normal), let count = Int(title) {
                return count
            }
            return 0
        }
        set {
            DispatchQueue.main.async {
                self.sniffButton.isHidden = newValue == 0
                self.sniffButton.setTitle(String(newValue), for: .normal)
            }
        }
    }
    
    private lazy var searchButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.titleLabel?.lineBreakMode = .byTruncatingTail
        button.addTarget(self, action: #selector(tapSearch), for: .touchUpInside)
        button.layer.masksToBounds = true
        return button
    }()
    
    private lazy var sniffButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(tapSniff), for: .touchUpInside)
        button.backgroundColor = .orange
        button.isHidden = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        addSubview(searchButton)
        addSubview(sniffButton)
        
        searchButton.snp.makeConstraints { (make) in
            make.top.centerX.bottom.equalToSuperview()
            make.width.equalToSuperview().offset(-24)
        }
        
        sniffButton.snp.makeConstraints { (make) in
            make.height.width.equalTo(snp.height).offset(-8)
            make.trailing.equalToSuperview().offset(-4)
            make.centerY.equalToSuperview()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        sniffButton.layer.cornerRadius = sniffButton.width / 2.0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func tapSearch() {
        delegate?.searchItemDidTapSearch(self)
    }
    
    @objc private func tapSniff() {
        delegate?.searchItemDidTapSniffList(self)
    }
}
