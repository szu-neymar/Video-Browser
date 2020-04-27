//
//  PlayerViewController.swift
//  Video Browser
//
//  Created by mayc on 2020/4/26.
//  Copyright © 2020 MC Equipment. All rights reserved.
//

import UIKit
import ZFPlayer

class PlayerViewController: UIViewController {
    
    private var urlString: String = ""
    
    private var player: ZFPlayerController!
    private let playerManager = ZFAVPlayerManager()
    
    private let containerView = UIView()
    private let controlView = ZFPlayerControlView()
    
    private var homeIndicatorHidden = false
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        return homeIndicatorHidden
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    convenience init(urlString: String) {
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
        
        view.backgroundColor = .white
        configPlayer()
         
        if let url = URL(string: urlString) {
            playerManager.assetURL = url
        }
    }

    private func configPlayer() {
        view.addSubview(containerView)
        
        containerView.backgroundColor = .black
        player = ZFPlayerController(playerManager: playerManager, containerView: containerView)
        player.controlView = controlView
        player.isStatusBarHidden = false
        
        containerView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(88)
            make.height.equalTo(self.view.snp.width).multipliedBy(9 / 16.0)
        }
        
        player.orientationWillChange = { [weak self] (player: ZFPlayerController, isFullScreen: Bool) in
            if let appDelagate = UIApplication.shared.delegate as? AppDelegate {
                appDelagate.allowOrentitaionRotation = isFullScreen
                self?.homeIndicatorHidden = isFullScreen
                self?.setNeedsUpdateOfHomeIndicatorAutoHidden()
                self?.setNeedsStatusBarAppearanceUpdate()
                if !isFullScreen {
                    self?.navigationController?.navigationBar.height = 88
                }
            }
        }
    }
}

