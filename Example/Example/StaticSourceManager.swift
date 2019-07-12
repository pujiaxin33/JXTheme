//
//  StaticSourceManager.swift
//  Example
//
//  Created by jiaxin on 2019/7/12.
//  Copyright © 2019 jiaxin. All rights reserved.
//

import Foundation
import UIKit
import JXTheme

class StaticSourceManager {
    static let shared = StaticSourceManager()
    let configs: [String: [String: String]]

    init() {
        let plistPath = Bundle.main.path(forResource: "StaticSource", ofType: "plist")
        if plistPath == nil {
            configs = [String: [String: String]]()
        }else {
            let sources = NSDictionary(contentsOfFile: plistPath!) as? [String: [String: String]]
            if sources == nil {
                configs = [String: [String: String]]()
            }else {
                configs = sources!
            }
        }
    }

    func textColor(style: ThemeStyle, level: TextColorLevel) -> UIColor {
        if let hex = configs[style.rawValue]?[level.rawValue] {
            return hexStringToUIColor(hex: hex)
        }else {
            //可以根据需求配置默认色
            return UIColor.gray
        }
    }

    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
