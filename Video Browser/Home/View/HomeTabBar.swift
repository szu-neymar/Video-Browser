//
//  HomeTabBar.swift
//  Video Browser
//
//  Created by Ken Liao on 2020/4/22.
//  Copyright © 2020 MC Equipment. All rights reserved.
//

import UIKit

protocol HomeTabBarDelegate: class {
    func homeTabBar(_: HomeTabBar, didSelectedAt index: Int)
}

class HomeTabBar: UIView {

    weak var delegate: HomeTabBarDelegate?
    
    private var items: [UIButton]!

    convenience init(images: [UIImage]) {
        self.init(frame: .zero)
        backgroundColor = .white
        
        addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-34)
        }
        
        items = images.map({ (image) -> UIButton in
            let button = UIButton()
            button.setImage(image, for: .normal)
            return button
        })
        items.forEach {
            $0.addTarget(self, action: #selector(tabButtonAction(_:)), for: .touchUpInside)
            stackView.addArrangedSubview($0)
        }
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func tabButtonAction(_ sender: UIButton) {
        if let index = items.firstIndex(of: sender) {
            delegate?.homeTabBar(self, didSelectedAt: index)
        }
    }
    
    // MARK: - Getter
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.spacing = 8.0
        stackView.distribution = .fillEqually
        return stackView
    }()

}
