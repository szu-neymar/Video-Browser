//
//  String+Index.swift
//  Video Browser
//
//  Created by mayc on 2020/4/27.
//  Copyright © 2020 MC Equipment. All rights reserved.
//

import Foundation

extension String {
    var includeChinese: Bool {
        for value in self {
            if ("\u{4E00}" <= value  && value <= "\u{9FA5}") {
                return true
            }
        }
        return false
    }
    
    func urlEncoded() -> String {
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        return encodeUrlString ?? ""
    }
}
