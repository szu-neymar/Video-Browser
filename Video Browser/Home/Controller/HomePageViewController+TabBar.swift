//
//  HomePageViewController+TabBar.swift
//  Video Browser
//
//  Created by Ken Liao on 2020/4/22.
//  Copyright © 2020 MC Equipment. All rights reserved.
//

import UIKit

enum HomePageTabBarItemType: Int, CaseIterable {
    case home
    case renctPages
    case records
    case menu
    
    var icon: UIImage {
        switch self {
        case .home:
            return #imageLiteral(resourceName: "tab_home")
        case .renctPages:
            return #imageLiteral(resourceName: "tab_recent_pages")
        case .records:
            return #imageLiteral(resourceName: "tab_records")
        case .menu:
            return #imageLiteral(resourceName: "tab_menu")
        }
    }
}

extension HomePageViewController: HomeTabBarDelegate {
    
    func configTabBar() {
        let images: [UIImage] = HomePageTabBarItemType.allCases.map {
            $0.icon
        }
        
        let tabBar = HomeTabBar(images: images)
        tabBar.delegate = self
        view.addSubview(tabBar)
        tabBar.snp.makeConstraints { (make) in
            make.width.bottom.leading.equalToSuperview()
            make.height.equalTo(49 + 34)
        }
    }
    
    // MARK: - HomeTabBarDelegate
    func homeTabBar(_: HomeTabBar, didSelectedAt index: Int) {
        guard let type = HomePageTabBarItemType(rawValue: index) else { return }
        print(type)
        if type == .renctPages {
            navigationController?.pushViewController(HomePageViewController(), animated: true)
        } else if (type == .menu) {
            if let count = navigationController?.viewControllers.count, count > 1 {
                navigationController?.popViewController(animated: true)
            }
        }
    }
    
}
