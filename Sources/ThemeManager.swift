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
            storeCurrentThemeStyleIfNeeded()
        }
    }
    /// 是否存储`currentThemeStyle`、`_isFollowSystem`的配置值
    public var shouldStoreConfigs: Bool = true {
        didSet {
            storeShouldStoreConfigs()
        }
    }
    /// 属性存储的标志key。可以设置为用户的ID，这样在同一个手机，可以分别记录不同用户的配置。需要优先设置该属性再设置其他值。
    public var storeConfigsIdentifierKey: String = "jiaxin.theme.default" {
        didSet {
            refreshStoreConfigs()
        }
    }
    @available(iOS 12.0, *)
    public var isFollowSystem: Bool {
        set(new) {
            _isFollowSystem = new
        }
        get {
            return _isFollowSystem
        }
    }
    internal lazy var trackedHashTable: NSHashTable<AnyObject> = {
        return NSHashTable<AnyObject>.init(options: .weakMemory)
    }()
    fileprivate var _isFollowSystem: Bool = false {
        didSet {
            storeIsFollowSystemIfNeeded()
        }
    }

    init() {
        refreshStoreConfigs()
    }

    public func changeTheme(to style: ThemeStyle) {
        currentThemeStyle = style
        NotificationCenter.default.post(name: Notification.Name.JXThemeDidChange, object: nil, userInfo: ["style" : style])
        DispatchQueue.main.async {
            self.trackedHashTable.allObjects.forEach { (object) in
                if let view = object as? UIView {
                    view.configs.values.forEach { $0(self.realCurrentThemeStyle(view)) }
                }else if let layer = object as? CALayer {
                    layer.configs.values.forEach { $0(self.realCurrentThemeStyle(layer)) }
                }
            }
        }
    }

    @available(iOS 12.0, *)
    public func refreshSystemTheme() {
        DispatchQueue.main.async {
            self.trackedHashTable.allObjects.forEach { (object) in
                if let view = object as? UIView {
                    view.configs.values.forEach { $0(self.realCurrentThemeStyle(view)) }
                }else if let layer = object as? CALayer {
                    layer.configs.values.forEach { $0(self.realCurrentThemeStyle(layer)) }
                }
            }
        }
    }

    func addTrackedObject(_ object: AnyObject, addedConfig: ThemeCustomizationClosure) {
        trackedHashTable.add(object)
        addedConfig(realCurrentThemeStyle(object))
    }

    func realCurrentThemeStyle(_ targetObject: AnyObject?) -> ThemeStyle {
        if #available(iOS 12.0, *) {
            if _isFollowSystem {
                if let view = targetObject as? UIView {
                    return transformUserInterfaceStyleToThemeStyle(view.traitCollection.userInterfaceStyle)
                }else {
                    return transformUserInterfaceStyleToThemeStyle(UIApplication.shared.keyWindow?.traitCollection.userInterfaceStyle ?? .unspecified)
                }
            }else {
                return currentThemeStyle
            }
        }else {
            return currentThemeStyle
        }
    }

    @available(iOS 12.0, *)
    func transformUserInterfaceStyleToThemeStyle(_ userInterfaceStyle: UIUserInterfaceStyle) -> ThemeStyle {
        switch userInterfaceStyle {
        case .dark:
            return .dark
        case .light:
            return .light
        default:
            return .unspecified
        }
    }
}

//MARK: - Store
extension ThemeManager {
    private var shouldStoreConfigsUserDefaultsKey: String {
        return storeConfigsIdentifierKey + "com.jiaxin.theme.shouldStoreConfigsUserDefaultsKey"
    }
    private var isFollowSystemUserDefaultsKey: String {
        return storeConfigsIdentifierKey + "com.jiaxin.theme.isFollowSystemUserDefaultsKey"
    }
    private var currentThemeStyleUserDefaultsKey: String {
        return storeConfigsIdentifierKey + "com.jiaxin.theme.currentThemeStyleUserDefaultsKey"
    }

    fileprivate func storeShouldStoreConfigs() {
        UserDefaults.standard.setValue(NSNumber(value: shouldStoreConfigs), forKey: shouldStoreConfigsUserDefaultsKey)
    }

    fileprivate func storeIsFollowSystemIfNeeded() {
        if shouldStoreConfigs {
            UserDefaults.standard.setValue(NSNumber(value: _isFollowSystem), forKey: isFollowSystemUserDefaultsKey)
        }
    }

    fileprivate func storeCurrentThemeStyleIfNeeded() {
        if shouldStoreConfigs {
            UserDefaults.standard.setValue(currentThemeStyle.rawValue, forKey: currentThemeStyleUserDefaultsKey)
        }
    }

    fileprivate func refreshStoreConfigs() {
        let shouldStoreConfigsValue = UserDefaults.standard.object(forKey: shouldStoreConfigsUserDefaultsKey) as? NSNumber
        if shouldStoreConfigsValue == nil {
            shouldStoreConfigs = true
            UserDefaults.standard.setValue(NSNumber(value: true), forKey: shouldStoreConfigsUserDefaultsKey)
        }else {
            shouldStoreConfigs =  shouldStoreConfigsValue!.boolValue
        }
        let isFollowSystemValue = UserDefaults.standard.object(forKey: isFollowSystemUserDefaultsKey) as? NSNumber
        if isFollowSystemValue == nil {
            _isFollowSystem = false
            UserDefaults.standard.setValue(NSNumber(value: false), forKey: isFollowSystemUserDefaultsKey)
        }else {
            _isFollowSystem =  isFollowSystemValue!.boolValue
        }
        if _isFollowSystem {
            currentThemeStyle = realCurrentThemeStyle(nil)
        }else {
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
