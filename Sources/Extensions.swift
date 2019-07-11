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
                self.base.configs["view.backgroundColor"] = config
                self.base.backgroundColor = new?(ThemeManager.shared.currentThemeStyle)
                ThemeManager.shared.trackedHashTable.add(self.base)
            }else {
                self.base.configs.removeValue(forKey: "view.backgroundColor")
            }
        }
        get {
            return nil
        }
    }
    var customization: ThemeCustomizationClosure? {
        set(new) {
            if new != nil {
                self.base.configs["view.customization"] = new!
                new?(ThemeManager.shared.currentThemeStyle)
                ThemeManager.shared.trackedHashTable.add(self.base)
            }else {
                self.base.configs.removeValue(forKey: "view.customization")
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
                self.base.configs["label.textColor"] = config
                self.base.textColor = new?(ThemeManager.shared.currentThemeStyle)
                ThemeManager.shared.trackedHashTable.add(self.base)
            }else {
                self.base.configs.removeValue(forKey: "label.textColor")
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
                self.base.configs["label.attributedText"] = config
                self.base.attributedText = new?(ThemeManager.shared.currentThemeStyle)
                ThemeManager.shared.trackedHashTable.add(self.base)
            }else {
                self.base.configs.removeValue(forKey: "label.attributedText")
            }
        }
        get {
            return nil
        }
    }
}

public extension ThemeWapper where Base: UIButton {
    func setTitleColor(_ colorProvider: @escaping ThemeColorDynamicProvider, for state: UIControl.State) {
        let baseItem = self.base
        let config: ThemeCustomizationClosure = {[weak baseItem] (style) in
            baseItem?.setTitleColor(colorProvider(style), for: state)
        }
        self.base.configs["button.titleColor.\(state.rawValue)"] = config
        self.base.setTitleColor(colorProvider(ThemeManager.shared.currentThemeStyle), for: state)
        ThemeManager.shared.trackedHashTable.add(self.base)
    }

    func setTitleShadowColor(_ colorProvider: @escaping ThemeColorDynamicProvider, for state: UIControl.State) {
        let baseItem = self.base
        let config: ThemeCustomizationClosure = {[weak baseItem] (style) in
            baseItem?.setTitleShadowColor(colorProvider(style), for: state)
        }
        self.base.configs["button.titleShadowColor.\(state.rawValue)"] = config
        self.base.setTitleShadowColor(colorProvider(ThemeManager.shared.currentThemeStyle), for: state)
        ThemeManager.shared.trackedHashTable.add(self.base)
    }

    func setAttributedTitle(_ textProvider: @escaping ThemeAttributedTextDynamicProvider, for state: UIControl.State) {
        let baseItem = self.base
        let config: ThemeCustomizationClosure = {[weak baseItem] (style) in
            UIView.setAnimationsEnabled(false)
            baseItem?.setAttributedTitle(textProvider(style), for: state)
            baseItem?.layoutIfNeeded()
            UIView.setAnimationsEnabled(true)
        }
        self.base.configs["button.attributedTitle.\(state.rawValue)"] = config
        self.base.setAttributedTitle(textProvider(ThemeManager.shared.currentThemeStyle), for: state)
        ThemeManager.shared.trackedHashTable.add(self.base)
    }

    func setImage(_ imageProvider: @escaping ThemeImageDynamicProvider,for state: UIControl.State) {
        let baseItem = self.base
        let config: ThemeCustomizationClosure = {[weak baseItem] (style) in
            baseItem?.setImage(imageProvider(style), for: state)
        }
        self.base.configs["button.image.\(state.rawValue)"] = config
        self.base.setImage(imageProvider(ThemeManager.shared.currentThemeStyle), for: state)
        ThemeManager.shared.trackedHashTable.add(self.base)
    }

    func setBackgroundImage(_ imageProvider: @escaping ThemeImageDynamicProvider, for state: UIControl.State) {
        let baseItem = self.base
        let config: ThemeCustomizationClosure = {[weak baseItem] (style) in
            baseItem?.setBackgroundImage(imageProvider(style), for: state)
        }
        self.base.configs["button.backgroundImage.\(state.rawValue)"] = config
        self.base.setBackgroundImage(imageProvider(ThemeManager.shared.currentThemeStyle), for: state)
        ThemeManager.shared.trackedHashTable.add(self.base)
    }
}
//TODO:navigationBar
//TODO:tabbar
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
