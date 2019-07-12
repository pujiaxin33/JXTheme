//
//  DynamicSourceManager.swift
//  Example
//
//  Created by jiaxin on 2019/7/12.
//  Copyright © 2019 jiaxin. All rights reserved.
//

import Foundation
import JXTheme

class DynamicSourceManager {
    static let shared = DynamicSourceManager()
    var configs: [String: [String: String]]?
    var themes: [String]?

    init() {
        let jsonString = "{ \"light_new\": {\"normal\" : \"#555555\", \"mainTitle\" : \"#000000\", \"subTitle\" : \"#333333\" },  \"dark_new\": {\"normal\" : \"#FFFFFF\", \"mainTitle\" : \"#FFFFFF\", \"subTitle\" : \"#FFFFFF\" }}"
        let jsonData = jsonString.data(using: .utf8)
        configs = (try? JSONSerialization.jsonObject(with: jsonData!, options: [])) as? [String: [String: String]]
        if configs != nil {
            themes = Array<String>.init(configs!.keys)
        }
    }

    func textColor(style: ThemeStyle, level: TextColorLevel) -> UIColor {
        if let hex = configs?[style.rawValue]?[level.rawValue] {
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
