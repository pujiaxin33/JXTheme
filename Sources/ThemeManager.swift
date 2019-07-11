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
    public private(set) var currentThemeStyle: ThemeStyle = .light {
        didSet {
            if shouldStoreConfigs {
                UserDefaults.standard.setValue(currentThemeStyle.rawValue, forKey: currentThemeStyleUserDefaultsKey)
            }
        }
    }
    /// 是否存储`currentThemeStyle`、`isFollowSystem`的配置值
    public var shouldStoreConfigs: Bool = true {
        didSet {
            UserDefaults.standard.setValue(NSNumber(value: shouldStoreConfigs), forKey: shouldStoreConfigsUserDefaultsKey)
        }
    }
    /// 属性存储的标志key。可以设置为用户的ID，这样在同一个手机，可以分别记录不同用户的配置。需要优化设置该属性再设置其他值。
    public var storeConfigsIdentifierKey: String = "jiaxin.theme.default" {
        didSet {
            refreshStoreConfigs()
        }
    }
    public var isFollowSystem: Bool = false {
        didSet {
            if shouldStoreConfigs {
                UserDefaults.standard.setValue(NSNumber(value: isFollowSystem), forKey: isFollowSystemUserDefaultsKey)
            }
        }
    }
    internal lazy var trackedHashTable: NSHashTable<AnyObject> = {
        return NSHashTable<AnyObject>.init(options: .weakMemory)
    }()
    private var shouldStoreConfigsUserDefaultsKey: String {
        return storeConfigsIdentifierKey + "com.jiaxin.theme.shouldStoreConfigsUserDefaultsKey"
    }
    private var isFollowSystemUserDefaultsKey: String {
        return storeConfigsIdentifierKey + "com.jiaxin.theme.isFollowSystemUserDefaultsKey"
    }
    private var currentThemeStyleUserDefaultsKey: String {
        return storeConfigsIdentifierKey + "com.jiaxin.theme.currentThemeStyleUserDefaultsKey"
    }

    init() {
        refreshStoreConfigs()
    }

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

    private func refreshStoreConfigs() {
        let shouldStoreConfigsValue = UserDefaults.standard.object(forKey: shouldStoreConfigsUserDefaultsKey) as? NSNumber
        if shouldStoreConfigsValue == nil {
            shouldStoreConfigs = true
            UserDefaults.standard.setValue(NSNumber(value: true), forKey: shouldStoreConfigsUserDefaultsKey)
        }else {
            shouldStoreConfigs =  shouldStoreConfigsValue!.boolValue
        }
        if shouldStoreConfigs {
            let isFollowSystemValue = UserDefaults.standard.object(forKey: isFollowSystemUserDefaultsKey) as? NSNumber
            if isFollowSystemValue == nil {
                isFollowSystem = false
                UserDefaults.standard.setValue(NSNumber(value: false), forKey: isFollowSystemUserDefaultsKey)
            }else {
                isFollowSystem =  isFollowSystemValue!.boolValue
            }
            let currentThemeStyleValue = UserDefaults.standard.string(forKey: currentThemeStyleUserDefaultsKey)
            if currentThemeStyleValue == nil {
                currentThemeStyle = .light
                UserDefaults.standard.setValue(ThemeStyle.light.rawValue, forKey: currentThemeStyleUserDefaultsKey)
            }else {
                currentThemeStyle =  ThemeStyle(rawValue: currentThemeStyleValue!)
            }
        }
    }
}
