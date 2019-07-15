//
//  Extensions.swift
//  JXTheme
//
//  Created by jiaxin on 2019/7/10.
//  Copyright © 2019 jiaxin. All rights reserved.
//

import Foundation
import UIKit

func setupViewThemeProperty<T>(view: UIView, key: String, provider: ThemePropertyDynamicProvider<T>?, customization: @escaping (ThemeStyle) -> ()) {
    if provider != nil {
        let config: ThemeCustomizationClosure = {(style) in
            customization(style)
        }
        view.configs[key] = config
        ThemeManager.shared.addTrackedObject(view, addedConfig: config)
    }else {
        view.configs.removeValue(forKey: key)
    }
}
func setupLayerThemeProperty<T>(layer: CALayer, key: String, provider: ThemePropertyDynamicProvider<T>?, customization: @escaping (ThemeStyle) -> ()) {
    if provider != nil {
        let config: ThemeCustomizationClosure = {(style) in
            customization(style)
        }
        layer.configs[key] = config
        ThemeManager.shared.addTrackedObject(layer, addedConfig: config)
    }else {
        layer.configs.removeValue(forKey: key)
    }
}

//MARK: - ThemeWapper
public extension ThemeWapper where Base: UIView {
    var backgroundColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UIView.backgroundColor", provider: new) {[weak baseItem] (style) in
                baseItem?.backgroundColor = new?(style)
            }
        }
        get { return nil }
    }
    var tintColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UIView.tintColor", provider: new) {[weak baseItem] (style) in
                baseItem?.tintColor = new?(style)
            }
        }
        get { return nil }
    }
    var alpha: ThemeCGFloatDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UIView.alpha", provider: new) {[weak baseItem] (style) in
                baseItem?.alpha = new?(style) ?? 1
            }
        }
        get { return nil }
    }
    var customization: ThemeCustomizationClosure? {
        set(new) {
            setupViewThemeProperty(view: self.base, key: "UIView.customization", provider: new) { (style) in
                new?(style)
            }
        }
        get { return nil }
    }
}
public extension ThemeWapper where Base: UILabel {
    var font: ThemeFontDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UILabel.font", provider: new) {[weak baseItem] (style) in
                baseItem?.font = new?(style)
            }
        }
        get { return nil }
    }
    var textColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UILabel.textColor", provider: new) {[weak baseItem] (style) in
                baseItem?.textColor = new?(style)
            }
        }
        get { return nil }
    }
    var shadowColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UILabel.shadowColor", provider: new) {[weak baseItem] (style) in
                baseItem?.shadowColor = new?(style)
            }
        }
        get { return nil }
    }
    var highlightedTextColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UILabel.highlightedTextColor", provider: new) {[weak baseItem] (style) in
                baseItem?.highlightedTextColor = new?(style)
            }
        }
        get { return nil }
    }
    var attributedText: ThemeAttributedTextDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UILabel.attributedText", provider: new) {[weak baseItem] (style) in
                baseItem?.attributedText = new?(style)
            }
        }
        get { return nil }
    }
}

public extension ThemeWapper where Base: UIButton {
    func setTitleColor(_ colorProvider: ThemeColorDynamicProvider?, for state: UIControl.State) {
        let baseItem = self.base
        setupViewThemeProperty(view: self.base, key: "UIButton.titleColor.\(state.rawValue)", provider: colorProvider) {[weak baseItem] (style) in
            baseItem?.setTitleColor(colorProvider?(style), for: state)
        }
    }
    func setTitleShadowColor(_ colorProvider: ThemeColorDynamicProvider?, for state: UIControl.State) {
        let baseItem = self.base
        setupViewThemeProperty(view: self.base, key: "UIButton.titleShadowColor.\(state.rawValue)", provider: colorProvider) {[weak baseItem] (style) in
            baseItem?.setTitleShadowColor(colorProvider?(style), for: state)
        }
    }
    func setAttributedTitle(_ textProvider: ThemeAttributedTextDynamicProvider?, for state: UIControl.State) {
        let baseItem = self.base
        setupViewThemeProperty(view: self.base, key: "UIButton.attributedTitle.\(state.rawValue)", provider: textProvider) {[weak baseItem] (style) in
            UIView.setAnimationsEnabled(false)
            baseItem?.setAttributedTitle(textProvider?(style), for: state)
            baseItem?.layoutIfNeeded()
            UIView.setAnimationsEnabled(true)
        }
    }
    func setImage(_ imageProvider: ThemeImageDynamicProvider?, for state: UIControl.State) {
        let baseItem = self.base
        setupViewThemeProperty(view: self.base, key: "UIButton.image.\(state.rawValue)", provider: imageProvider) {[weak baseItem] (style) in
            baseItem?.setImage(imageProvider?(style), for: state)
        }
    }
    func setBackgroundImage(_ imageProvider: ThemeImageDynamicProvider?, for state: UIControl.State) {
        let baseItem = self.base
        setupViewThemeProperty(view: self.base, key: "UIButton.backgroundImage.\(state.rawValue)", provider: imageProvider) {[weak baseItem] (style) in
            baseItem?.setBackgroundImage(imageProvider?(style), for: state)
        }
    }
}
public extension ThemeWapper where Base: UITextField {
    var font: ThemeFontDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UITextField.font", provider: new) {[weak baseItem] (style) in
                baseItem?.font = new?(style)
            }
        }
        get { return nil }
    }
    var textColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UITextField.textColor", provider: new) {[weak baseItem] (style) in
                baseItem?.textColor = new?(style)
            }
        }
        get { return nil }
    }
    var attributedText: ThemeAttributedTextDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UITextField.attributedText", provider: new) {[weak baseItem] (style) in
                baseItem?.attributedText = new?(style)
            }
        }
        get { return nil }
    }
    var attributedPlaceholder: ThemeAttributedTextDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UITextField.attributedPlaceholder", provider: new) {[weak baseItem] (style) in
                baseItem?.attributedPlaceholder = new?(style)
            }
        }
        get { return nil }
    }
    var keyboardAppearance: ThemeKeyboardAppearanceDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UITextField.keyboardAppearance", provider: new) {[weak baseItem] (style) in
                baseItem?.keyboardAppearance = new?(style) ?? .default
            }
        }
        get { return nil }
    }
}
public extension ThemeWapper where Base: UITextView {
    var font: ThemeFontDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UITextView.font", provider: new) {[weak baseItem] (style) in
                baseItem?.font = new?(style)
            }
        }
        get { return nil }
    }
    var textColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UITextView.textColor", provider: new) {[weak baseItem] (style) in
                baseItem?.textColor = new?(style)
            }
        }
        get { return nil }
    }
    var attributedText: ThemeAttributedTextDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UITextView.attributedText", provider: new) {[weak baseItem] (style) in
                baseItem?.attributedText = new?(style)
            }
        }
        get { return nil }
    }
    var keyboardAppearance: ThemeKeyboardAppearanceDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UITextView.keyboardAppearance", provider: new) {[weak baseItem] (style) in
                baseItem?.keyboardAppearance = new?(style) ?? .default
            }
        }
        get { return nil }
    }
}
public extension ThemeWapper where Base: UIImageView {
    var image: ThemeImageDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UIImageView.image", provider: new) {[weak baseItem] (style) in
                baseItem?.image = new?(style)
            }
        }
        get { return nil }
    }
}
public extension ThemeWapper where Base: CALayer {
    var backgroundColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupLayerThemeProperty(layer: self.base, key: "CALayer.backgroundColor", provider: new) {[weak baseItem] (style) in
                baseItem?.backgroundColor = new?(style).cgColor
            }
        }
        get { return nil }
    }
    var borderColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupLayerThemeProperty(layer: self.base, key: "CALayer.borderColor", provider: new) {[weak baseItem] (style) in
                baseItem?.borderColor = new?(style).cgColor
            }
        }
        get { return nil }
    }
    var borderWidth: ThemeCGFloatDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupLayerThemeProperty(layer: self.base, key: "CALayer.borderWidth", provider: new) {[weak baseItem] (style) in
                baseItem?.borderWidth = new?(style) ?? 0
            }
        }
        get { return nil }
    }
    var shadowColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupLayerThemeProperty(layer: self.base, key: "CALayer.shadowColor", provider: new) {[weak baseItem] (style) in
                baseItem?.shadowColor = new?(style).cgColor
            }
        }
        get { return nil }
    }
    var customization: ThemeCustomizationClosure? {
        set(new) {
            setupLayerThemeProperty(layer: self.base, key: "CALayer.customization", provider: new) { (style) in
                new?(style)
            }
        }
        get { return nil }
    }
}
public extension ThemeWapper where Base: CAShapeLayer {
    var fillColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupLayerThemeProperty(layer: self.base, key: "CAShapeLayer.fillColor", provider: new) {[weak baseItem] (style) in
                baseItem?.fillColor = new?(style).cgColor
            }
        }
        get { return nil }
    }
    var strokeColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupLayerThemeProperty(layer: self.base, key: "CAShapeLayer.strokeColor", provider: new) {[weak baseItem] (style) in
                baseItem?.strokeColor = new?(style).cgColor
            }
        }
        get { return nil }
    }
}
public extension ThemeWapper where Base: UINavigationBar {
    var barStyle: ThemeBarStyleDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UINavigationBar.barStyle", provider: new) {[weak baseItem] (style) in
                baseItem?.barStyle = new?(style) ?? .default
            }
        }
        get { return nil }
    }
    var barTintColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UINavigationBar.barTintColor", provider: new) {[weak baseItem] (style) in
                baseItem?.barTintColor = new?(style)
            }
        }
        get { return nil }
    }
    var titleTextAttributes: ThemeAttributesDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UINavigationBar.titleTextAttributes", provider: new) {[weak baseItem] (style) in
                baseItem?.titleTextAttributes = new?(style)
            }
        }
        get { return nil }
    }
    @available(iOS 11.0, *)
    var largeTitleTextAttributes: ThemeAttributesDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UINavigationBar.largeTitleTextAttributes", provider: new) {[weak baseItem] (style) in
                baseItem?.largeTitleTextAttributes = new?(style)
            }
        }
        get { return nil }
    }
}
public extension ThemeWapper where Base: UITabBar {
    var barStyle: ThemeBarStyleDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UITabBar.barStyle", provider: new) {[weak baseItem] (style) in
                baseItem?.barStyle = new?(style) ?? .default
            }
        }
        get { return nil }
    }
    var barTintColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UITabBar.barTintColor", provider: new) {[weak baseItem] (style) in
                baseItem?.barTintColor = new?(style)
            }
        }
        get { return nil }
    }
}
public extension ThemeWapper where Base: UISearchBar {
    var barStyle: ThemeBarStyleDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UISearchBar.barStyle", provider: new) {[weak baseItem] (style) in
                baseItem?.barStyle = new?(style) ?? .default
            }
        }
        get { return nil }
    }
    var barTintColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UISearchBar.barTintColor", provider: new) {[weak baseItem] (style) in
                baseItem?.barTintColor = new?(style)
            }
        }
        get { return nil }
    }
    var keyboardAppearance: ThemeKeyboardAppearanceDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UISearchBar.keyboardAppearance", provider: new) {[weak baseItem] (style) in
                baseItem?.keyboardAppearance = new?(style) ?? .default
            }
        }
        get { return nil }
    }
}
public extension ThemeWapper where Base: UIToolbar {
    var barStyle: ThemeBarStyleDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UIToolbar.barStyle", provider: new) {[weak baseItem] (style) in
                baseItem?.barStyle = new?(style) ?? .default
            }
        }
        get { return nil }
    }
    var barTintColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UIToolbar.barTintColor", provider: new) {[weak baseItem] (style) in
                baseItem?.barTintColor = new?(style)
            }
        }
        get { return nil }
    }
}
public extension ThemeWapper where Base: UISwitch {
    var onTintColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UISwitch.onTintColor", provider: new) {[weak baseItem] (style) in
                baseItem?.onTintColor = new?(style)
            }
        }
        get { return nil }
    }
    var thumbTintColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UISwitch.thumbTintColor", provider: new) {[weak baseItem] (style) in
                baseItem?.thumbTintColor = new?(style)
            }
        }
        get { return nil }
    }
}
public extension ThemeWapper where Base: UISlider {
    var thumbTintColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UISlider.thumbTintColor", provider: new) {[weak baseItem] (style) in
                baseItem?.thumbTintColor = new?(style)
            }
        }
        get { return nil }
    }
    var minimumTrackTintColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UISlider.minimumTrackTintColor", provider: new) {[weak baseItem] (style) in
                baseItem?.minimumTrackTintColor = new?(style)
            }
        }
        get { return nil }
    }
    var maximumTrackTintColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UISlider.maximumTrackTintColor", provider: new) {[weak baseItem] (style) in
                baseItem?.maximumTrackTintColor = new?(style)
            }
        }
        get { return nil }
    }
    var minimumValueImage: ThemeImageDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UISlider.minimumValueImage", provider: new) {[weak baseItem] (style) in
                baseItem?.minimumValueImage = new?(style)
            }
        }
        get { return nil }
    }
    var maximumValueImage: ThemeImageDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UISlider.maximumValueImage", provider: new) {[weak baseItem] (style) in
                baseItem?.maximumValueImage = new?(style)
            }
        }
        get { return nil }
    }
}
public extension ThemeWapper where Base: UIRefreshControl {
    var attributedTitle: ThemeAttributedTextDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UIRefreshControl.attributedTitle", provider: new) {[weak baseItem] (style) in
                baseItem?.attributedTitle = new?(style)
            }
        }
        get { return nil }
    }
}
public extension ThemeWapper where Base: UIProgressView {
    var progressTintColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UIProgressView.progressTintColor", provider: new) {[weak baseItem] (style) in
                baseItem?.progressTintColor = new?(style)
            }
        }
        get { return nil }
    }
    var trackTintColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UIProgressView.trackTintColor", provider: new) {[weak baseItem] (style) in
                baseItem?.trackTintColor = new?(style)
            }
        }
        get { return nil }
    }
    var progressImage: ThemeImageDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UIProgressView.progressImage", provider: new) {[weak baseItem] (style) in
                baseItem?.progressImage = new?(style)
            }
        }
        get { return nil }
    }
    var trackImage: ThemeImageDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UIProgressView.trackImage", provider: new) {[weak baseItem] (style) in
                baseItem?.trackImage = new?(style)
            }
        }
        get { return nil }
    }
}
public extension ThemeWapper where Base: UIPageControl {
    var pageIndicatorTintColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UIPageControl.pageIndicatorTintColor", provider: new) {[weak baseItem] (style) in
                baseItem?.pageIndicatorTintColor = new?(style)
            }
        }
        get { return nil }
    }
    var currentPageIndicatorTintColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UIProgressView.currentPageIndicatorTintColor", provider: new) {[weak baseItem] (style) in
                baseItem?.currentPageIndicatorTintColor = new?(style)
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
                baseItem?.setTitleTextAttributes(attributesProvider?(style), for: state)
            }
            self.base.configs["UIBarItem.setTitleTextAttributes"] = config
            ThemeManager.shared.addTrackedObject(self.base, addedConfig: config)
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
                ThemeManager.shared.addTrackedObject(self.base, addedConfig: config)
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
            setupViewThemeProperty(view: self.base, key: "UIActivityIndicatorView.style", provider: new) {[weak baseItem] (style) in
                baseItem?.style = new?(style) ?? UIActivityIndicatorView.Style.gray
            }
        }
        get { return nil }
    }
}
public extension ThemeWapper where Base: UIScrollView {
    var indicatorStyle: ThemeUIScrollViewIndicatorStyleDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UIScrollView.indicatorStyle", provider: new) {[weak baseItem] (style) in
                baseItem?.indicatorStyle = new?(style) ?? UIScrollView.IndicatorStyle.default
            }
        }
        get { return nil }
    }
}
public extension ThemeWapper where Base: UITableView {
    var separatorColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UITableView.separatorColor", provider: new) {[weak baseItem] (style) in
                baseItem?.separatorColor = new?(style)
            }
        }
        get { return nil }
    }
    var sectionIndexColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UITableView.sectionIndexColor", provider: new) {[weak baseItem] (style) in
                baseItem?.sectionIndexColor = new?(style)
            }
        }
        get { return nil }
    }
    var sectionIndexBackgroundColor: ThemeColorDynamicProvider? {
        set(new) {
            let baseItem = self.base
            setupViewThemeProperty(view: self.base, key: "UITableView.sectionIndexBackgroundColor", provider: new) {[weak baseItem] (style) in
                baseItem?.sectionIndexBackgroundColor = new?(style)
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
