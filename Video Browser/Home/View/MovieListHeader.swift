//
//  MovieListHeader.swift
//  Video Browser
//
//  Created by mayc on 2020/4/27.
//  Copyright © 2020 MC Equipment. All rights reserved.
//

import UIKit


protocol MovieListHeaderDelegate: class {
    func movieListHeader(_: MovieListHeader, selctedAt row: Int, index: Int)
}

class MovieListHeader: UICollectionReusableView, FilterScrollViewDelegate {
    
    weak var delegate: MovieListHeaderDelegate?
    private var allowsMultiSelected = false
    
    private var subScrollViews: [FilterScrollView] = []
    
    func config(with titlesArray: [[String]], allowsMultiSelected: Bool) {
        if subScrollViews.count > 0 {
            return
        }
        self.allowsMultiSelected = allowsMultiSelected
        subScrollViews.forEach { $0.removeFromSuperview() }
        for (index, titles) in titlesArray.enumerated() {
            let filterScrollView = FilterScrollView(titles: titles)
            filterScrollView.tapDelegate = self
            addSubview(filterScrollView)
            subScrollViews.append(filterScrollView)
            
            filterScrollView.snp.makeConstraints { (make) in
                make.leading.trailing.equalToSuperview()
                make.height.equalTo(30)
                make.top.equalTo(30 * index + 5)
            }
        }
        
        if allowsMultiSelected {
            subScrollViews.forEach{ $0.select(at: 0) }
        } else if let firstScrollView = subScrollViews.first {
            firstScrollView.select(at: 0)
        }
    }
    
    // MARK: - FilterScrollViewDelegate
    
    func filterScrollView(_ filterScrollView: FilterScrollView, didSelected index: Int) {
        if !allowsMultiSelected {
            subScrollViews.forEach { $0.deselct() }
        }
        filterScrollView.deselct()
        filterScrollView.select(at: index)
        if let row = subScrollViews.firstIndex(of: filterScrollView) {
            delegate?.movieListHeader(self, selctedAt: row, index: index)
        }
    }
}

// MARK: - FilterScrollView

protocol FilterScrollViewDelegate: class {
    func filterScrollView(_ filterScrollView: FilterScrollView, didSelected index: Int)
}

class FilterScrollView: UIScrollView {
        
    var tapDelegate: FilterScrollViewDelegate?
    
    private var titles: [String] = []
    private var labels: [UILabel] = []
    private var currentSelectedLabel: UILabel?
    
    
    convenience init(titles: [String]) {
        self.init(frame: .zero)
        self.titles = titles
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        initSubviews()
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapAction(_:)))
        addGestureRecognizer(gesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var totalWidth: CGFloat = 0
        for label in labels {
            totalWidth += label.width
        }
        totalWidth += CGFloat(labels.count) * 26.0 + 20
        if (totalWidth < width) {
            totalWidth = width + 0.1
        }
        let size = CGSize(width: totalWidth, height: self.height)
        contentSize = size
    }
    
    private func initSubviews() {
        var lastLabel: UILabel?
        for title in self.titles {
            let label = UILabel()
            label.text = title
            label.font = UIFont.systemFont(ofSize: 14)
            label.textColor = .black
            addSubview(label)
            labels.append(label)
            
            if let last = lastLabel {
                label.snp.makeConstraints { (make) in
                    make.left.equalTo(last.snp.right).offset(26)
                    make.height.centerY.equalToSuperview()
                }
            } else {
                label.snp.makeConstraints { (make) in
                    make.leading.equalTo(20)
                    make.height.centerY.equalToSuperview()
                }
            }
            
            lastLabel = label
        }
        
    }
    
    // MARK: - Public
    func deselct() {
        currentSelectedLabel?.textColor = .black
        currentSelectedLabel = nil
    }
    
    func select(at index: Int) {
        if index >= 0 && index < labels.count {
            let label = labels[index]
            label.textColor = .orange
            currentSelectedLabel = label
        }
    }
    
    // MARK: - Actions
    
    @objc private func tapAction(_ gesture: UITapGestureRecognizer) {
        let point = gesture.location(in: self)
        var tapIndex: Int?
        for (index, label) in labels.enumerated() {
            let subFrame = CGRect(x: label.x - 13, y: label.y, width: label.width + 26, height: label.height)
            if subFrame.contains(point) {
                tapIndex = index
                break
            }
        }
        if let index = tapIndex {
            tapDelegate?.filterScrollView(self, didSelected: index)
        }
    }
}
