//
//  UIView+Ex.swift
//  Video Browser
//
//  Created by Ken Liao on 2020/4/24.
//  Copyright © 2020 MC Equipment. All rights reserved.
//

import UIKit

extension UIView {
    var x: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            var newFrame = frame
            newFrame.origin.x = newValue
            frame = newFrame
        }
    }
    
    var y: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            var newFrame = frame
            newFrame.origin.y = newValue
            frame = newFrame
        }
    }
    
    var width: CGFloat {
        get {
            return frame.size.width
        }
        set {
            var newFrame = frame
            newFrame.size.width = newValue
            frame = newFrame
        }
    }
    
    var height: CGFloat {
        get {
            return frame.size.height
        }
        set {
            var newFrame = frame
            newFrame.size.height = newValue
            frame = newFrame
        }
    }
}
