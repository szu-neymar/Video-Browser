//
//  BrowserViewController+TabBar.swift
//  Video Browser
//
//  Created by Ken Liao on 2020/4/24.
//  Copyright © 2020 MC Equipment. All rights reserved.
//

import UIKit

extension BrowserViewController: BrowserTabBarDelegate {
    func browserTabBar(_: BrowserTabBar, tapBack button: UIButton) {
        if webView.canGoBack {
            webView.goBack()
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    func browserTabBar(_: BrowserTabBar, tapRefresh button: UIButton) {
        webView.reload()
    }
    
    func browserTabBar(_: BrowserTabBar, tapSearch button: UIButton) {
        
    }
    
    func browserTabBar(_: BrowserTabBar, tapMenu button: UIButton) {
        let script = """
        if (!sniffVideoUrl) {
            var sniffVideoUrl = function(doc) {
                alert("begin sniff")
                let videoElements = doc.getElementsByTagName("video")
                for (let i = 0; i < videoElements.length; i++) {
                    let videoUrl = videoElements[i].src
                    if (videoUrl.length > 0) {
                        alert("sniff-video:" + videoUrl)
                    }
                }
            }
        }

        if (!sniffVideoInIframes) {
            var sniffVideoInIframes = function() {
                let allIframes = document.getElementsByTagName("iframe")
                let res = []
                for (let i = 0; i < allIframes.length; i++) {
                    let tempFrame = allIframes[i]
                    let tempDoc = tempFrame.contentWindow.document
                    if (tempDoc) {
                        res.push(tempDoc)
                        sniffVideoUrl(tempDoc)
                    }
                }
                alert("frame docs count: " + String(res.length))

            }
        }

        sniffVideoUrl(document)
        sniffVideoInIframes()
        
        """
        webView.evaluateJavaScript(script, completionHandler: nil)
    }
    
    func browserTabBar(_: BrowserTabBar, tapHome button: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
