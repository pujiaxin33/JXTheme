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
    public private(set) var currentThemeStyle: ThemeStyle = .unspecified {
        didSet {
            storeCurrentThemeStyle()
        }
    }
    /// 配置存储的标志key。可以设置为用户的ID，这样在同一个手机，可以分别记录不同用户的配置。需要优先设置该属性再设置其他值。
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
                    view.providers.values.forEach { self.resolveProvider($0) }
                }else if let layer = object as? CALayer {
                    layer.providers.values.forEach { self.resolveProvider($0) }
                }else if let barItem = object as? UIBarItem {
                    barItem.providers.values.forEach { self.resolveProvider($0) }
                }
            }
        }
    }

    func addTrackedObject(_ object: AnyObject, addedConfig: ThemeCustomizationClosure) {
        trackedHashTable.add(object)
        addedConfig(currentThemeStyle)
    }

    private func resolveProvider(_ object: Any) {
        if let provider = object as? ThemeProvider<UIColor> {
            provider.config?(currentThemeStyle)
        }else if let provider = object as? ThemeProvider<UIImage> {
            provider.config?(currentThemeStyle)
        }else if let provider = object as? ThemeProvider<NSAttributedString> {
            provider.config?(currentThemeStyle)
        }else if let provider = object as? ThemeProvider<UIKeyboardAppearance> {
            provider.config?(currentThemeStyle)
        }else if let provider = object as? ThemeProvider<CGFloat> {
            provider.config?(currentThemeStyle)
        }else if let provider = object as? ThemeProvider<[NSAttributedString.Key : Any]> {
            provider.config?(currentThemeStyle)
        }else if let provider = object as? ThemeProvider<UIFont> {
            provider.config?(currentThemeStyle)
        }else if let provider = object as? ThemeProvider<UIBarStyle> {
            provider.config?(currentThemeStyle)
        }else if let provider = object as? ThemeProvider<UIActivityIndicatorView.Style> {
            provider.config?(currentThemeStyle)
        }else if let provider = object as? ThemeProvider<Void> {
            provider.config?(currentThemeStyle)
        }
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
            currentThemeStyle = .unspecified
        }else {
            currentThemeStyle =  ThemeStyle(rawValue: currentThemeStyleValue!)
        }
    }
}
