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
                //让object根据最新的style刷新
                //告知内部和外部最新的style
                if let view = object as? UIView, view.dynamicBackgroundColor != nil {
                    view.backgroundColor = view.dynamicBackgroundColor?(self.currentThemeStyle)
                }
                if let label = object as? UILabel {
                    if label.dynamicTextColor != nil {
                        label.textColor = label.dynamicTextColor?(self.currentThemeStyle)
                    }
                    if label.dynamicAttributedText != nil {
                        label.attributedText = label.dynamicAttributedText?(self.currentThemeStyle)
                    }
                }
                if let textField = object as? UITextField, textField.dynamicTextColor != nil {
                    textField.textColor = textField.dynamicTextColor?(self.currentThemeStyle)
                }
                if let textView = object as? UITextView, textView.dynamicTextColor != nil {
                    textView.textColor = textView.dynamicTextColor?(self.currentThemeStyle)
                }
                if let imageView = object as? UIImageView, imageView.dynamicImage != nil {
                    imageView.image = imageView.dynamicImage?(self.currentThemeStyle)
                }
                if let layer = object as? CALayer, layer.dynamicBackgroundColor != nil {
                    CATransaction.begin()
                    CATransaction.setDisableActions(true)
                    layer.backgroundColor = layer.dynamicBackgroundColor?(self.currentThemeStyle).cgColor
                    CATransaction.commit()
                }
                if let customizable = object as? ThemeCustomizable {
                    customizable.themeCustomization?(self.currentThemeStyle)
                }
            }
        }
    }
}
