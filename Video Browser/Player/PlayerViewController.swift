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
    private var movieTitle: String?
    
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
    
    convenience init(urlString: String, movieTitle: String?) {
        self.init(nibName: nil, bundle: nil)
        self.urlString = urlString
        self.movieTitle = movieTitle
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
        controlView.prepareShowLoading = true
        controlView.prepareShowControlView = true
        controlView.autoFadeTimeInterval = 0.32
        controlView.effectViewShow = false
        controlView.fastViewAnimated = true
        controlView.landScapeControlView.playOrPauseBtn.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        controlView.landScapeControlView.playOrPauseBtn.setImage(#imageLiteral(resourceName: "pause"), for: .selected)
        controlView.landScapeControlView.lockBtn.setImage(#imageLiteral(resourceName: "unlock"), for: .normal)
        controlView.landScapeControlView.lockBtn.setImage(#imageLiteral(resourceName: "lock"), for: .selected)
        controlView.landScapeControlView.titleLabel.text = movieTitle
        controlView.portraitControlView.titleLabel.text = movieTitle
        player.controlView = controlView
        player.isStatusBarHidden = false
        
        containerView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(44)
            make.height.equalTo(self.view.snp.width).multipliedBy(9 / 16.0)
        }
        
        player.orientationWillChange = { [weak self] (player: ZFPlayerController, isFullScreen: Bool) in
            if let appDelagate = UIApplication.shared.delegate as? AppDelegate {
                appDelagate.allowOrentitaionRotation = isFullScreen
                self?.homeIndicatorHidden = isFullScreen
                self?.controlView.bottomPgrogress.alpha = isFullScreen ? 0 : 1
                self?.setNeedsUpdateOfHomeIndicatorAutoHidden()
                self?.setNeedsStatusBarAppearanceUpdate()
                if !isFullScreen {
                    self?.navigationController?.navigationBar.height = 88
                }
            }
        }
    }
}

