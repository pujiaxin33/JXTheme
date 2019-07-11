//
//  ThemeManager.swift
//  JXTheme
//
//  Created by jiaxin on 2019/7/10.
//  Copyright © 2019 jiaxin. All rights reserved.
//

import Foundation

extension Notification.Name {
    public static let JXThemeDidChange = Notification.Name("com.jiaxin.theme.themeDidChangeNotification")
}

public class ThemeManager {
    public static let shared = ThemeManager()
    public private(set) var currentThemeStyle: ThemeStyle = .light
    public var isFollowSystem: Bool = false {
        didSet {
                //TODO：isFollowSystem
        }
    }
    lazy var trackedHashTable: NSHashTable<AnyObject> = {
        return NSHashTable<AnyObject>.init(options: .weakMemory)
    }()
    //TODO:userdefaults存储themestyle
    public func changeTheme(to style: ThemeStyle) {
        currentThemeStyle = style
        NotificationCenter.default.post(name: NSNotification.Name.JXThemeDidChange, object: nil, userInfo: ["style" : style])
        DispatchQueue.main.async {
            self.trackedHashTable.allObjects.forEach { (object) in
                if let view = object as? UIView {
                    view.configs.values.forEach { $0(ThemeManager.shared.currentThemeStyle) }
                }else if let layer = object as? CALayer {
                    layer.configs.values.forEach { $0(ThemeManager.shared.currentThemeStyle) }
                }
            }
        }
    }
}
