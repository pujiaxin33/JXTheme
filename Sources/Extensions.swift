//
//  Extensions.swift
//  JXTheme
//
//  Created by jiaxin on 2019/7/10.
//  Copyright © 2019 jiaxin. All rights reserved.
//

import Foundation
import UIKit

//MARK: - ThemeWapper
public extension ThemeWapper where Base: UIView {
    var backgroundColor: ThemeColorDynamicProvider? {
        set(new) {
            if new != nil {
                let baseItem = self.base
                let config: ThemeCustomizationClosure = {[weak baseItem] (style) in
                    baseItem?.backgroundColor = new?(style)
                }
                self.base.configs["backgroundColor"] = config
                self.base.backgroundColor = new?(ThemeManager.shared.currentThemeStyle)
                ThemeManager.shared.trackedHashTable.add(self.base)
            }else {
                self.base.configs.removeValue(forKey: "backgroundColor")
            }
        }
        get {
            return nil
        }
    }
    var customization: ThemeCustomizationClosure? {
        set(new) {
            if new != nil {
                self.base.configs["customization"] = new!
                new?(ThemeManager.shared.currentThemeStyle)
                ThemeManager.shared.trackedHashTable.add(self.base)
            }else {
                self.base.configs.removeValue(forKey: "customization")
            }
        }
        get {
            return nil
        }
    }
}
public extension ThemeWapper where Base: UILabel {
    var textColor: ThemeColorDynamicProvider? {
        set(new) {
            if new != nil {
                let baseItem = self.base
                let config: ThemeCustomizationClosure = {[weak baseItem] (style) in
                    baseItem?.textColor = new?(style)
                }
                self.base.configs["textColor"] = config
                self.base.textColor = new?(ThemeManager.shared.currentThemeStyle)
                ThemeManager.shared.trackedHashTable.add(self.base)
            }else {
                self.base.configs.removeValue(forKey: "textColor")
            }
        }
        get {
            return nil
        }
    }
    var attributedText: ThemeAttributedTextDynamicProvider? {
        set(new) {
            if new != nil {
                let baseItem = self.base
                let config: ThemeCustomizationClosure = {[weak baseItem] (style) in
                    baseItem?.attributedText = new?(style)
                }
                self.base.configs["attributedText"] = config
                self.base.attributedText = new?(ThemeManager.shared.currentThemeStyle)
                ThemeManager.shared.trackedHashTable.add(self.base)
            }else {
                self.base.configs.removeValue(forKey: "attributedText")
            }
        }
        get {
            return nil
        }
    }
}
//TODO:navigationBar
//TODO:tabbar
//TODO:UISwitch
//TODO:UIButton titleColor
//TODO:attributeString
public extension ThemeWapper where Base: UITextField {
    var textColor: ThemeColorDynamicProvider? {
        set(new) {
            if new != nil {
                let baseItem = self.base
                let config: ThemeCustomizationClosure = {[weak baseItem] (style) in
                    baseItem?.textColor = new?(style)
                }
                self.base.configs["textColor"] = config
                self.base.textColor = new?(ThemeManager.shared.currentThemeStyle)
                ThemeManager.shared.trackedHashTable.add(self.base)
            }else {
                self.base.configs.removeValue(forKey: "textColor")
            }
        }
        get {
            return nil
        }
    }
    var attributedText: ThemeAttributedTextDynamicProvider? {
        set(new) {
            if new != nil {
                let baseItem = self.base
                let config: ThemeCustomizationClosure = {[weak baseItem] (style) in
                    baseItem?.attributedText = new?(style)
                }
                self.base.configs["attributedText"] = config
                self.base.attributedText = new?(ThemeManager.shared.currentThemeStyle)
                ThemeManager.shared.trackedHashTable.add(self.base)
            }else {
                self.base.configs.removeValue(forKey: "attributedText")
            }
        }
        get {
            return nil
        }
    }
}
public extension ThemeWapper where Base: UITextView {
    var textColor: ThemeColorDynamicProvider? {
        set(new) {
            if new != nil {
                let baseItem = self.base
                let config: ThemeCustomizationClosure = {[weak baseItem] (style) in
                    baseItem?.textColor = new?(style)
                }
                self.base.configs["textColor"] = config
                self.base.textColor = new?(ThemeManager.shared.currentThemeStyle)
                ThemeManager.shared.trackedHashTable.add(self.base)
            }else {
                self.base.configs.removeValue(forKey: "textColor")
            }
        }
        get {
            return nil
        }
    }
    var attributedText: ThemeAttributedTextDynamicProvider? {
        set(new) {
            if new != nil {
                let baseItem = self.base
                let config: ThemeCustomizationClosure = {[weak baseItem] (style) in
                    baseItem?.attributedText = new?(style)
                }
                self.base.configs["attributedText"] = config
                self.base.attributedText = new?(ThemeManager.shared.currentThemeStyle)
                ThemeManager.shared.trackedHashTable.add(self.base)
            }else {
                self.base.configs.removeValue(forKey: "attributedText")
            }
        }
        get {
            return nil
        }
    }
}
public extension ThemeWapper where Base: UIImageView {
    var image: ThemeImageDynamicProvider? {
        set(new) {
            if new != nil {
                let baseItem = self.base
                let config: ThemeCustomizationClosure = {[weak baseItem] (style) in
                    baseItem?.image = new?(style)
                }
                self.base.configs["image"] = config
                self.base.image = new?(ThemeManager.shared.currentThemeStyle)
                ThemeManager.shared.trackedHashTable.add(self.base)
            }else {
                self.base.configs.removeValue(forKey: "textColor")
            }
        }
        get {
            return nil
        }
    }
}
public extension ThemeWapper where Base: CALayer {
    var backgroundColor: ThemeColorDynamicProvider? {
        set(new) {
            if new != nil {
                let baseItem = self.base
                let config: ThemeCustomizationClosure = {[weak baseItem] (style) in
                    baseItem?.backgroundColor = new?(style).cgColor
                }
                self.base.configs["backgroundColor"] = config
                self.base.backgroundColor = new?(ThemeManager.shared.currentThemeStyle).cgColor
                ThemeManager.shared.trackedHashTable.add(self.base)
            }else {
                self.base.configs.removeValue(forKey: "backgroundColor")
            }
        }
        get {
            return nil
        }
    }
    var customization: ThemeCustomizationClosure? {
        set(new) {
            if new != nil {
                self.base.configs["customization"] = new!
                new?(ThemeManager.shared.currentThemeStyle)
                ThemeManager.shared.trackedHashTable.add(self.base)
            }else {
                self.base.configs.removeValue(forKey: "customization")
            }
        }
        get {
            return nil
        }
    }
}

//MARK: - Extentsion Property
internal extension UIView {
    struct AssociatedKey {
        static var configs: Void?
    }
    var configs: [String: ThemeCustomizationClosure] {
        set(new) {
            objc_setAssociatedObject(self, &AssociatedKey.configs, new, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            if objc_getAssociatedObject(self, &AssociatedKey.configs) as? [String: ThemeCustomizationClosure] == nil {
                self.configs = [String: ThemeCustomizationClosure]()
            }
            return objc_getAssociatedObject(self, &AssociatedKey.configs) as! [String: ThemeCustomizationClosure]
        }
    }
}

internal extension CALayer {
    struct AssociatedKey {
        static var configs: Void?
    }
    var configs: [String: ThemeCustomizationClosure] {
        set(new) {
            objc_setAssociatedObject(self, &AssociatedKey.configs, new, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            if objc_getAssociatedObject(self, &AssociatedKey.configs) as? [String: ThemeCustomizationClosure] == nil {
                self.configs = [String: ThemeCustomizationClosure]()
            }
            return objc_getAssociatedObject(self, &AssociatedKey.configs) as! [String: ThemeCustomizationClosure]
        }
    }
}
