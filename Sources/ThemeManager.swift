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
    /// 当isFollowSystem为true时，currentThemeStyle为无效值。而应该依赖于具体UIViewController、UIView的traitCollection.userInterfaceStyle值。
    public private(set) var currentThemeStyle: ThemeStyle = .light {
        didSet {
            storeCurrentThemeStyle()
        }
    }
    /// 属性存储的标志key。可以设置为用户的ID，这样在同一个手机，可以分别记录不同用户的配置。需要优先设置该属性再设置其他值。
    public var storeConfigsIdentifierKey: String = "default" {
        didSet {
            refreshStoreConfigs()
        }
    }
    internal lazy var trackedHashTable: NSHashTable<AnyObject> = {
        return NSHashTable<AnyObject>.init(options: .weakMemory)
    }()

    init() {
        refreshStoreConfigs()
    }

    public func changeTheme(to style: ThemeStyle) {
        currentThemeStyle = style
        NotificationCenter.default.post(name: Notification.Name.JXThemeDidChange, object: nil, userInfo: ["style" : style])
        DispatchQueue.main.async {
            self.trackedHashTable.allObjects.forEach { (object) in
                if let view = object as? UIView {
                    view.configs.values.forEach { $0(self.currentThemeStyle) }
                }else if let layer = object as? CALayer {
                    layer.configs.values.forEach { $0(self.currentThemeStyle) }
                }
            }
        }
    }

    func addTrackedObject(_ object: AnyObject, addedConfig: ThemeCustomizationClosure) {
        trackedHashTable.add(object)
        addedConfig(currentThemeStyle)
    }
}

//MARK: - Store
extension ThemeManager {
    private var currentThemeStyleUserDefaultsKey: String {
        return "com.jiaxin.theme.currentThemeStyleUserDefaultsKey:" + storeConfigsIdentifierKey
    }

    fileprivate func storeCurrentThemeStyle() {
        UserDefaults.standard.setValue(currentThemeStyle.rawValue, forKey: currentThemeStyleUserDefaultsKey)
    }

    fileprivate func refreshStoreConfigs() {
        let currentThemeStyleValue = UserDefaults.standard.string(forKey: currentThemeStyleUserDefaultsKey)
        if currentThemeStyleValue == nil {
            currentThemeStyle = .light
            UserDefaults.standard.setValue(ThemeStyle.light.rawValue, forKey: currentThemeStyleUserDefaultsKey)
        }else {
            currentThemeStyle =  ThemeStyle(rawValue: currentThemeStyleValue!)
        }
    }
}
