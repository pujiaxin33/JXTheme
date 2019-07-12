//
//  Extensions.swift
//  JXTheme
//
//  Created by jiaxin on 2019/7/10.
//  Copyright © 2019 jiaxin. All rights reserved.
//

import Foundation
import UIKit

func setupViewThemeProperty<T>(view: UIView, key: String, provider: ThemePropertyDynamicProvider<T>?, customization: @escaping () -> ()) {
    if provider != nil {
        let config: ThemeCustomizationClosure = {(style) in
            customization()
        }
        view.configs[key] = config
        customization()
        ThemeManager.shared.trackedHashTable.add(view)
    }else {
        view.configs.removeValue(forKey: key)
    }
}

//MARK: - ThemeWapper
public extension ThemeWapper where Base: UIView {
    var backgroundColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UIView.backgroundColor", provider: new) {
                baseItem.backgroundColor = new?(ThemeManager.shared.currentThemeStyle)
            }
        }
        get {
            return nil
        }
    }

    var tintColor: ThemeColorDynamicProvider? {
        set(new) {
            if new != nil {
                let baseItem = self.base
                let config: ThemeCustomizationClosure = {[weak baseItem] (style) in
                    baseItem?.tintColor = new?(style)
                }
                self.base.configs["UIView.tintColor"] = config
                self.base.tintColor = new?(ThemeManager.shared.currentThemeStyle)
                ThemeManager.shared.trackedHashTable.add(self.base)
            }else {
                self.base.configs.removeValue(forKey: "UIView.tintColor")
            }
        }
        get {
            return nil
        }
    }
    var customization: ThemeCustomizationClosure? {
        set(new) {
            if new != nil {
                self.base.configs["UIView.customization"] = new!
                new?(ThemeManager.shared.currentThemeStyle)
                ThemeManager.shared.trackedHashTable.add(self.base)
            }else {
                self.base.configs.removeValue(forKey: "UIView.customization")
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
                self.base.configs["UILabel.textColor"] = config
                self.base.textColor = new?(ThemeManager.shared.currentThemeStyle)
                ThemeManager.shared.trackedHashTable.add(self.base)
            }else {
                self.base.configs.removeValue(forKey: "UILabel.textColor")
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
                self.base.configs["UILabel.attributedText"] = config
                self.base.attributedText = new?(ThemeManager.shared.currentThemeStyle)
                ThemeManager.shared.trackedHashTable.add(self.base)
            }else {
                self.base.configs.removeValue(forKey: "UILabel.attributedText")
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
        self.base.configs["UIButton.titleColor.\(state.rawValue)"] = config
        self.base.setTitleColor(colorProvider(ThemeManager.shared.currentThemeStyle), for: state)
        ThemeManager.shared.trackedHashTable.add(self.base)
    }

    func setTitleShadowColor(_ colorProvider: @escaping ThemeColorDynamicProvider, for state: UIControl.State) {
        let baseItem = self.base
        let config: ThemeCustomizationClosure = {[weak baseItem] (style) in
            baseItem?.setTitleShadowColor(colorProvider(style), for: state)
        }
        self.base.configs["UIButton.titleShadowColor.\(state.rawValue)"] = config
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
        self.base.configs["UIButton.attributedTitle.\(state.rawValue)"] = config
        self.base.setAttributedTitle(textProvider(ThemeManager.shared.currentThemeStyle), for: state)
        ThemeManager.shared.trackedHashTable.add(self.base)
    }

    func setImage(_ imageProvider: @escaping ThemeImageDynamicProvider,for state: UIControl.State) {
        let baseItem = self.base
        let config: ThemeCustomizationClosure = {[weak baseItem] (style) in
            baseItem?.setImage(imageProvider(style), for: state)
        }
        self.base.configs["UIButton.image.\(state.rawValue)"] = config
        self.base.setImage(imageProvider(ThemeManager.shared.currentThemeStyle), for: state)
        ThemeManager.shared.trackedHashTable.add(self.base)
    }

    func setBackgroundImage(_ imageProvider: @escaping ThemeImageDynamicProvider, for state: UIControl.State) {
        let baseItem = self.base
        let config: ThemeCustomizationClosure = {[weak baseItem] (style) in
            baseItem?.setBackgroundImage(imageProvider(style), for: state)
        }
        self.base.configs["UIButton.backgroundImage.\(state.rawValue)"] = config
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
                self.base.configs["UITextField.textColor"] = config
                self.base.textColor = new?(ThemeManager.shared.currentThemeStyle)
                ThemeManager.shared.trackedHashTable.add(self.base)
            }else {
                self.base.configs.removeValue(forKey: "UITextField.textColor")
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
                self.base.configs["UITextField.attributedText"] = config
                self.base.attributedText = new?(ThemeManager.shared.currentThemeStyle)
                ThemeManager.shared.trackedHashTable.add(self.base)
            }else {
                self.base.configs.removeValue(forKey: "UITextField.attributedText")
            }
        }
        get {
            return nil
        }
    }
    var attributedPlaceholder: ThemeAttributedTextDynamicProvider? {
        set(new) {
            if new != nil {
                let baseItem = self.base
                let config: ThemeCustomizationClosure = {[weak baseItem] (style) in
                    baseItem?.attributedPlaceholder = new?(style)
                }
                self.base.configs["UITextField.attributedPlaceholder"] = config
                self.base.attributedPlaceholder = new?(ThemeManager.shared.currentThemeStyle)
                ThemeManager.shared.trackedHashTable.add(self.base)
            }else {
                self.base.configs.removeValue(forKey: "UITextField.attributedPlaceholder")
            }
        }
        get {
            return nil
        }
    }
    var keyboardAppearance: ThemeKeyboardAppearanceDynamicProvider? {
        set(new) {
            if new != nil {
                let baseItem = self.base
                let config: ThemeCustomizationClosure = {[weak baseItem] (style) in
                    baseItem?.keyboardAppearance = new?(style) ?? .default
                }
                self.base.configs["UITextField.keyboardAppearance"] = config
                self.base.keyboardAppearance = new?(ThemeManager.shared.currentThemeStyle) ?? .default
                ThemeManager.shared.trackedHashTable.add(self.base)
            }else {
                self.base.configs.removeValue(forKey: "UITextField.keyboardAppearance")
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
    var keyboardAppearance: ThemeKeyboardAppearanceDynamicProvider? {
        set(new) {
            if new != nil {
                let baseItem = self.base
                let config: ThemeCustomizationClosure = {[weak baseItem] (style) in
                    baseItem?.keyboardAppearance = new?(style) ?? .default
                }
                self.base.configs["UITextField.keyboardAppearance"] = config
                self.base.keyboardAppearance = new?(ThemeManager.shared.currentThemeStyle) ?? .default
                ThemeManager.shared.trackedHashTable.add(self.base)
            }else {
                self.base.configs.removeValue(forKey: "UITextField.keyboardAppearance")
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
