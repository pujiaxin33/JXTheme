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
            setupViewThemeProperty(view: self.base, key: "UIView.backgroundColor", provider: new) {[weak baseItem] in
                baseItem?.backgroundColor = new?(ThemeManager.shared.currentThemeStyle)
            }
        }
        get { return nil }
    }
    var tintColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UIView.tintColor", provider: new) {[weak baseItem] in
                baseItem?.tintColor = new?(ThemeManager.shared.currentThemeStyle)
            }
        }
        get { return nil }
    }
    var alpha: ThemeCGFloatDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UIView.alpha", provider: new) {[weak baseItem] in
                baseItem?.alpha = new?(ThemeManager.shared.currentThemeStyle) ?? 1
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
    var font: ThemeFontDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UILabel.font", provider: new) {[weak baseItem] in
                baseItem?.font = new?(ThemeManager.shared.currentThemeStyle)
            }
        }
        get { return nil }
    }
    var textColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UILabel.textColor", provider: new) {[weak baseItem] in
                baseItem?.textColor = new?(ThemeManager.shared.currentThemeStyle)
            }
        }
        get { return nil }
    }
    var shadowColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UILabel.shadowColor", provider: new) {[weak baseItem] in
                baseItem?.shadowColor = new?(ThemeManager.shared.currentThemeStyle)
            }
        }
        get { return nil }
    }
    var highlightedTextColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UILabel.highlightedTextColor", provider: new) {[weak baseItem] in
                baseItem?.highlightedTextColor = new?(ThemeManager.shared.currentThemeStyle)
            }
        }
        get { return nil }
    }
    var attributedText: ThemeAttributedTextDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UILabel.attributedText", provider: new) {[weak baseItem] in
                baseItem?.attributedText = new?(ThemeManager.shared.currentThemeStyle)
            }
        }
        get { return nil }
    }
}

public extension ThemeWapper where Base: UIButton {
    func setTitleColor(_ colorProvider: ThemeColorDynamicProvider?, for state: UIControl.State) {
        let baseItem = self.base
        setupViewThemeProperty(view: self.base, key: "UIButton.titleColor.\(state.rawValue)", provider: colorProvider) {[weak baseItem] in
            baseItem?.setTitleColor(colorProvider?(ThemeManager.shared.currentThemeStyle), for: state)
        }
    }
    func setTitleShadowColor(_ colorProvider: ThemeColorDynamicProvider?, for state: UIControl.State) {
        let baseItem = self.base
        setupViewThemeProperty(view: self.base, key: "UIButton.titleShadowColor.\(state.rawValue)", provider: colorProvider) {[weak baseItem] in
            baseItem?.setTitleShadowColor(colorProvider?(ThemeManager.shared.currentThemeStyle), for: state)
        }
    }
    func setAttributedTitle(_ textProvider: ThemeAttributedTextDynamicProvider?, for state: UIControl.State) {
        let baseItem = self.base
        setupViewThemeProperty(view: self.base, key: "UIButton.attributedTitle.\(state.rawValue)", provider: textProvider) {[weak baseItem] in
            UIView.setAnimationsEnabled(false)
            baseItem?.setAttributedTitle(textProvider?(ThemeManager.shared.currentThemeStyle), for: state)
            baseItem?.layoutIfNeeded()
            UIView.setAnimationsEnabled(true)
        }
    }
    func setImage(_ imageProvider: ThemeImageDynamicProvider?, for state: UIControl.State) {
        let baseItem = self.base
        setupViewThemeProperty(view: self.base, key: "UIButton.image.\(state.rawValue)", provider: imageProvider) {[weak baseItem] in
            baseItem?.setImage(imageProvider?(ThemeManager.shared.currentThemeStyle), for: state)
        }
    }
    func setBackgroundImage(_ imageProvider: ThemeImageDynamicProvider?, for state: UIControl.State) {
        let baseItem = self.base
        setupViewThemeProperty(view: self.base, key: "UIButton.backgroundImage.\(state.rawValue)", provider: imageProvider) {[weak baseItem] in
            baseItem?.setBackgroundImage(imageProvider?(ThemeManager.shared.currentThemeStyle), for: state)
        }
    }
}
public extension ThemeWapper where Base: UITextField {
    var font: ThemeFontDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UITextField.font", provider: new) {[weak baseItem] in
                baseItem?.font = new?(ThemeManager.shared.currentThemeStyle)
            }
        }
        get { return nil }
    }
    var textColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UITextField.textColor", provider: new) {[weak baseItem] in
                baseItem?.textColor = new?(ThemeManager.shared.currentThemeStyle)
            }
        }
        get { return nil }
    }
    var attributedText: ThemeAttributedTextDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UITextField.attributedText", provider: new) {[weak baseItem] in
                baseItem?.attributedText = new?(ThemeManager.shared.currentThemeStyle)
            }
        }
        get { return nil }
    }
    var attributedPlaceholder: ThemeAttributedTextDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UITextField.attributedPlaceholder", provider: new) {[weak baseItem] in
                baseItem?.attributedPlaceholder = new?(ThemeManager.shared.currentThemeStyle)
            }
        }
        get { return nil }
    }
    var keyboardAppearance: ThemeKeyboardAppearanceDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UITextField.keyboardAppearance", provider: new) {[weak baseItem] in
                baseItem?.keyboardAppearance = new?(ThemeManager.shared.currentThemeStyle) ?? .default
            }
        }
        get { return nil }
    }
}
public extension ThemeWapper where Base: UITextView {
    var font: ThemeFontDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UITextView.font", provider: new) {[weak baseItem] in
                baseItem?.font = new?(ThemeManager.shared.currentThemeStyle)
            }
        }
        get { return nil }
    }
    var textColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UITextView.textColor", provider: new) {[weak baseItem] in
                baseItem?.textColor = new?(ThemeManager.shared.currentThemeStyle)
            }
        }
        get { return nil }
    }
    var attributedText: ThemeAttributedTextDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UITextView.attributedText", provider: new) {[weak baseItem] in
                baseItem?.attributedText = new?(ThemeManager.shared.currentThemeStyle)
            }
        }
        get { return nil }
    }
    var keyboardAppearance: ThemeKeyboardAppearanceDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UITextView.keyboardAppearance", provider: new) {[weak baseItem] in
                baseItem?.keyboardAppearance = new?(ThemeManager.shared.currentThemeStyle) ?? .default
            }
        }
        get { return nil }
    }
}
public extension ThemeWapper where Base: UIImageView {
    var image: ThemeImageDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UIImageView.image", provider: new) {[weak baseItem] in
                baseItem?.image = new?(ThemeManager.shared.currentThemeStyle)
            }
        }
        get { return nil }
    }
}
public extension ThemeWapper where Base: CALayer {
    var backgroundColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
//            self.base.borderColor
//            self.base.
//            self.base.shadowColor
            setupLayerThemeProperty(layer: self.base, key: "CALayer.backgroundColor", provider: new) {[weak baseItem] in
                baseItem?.backgroundColor = new?(ThemeManager.shared.currentThemeStyle).cgColor
            }
        }
        get { return nil }
    }
    var borderColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupLayerThemeProperty(layer: self.base, key: "CALayer.borderColor", provider: new) {[weak baseItem] in
                baseItem?.borderColor = new?(ThemeManager.shared.currentThemeStyle).cgColor
            }
        }
        get { return nil }
    }
    var borderWidth: ThemeCGFloatDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupLayerThemeProperty(layer: self.base, key: "CALayer.borderWidth", provider: new) {[weak baseItem] in
                baseItem?.borderWidth = new?(ThemeManager.shared.currentThemeStyle) ?? 0
            }
        }
        get { return nil }
    }
    var shadowColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupLayerThemeProperty(layer: self.base, key: "CALayer.shadowColor", provider: new) {[weak baseItem] in
                baseItem?.shadowColor = new?(ThemeManager.shared.currentThemeStyle).cgColor
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
public extension ThemeWapper where Base: CAShapeLayer {
    var fillColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupLayerThemeProperty(layer: self.base, key: "CAShapeLayer.fillColor", provider: new) {[weak baseItem] in
                baseItem?.fillColor = new?(ThemeManager.shared.currentThemeStyle).cgColor
            }
        }
        get { return nil }
    }
    var strokeColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupLayerThemeProperty(layer: self.base, key: "CAShapeLayer.strokeColor", provider: new) {[weak baseItem] in
                baseItem?.strokeColor = new?(ThemeManager.shared.currentThemeStyle).cgColor
            }
        }
        get { return nil }
    }
}
public extension ThemeWapper where Base: UINavigationBar {
    var barStyle: ThemeBarStyleDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UINavigationBar.barStyle", provider: new) {[weak baseItem] in
                baseItem?.barStyle = new?(ThemeManager.shared.currentThemeStyle) ?? .default
            }
        }
        get { return nil }
    }
    var barTintColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UINavigationBar.barTintColor", provider: new) {[weak baseItem] in
                baseItem?.barTintColor = new?(ThemeManager.shared.currentThemeStyle)
            }
        }
        get { return nil }
    }
    var titleTextAttributes: ThemeAttributesDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UINavigationBar.titleTextAttributes", provider: new) {[weak baseItem] in
                baseItem?.titleTextAttributes = new?(ThemeManager.shared.currentThemeStyle)
            }
        }
        get { return nil }
    }
    var largeTitleTextAttributes: ThemeAttributesDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UINavigationBar.largeTitleTextAttributes", provider: new) {[weak baseItem] in
                if #available(iOS 11.0, *) {
                    baseItem?.largeTitleTextAttributes = new?(ThemeManager.shared.currentThemeStyle)
                }
            }
        }
        get { return nil }
    }
}
public extension ThemeWapper where Base: UITabBar {
    var barStyle: ThemeBarStyleDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UITabBar.barStyle", provider: new) {[weak baseItem] in
                baseItem?.barStyle = new?(ThemeManager.shared.currentThemeStyle) ?? .default
            }
        }
        get { return nil }
    }
    var barTintColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UITabBar.barTintColor", provider: new) {[weak baseItem] in
                baseItem?.barTintColor = new?(ThemeManager.shared.currentThemeStyle)
            }
        }
        get { return nil }
    }
}
public extension ThemeWapper where Base: UISearchBar {
    var barStyle: ThemeBarStyleDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UISearchBar.barStyle", provider: new) {[weak baseItem] in
                baseItem?.barStyle = new?(ThemeManager.shared.currentThemeStyle) ?? .default
            }
        }
        get { return nil }
    }
    var barTintColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UISearchBar.barTintColor", provider: new) {[weak baseItem] in
                baseItem?.barTintColor = new?(ThemeManager.shared.currentThemeStyle)
            }
        }
        get { return nil }
    }
    var keyboardAppearance: ThemeKeyboardAppearanceDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UISearchBar.keyboardAppearance", provider: new) {[weak baseItem] in
                baseItem?.keyboardAppearance = new?(ThemeManager.shared.currentThemeStyle) ?? .default
            }
        }
        get { return nil }
    }
}
public extension ThemeWapper where Base: UIToolbar {
    var barStyle: ThemeBarStyleDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UIToolbar.barStyle", provider: new) {[weak baseItem] in
                baseItem?.barStyle = new?(ThemeManager.shared.currentThemeStyle) ?? .default
            }
        }
        get { return nil }
    }
    var barTintColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UIToolbar.barTintColor", provider: new) {[weak baseItem] in
                baseItem?.barTintColor = new?(ThemeManager.shared.currentThemeStyle)
            }
        }
        get { return nil }
    }
}
public extension ThemeWapper where Base: UISwitch {
    var onTintColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UISwitch.onTintColor", provider: new) {[weak baseItem] in
                baseItem?.onTintColor = new?(ThemeManager.shared.currentThemeStyle)
            }
        }
        get { return nil }
    }
    var thumbTintColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UISwitch.thumbTintColor", provider: new) {[weak baseItem] in
                baseItem?.thumbTintColor = new?(ThemeManager.shared.currentThemeStyle)
            }
        }
        get { return nil }
    }
}
public extension ThemeWapper where Base: UISlider {
    var thumbTintColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UISlider.thumbTintColor", provider: new) {[weak baseItem] in
                baseItem?.thumbTintColor = new?(ThemeManager.shared.currentThemeStyle)
            }
        }
        get { return nil }
    }
    var minimumTrackTintColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UISlider.minimumTrackTintColor", provider: new) {[weak baseItem] in
                baseItem?.minimumTrackTintColor = new?(ThemeManager.shared.currentThemeStyle)
            }
        }
        get { return nil }
    }
    var maximumTrackTintColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UISlider.maximumTrackTintColor", provider: new) {[weak baseItem] in
                baseItem?.maximumTrackTintColor = new?(ThemeManager.shared.currentThemeStyle)
            }
        }
        get { return nil }
    }
    var minimumValueImage: ThemeImageDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UISlider.minimumValueImage", provider: new) {[weak baseItem] in
                baseItem?.minimumValueImage = new?(ThemeManager.shared.currentThemeStyle)
            }
        }
        get { return nil }
    }
    var maximumValueImage: ThemeImageDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UISlider.maximumValueImage", provider: new) {[weak baseItem] in
                baseItem?.maximumValueImage = new?(ThemeManager.shared.currentThemeStyle)
            }
        }
        get { return nil }
    }
}
public extension ThemeWapper where Base: UIRefreshControl {
    var attributedTitle: ThemeAttributedTextDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UIRefreshControl.attributedTitle", provider: new) {[weak baseItem] in
                baseItem?.attributedTitle = new?(ThemeManager.shared.currentThemeStyle)
            }
        }
        get { return nil }
    }
}
public extension ThemeWapper where Base: UIProgressView {
    var progressTintColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UIProgressView.progressTintColor", provider: new) {[weak baseItem] in
                baseItem?.progressTintColor = new?(ThemeManager.shared.currentThemeStyle)
            }
        }
        get { return nil }
    }
    var trackTintColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UIProgressView.trackTintColor", provider: new) {[weak baseItem] in
                baseItem?.trackTintColor = new?(ThemeManager.shared.currentThemeStyle)
            }
        }
        get { return nil }
    }
    var progressImage: ThemeImageDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UIProgressView.progressImage", provider: new) {[weak baseItem] in
                baseItem?.progressImage = new?(ThemeManager.shared.currentThemeStyle)
            }
        }
        get { return nil }
    }
    var trackImage: ThemeImageDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UIProgressView.trackImage", provider: new) {[weak baseItem] in
                baseItem?.trackImage = new?(ThemeManager.shared.currentThemeStyle)
            }
        }
        get { return nil }
    }
}
public extension ThemeWapper where Base: UIPageControl {
    var pageIndicatorTintColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UIPageControl.pageIndicatorTintColor", provider: new) {[weak baseItem] in
                baseItem?.pageIndicatorTintColor = new?(ThemeManager.shared.currentThemeStyle)
            }
        }
        get { return nil }
    }
    var currentPageIndicatorTintColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UIProgressView.currentPageIndicatorTintColor", provider: new) {[weak baseItem] in
                baseItem?.currentPageIndicatorTintColor = new?(ThemeManager.shared.currentThemeStyle)
            }
        }
        get { return nil }
    }
}
public extension ThemeWapper where Base: UIBarItem {
    func setTitleTextAttributes(_ attributesProvider: ThemeAttributesDynamicProvider?, for state: UIControl.State) {
        if attributesProvider != nil {
            let baseItem = self.base
            let config: ThemeCustomizationClosure = {[weak baseItem] (style) in
                baseItem?.setTitleTextAttributes(attributesProvider?(ThemeManager.shared.currentThemeStyle), for: state)
            }
            self.base.configs["UIBarItem.setTitleTextAttributes"] = config
            self.base.setTitleTextAttributes(attributesProvider?(ThemeManager.shared.currentThemeStyle), for: state)
            ThemeManager.shared.trackedHashTable.add(self.base)
        }else {
            self.base.configs.removeValue(forKey: "UIBarItem.setTitleTextAttributes")
        }
    }
}
public extension ThemeWapper where Base: UIBarButtonItem {
    var tintColor: ThemeColorDynamicProvider? {
        set(new) {
            if new != nil {
                let baseItem = self.base
                let config: ThemeCustomizationClosure = {[weak baseItem] (style) in
                    baseItem?.tintColor = new?(style)
                }
                self.base.configs["UIBarButtonItem.tintColor"] = config
                self.base.tintColor = new?(ThemeManager.shared.currentThemeStyle)
                ThemeManager.shared.trackedHashTable.add(self.base)
            }else {
                self.base.configs.removeValue(forKey: "UIBarButtonItem.tintColor")
            }
        }
        get { return nil }
    }
}
public extension ThemeWapper where Base: UIActivityIndicatorView {
    var style: ThemeActivityIndicatorViewStyleDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UIActivityIndicatorView.style", provider: new) {[weak baseItem] in
                baseItem?.style = new?(ThemeManager.shared.currentThemeStyle) ?? UIActivityIndicatorView.Style.gray
            }
        }
        get { return nil }
    }
}
public extension ThemeWapper where Base: UIScrollView {
    var indicatorStyle: ThemeUIScrollViewIndicatorStyleDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UIScrollView.indicatorStyle", provider: new) {[weak baseItem] in
                baseItem?.indicatorStyle = new?(ThemeManager.shared.currentThemeStyle) ?? UIScrollView.IndicatorStyle.default
            }
        }
        get { return nil }
    }
}
public extension ThemeWapper where Base: UITableView {
    var separatorColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UITableView.separatorColor", provider: new) {[weak baseItem] in
                baseItem?.separatorColor = new?(ThemeManager.shared.currentThemeStyle)
            }
        }
        get { return nil }
    }
    var sectionIndexColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UITableView.sectionIndexColor", provider: new) {[weak baseItem] in
                baseItem?.sectionIndexColor = new?(ThemeManager.shared.currentThemeStyle)
            }
        }
        get { return nil }
    }
    var sectionIndexBackgroundColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UITableView.sectionIndexBackgroundColor", provider: new) {[weak baseItem] in
                baseItem?.sectionIndexBackgroundColor = new?(ThemeManager.shared.currentThemeStyle)
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
internal extension UIBarItem {
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
