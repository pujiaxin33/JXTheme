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
func setupLayerThemeProperty<T>(layer: CALayer, key: String, provider: ThemePropertyDynamicProvider<T>?, customization: @escaping () -> ()) {
    if provider != nil {
        let config: ThemeCustomizationClosure = {(style) in
            customization()
        }
        layer.configs[key] = config
        customization()
        ThemeManager.shared.trackedHashTable.add(layer)
    }else {
        layer.configs.removeValue(forKey: key)
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
        get { return nil }
    }

    var tintColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UIView.tintColor", provider: new) {
                baseItem.tintColor = new?(ThemeManager.shared.currentThemeStyle)
            }
        }
        get { return nil }
    }
    var customization: ThemeCustomizationClosure? {
        set(new) {
            setupViewThemeProperty(view: self.base, key: "UIView.customization", provider: new) {
                new?(ThemeManager.shared.currentThemeStyle)
            }
        }
        get { return nil }
    }
}
public extension ThemeWapper where Base: UILabel {
    var textColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UILabel.textColor", provider: new) {
                baseItem.textColor = new?(ThemeManager.shared.currentThemeStyle)
            }
        }
        get { return nil }
    }
    var attributedText: ThemeAttributedTextDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UILabel.attributedText", provider: new) {
                baseItem.attributedText = new?(ThemeManager.shared.currentThemeStyle)
            }
        }
        get { return nil }
    }
}

public extension ThemeWapper where Base: UIButton {
    func setTitleColor(_ colorProvider: ThemeColorDynamicProvider?, for state: UIControl.State) {
        let baseItem = self.base
        setupViewThemeProperty(view: self.base, key: "UIButton.titleColor.\(state.rawValue)", provider: colorProvider) {
            baseItem.setTitleColor(colorProvider?(ThemeManager.shared.currentThemeStyle), for: state)
        }
    }

    func setTitleShadowColor(_ colorProvider: ThemeColorDynamicProvider?, for state: UIControl.State) {
        let baseItem = self.base
        setupViewThemeProperty(view: self.base, key: "UIButton.titleShadowColor.\(state.rawValue)", provider: colorProvider) {
            baseItem.setTitleShadowColor(colorProvider?(ThemeManager.shared.currentThemeStyle), for: state)
        }
    }

    func setAttributedTitle(_ textProvider: ThemeAttributedTextDynamicProvider?, for state: UIControl.State) {
        let baseItem = self.base
        setupViewThemeProperty(view: self.base, key: "UIButton.attributedTitle.\(state.rawValue)", provider: textProvider) {
            UIView.setAnimationsEnabled(false)
            baseItem.setAttributedTitle(textProvider?(ThemeManager.shared.currentThemeStyle), for: state)
            baseItem.layoutIfNeeded()
            UIView.setAnimationsEnabled(true)
        }
    }

    func setImage(_ imageProvider: ThemeImageDynamicProvider?, for state: UIControl.State) {
        let baseItem = self.base
        setupViewThemeProperty(view: self.base, key: "UIButton.image.\(state.rawValue)", provider: imageProvider) {
            baseItem.setImage(imageProvider?(ThemeManager.shared.currentThemeStyle), for: state)
        }
    }

    func setBackgroundImage(_ imageProvider: ThemeImageDynamicProvider?, for state: UIControl.State) {
        let baseItem = self.base
        setupViewThemeProperty(view: self.base, key: "UIButton.backgroundImage.\(state.rawValue)", provider: imageProvider) {
            baseItem.setBackgroundImage(imageProvider?(ThemeManager.shared.currentThemeStyle), for: state)
        }
    }
}
//TODO:navigationBar
//TODO:tabbar
public extension ThemeWapper where Base: UITextField {
    var textColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UITextField.textColor", provider: new) {
                baseItem.textColor = new?(ThemeManager.shared.currentThemeStyle)
            }
        }
        get { return nil }
    }
    var attributedText: ThemeAttributedTextDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UITextField.attributedText", provider: new) {
                baseItem.attributedText = new?(ThemeManager.shared.currentThemeStyle)
            }
        }
        get { return nil }
    }
    var attributedPlaceholder: ThemeAttributedTextDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UITextField.attributedPlaceholder", provider: new) {
                baseItem.attributedPlaceholder = new?(ThemeManager.shared.currentThemeStyle)
            }
        }
        get { return nil }
    }
    var keyboardAppearance: ThemeKeyboardAppearanceDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UITextField.keyboardAppearance", provider: new) {
                baseItem.keyboardAppearance = new?(ThemeManager.shared.currentThemeStyle) ?? .default
            }
        }
        get { return nil }
    }
}
public extension ThemeWapper where Base: UITextView {
    var textColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UITextView.textColor", provider: new) {
                baseItem.textColor = new?(ThemeManager.shared.currentThemeStyle)
            }
        }
        get { return nil }
    }
    var attributedText: ThemeAttributedTextDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UITextView.attributedText", provider: new) {
                baseItem.attributedText = new?(ThemeManager.shared.currentThemeStyle)
            }
        }
        get { return nil }
    }
    var keyboardAppearance: ThemeKeyboardAppearanceDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UITextView.keyboardAppearance", provider: new) {
                baseItem.keyboardAppearance = new?(ThemeManager.shared.currentThemeStyle) ?? .default
            }
        }
        get { return nil }
    }
}
public extension ThemeWapper where Base: UIImageView {
    var image: ThemeImageDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UIImageView.image", provider: new) {
                baseItem.image = new?(ThemeManager.shared.currentThemeStyle)
            }
        }
        get { return nil }
    }
}
public extension ThemeWapper where Base: CALayer {
    var backgroundColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupLayerThemeProperty(layer: self.base, key: "CALayer.backgroundColor", provider: new) {
                baseItem.backgroundColor = new?(ThemeManager.shared.currentThemeStyle).cgColor
            }
        }
        get { return nil }
    }
    var customization: ThemeCustomizationClosure? {
        set(new) {
            setupLayerThemeProperty(layer: self.base, key: "CALayer.customization", provider: new) {
                new?(ThemeManager.shared.currentThemeStyle)
            }
        }
        get { return nil }
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
