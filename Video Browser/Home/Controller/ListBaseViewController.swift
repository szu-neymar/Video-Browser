//
//  ListBaseViewController.swift
//  Video Browser
//
//  Created by mayc on 2020/4/23.
//  Copyright © 2020 MC Equipment. All rights reserved.
//

import UIKit

import UIKit
import JXSegmentedView

class ListBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: CGFloat(arc4random()%255)/255, green: CGFloat(arc4random()%255)/255, blue: CGFloat(arc4random()%255)/255, alpha: 1)
    }
}

extension ListBaseViewController: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
}
