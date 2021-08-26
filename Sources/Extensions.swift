//
//  Extensions.swift
//  JXTheme
//
//  Created by jiaxin on 2019/7/10.
//  Copyright © 2019 jiaxin. All rights reserved.
//

import Foundation
import UIKit

public class ThemeTool {
    public static func setupViewThemeProperty<T>(view: UIView, key: String, provider: ThemeProvider<T>?, customization: @escaping (ThemeStyle) -> ()) {
        if provider != nil {
            let config: ThemeCustomizationClosure = {(style) in
                customization(style)
            }
            var newProvider = provider
            newProvider?.config = config
            view.providers[key] = newProvider
            ThemeManager.shared.addTrackedObject(view, addedConfig: config)
        }else {
            view.providers.removeValue(forKey: key)
        }
    }
    public static func setupLayerThemeProperty<T>(layer: CALayer, key: String, provider: ThemeProvider<T>?, customization: @escaping (ThemeStyle) -> ()) {
        if provider != nil {
            let config: ThemeCustomizationClosure = {(style) in
                customization(style)
            }
            var newProvider = provider
            newProvider?.config = config
            layer.providers[key] = newProvider
            ThemeManager.shared.addTrackedObject(layer, addedConfig: config)
        }else {
            layer.providers.removeValue(forKey: key)
        }
    }
    public static func setupBarItemThemeProperty<T>(barItem: UIBarItem, key: String, provider: ThemeProvider<T>?, customization: @escaping (ThemeStyle) -> ()) {
        if provider != nil {
            let config: ThemeCustomizationClosure = {(style) in
                customization(style)
            }
            var newProvider = provider
            newProvider?.config = config
            barItem.providers[key] = newProvider
            ThemeManager.shared.addTrackedObject(barItem, addedConfig: config)
        }else {
            barItem.providers.removeValue(forKey: key)
        }
    }
    
    public static func getThemeProvider(target: UIView, with key: String) -> Any? {
        return target.providers[key]
    }
    
    public static func getThemeProvider(target: CALayer, with key: String) -> Any? {
        return target.providers[key]
    }
    
    public static func getThemeProvider(target: UIBarItem, with key: String) -> Any? {
        return target.providers[key]
    }
}

//MARK: - ThemeWrapper
public extension ThemeWrapper where Base: UIView {
    /// 刷新当前控件的所有的主题配置属性
    func refresh() {
        ThemeManager.shared.refreshTargetObject(self.base)
    }
    var backgroundColor: ThemeProvider<UIColor>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupViewThemeProperty(view: self.base, key: "UIView.backgroundColor", provider: new) {[weak baseItem] (style) in
                baseItem?.backgroundColor = new?.provider(style)
            }
        }
        get { return self.base.providers["UIView.backgroundColor"] as? ThemeProvider<UIColor> }
    }
    var tintColor: ThemeProvider<UIColor>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupViewThemeProperty(view: self.base, key: "UIView.tintColor", provider: new) {[weak baseItem] (style) in
                baseItem?.tintColor = new?.provider(style)
            }
        }
        get { return self.base.providers["UIView.tintColor"] as? ThemeProvider<UIColor> }
    }
    var alpha: ThemeProvider<CGFloat>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupViewThemeProperty(view: self.base, key: "UIView.alpha", provider: new) {[weak baseItem] (style) in
                baseItem?.alpha = new?.provider(style) ?? 1
            }
        }
        get { return self.base.providers["UIView.alpha"] as? ThemeProvider<CGFloat> }
    }
    var customization: ThemeProvider<Void>? {
        set(new) {
            ThemeTool.setupViewThemeProperty(view: self.base, key: "UIView.customization", provider: new) { (style) in
                new?.provider(style)
            }
        }
        get { return self.base.providers["UIView.customization"] as? ThemeProvider<Void> }
    }
    var overrideThemeStyle: ThemeStyle? {
        set(new) {
            self.base.overrideThemeStyle = new
        }
        get { return self.base.overrideThemeStyle }
    }
}
public extension ThemeWrapper where Base: UILabel {
    var font: ThemeProvider<UIFont>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupViewThemeProperty(view: self.base, key: "UILabel.font", provider: new) {[weak baseItem] (style) in
                baseItem?.font = new?.provider(style)
            }
        }
        get { return self.base.providers["UILabel.font"] as? ThemeProvider<UIFont> }
    }
    var textColor: ThemeProvider<UIColor>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupViewThemeProperty(view: self.base, key: "UILabel.textColor", provider: new) {[weak baseItem] (style) in
                baseItem?.textColor = new?.provider(style)
            }
        }
        get { return self.base.providers["UILabel.textColor"] as? ThemeProvider<UIColor> }
    }
    var shadowColor: ThemeProvider<UIColor>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupViewThemeProperty(view: self.base, key: "UILabel.shadowColor", provider: new) {[weak baseItem] (style) in
                baseItem?.shadowColor = new?.provider(style)
            }
        }
        get { return self.base.providers["UILabel.shadowColor"] as? ThemeProvider<UIColor> }
    }
    var highlightedTextColor: ThemeProvider<UIColor>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupViewThemeProperty(view: self.base, key: "UILabel.highlightedTextColor", provider: new) {[weak baseItem] (style) in
                baseItem?.highlightedTextColor = new?.provider(style)
            }
        }
        get { return self.base.providers["UILabel.highlightedTextColor"] as? ThemeProvider<UIColor> }
    }
    var attributedText: ThemeProvider<NSAttributedString>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupViewThemeProperty(view: self.base, key: "UILabel.attributedText", provider: new) {[weak baseItem] (style) in
                baseItem?.attributedText = new?.provider(style)
            }
        }
        get { return self.base.providers["UILabel.attributedText"] as? ThemeProvider<NSAttributedString> }
    }
}

public extension ThemeWrapper where Base: UIButton {
    func setTitleColor(_ colorProvider: ThemeProvider<UIColor>?, for state: UIControl.State) {
        let baseItem = self.base
        ThemeTool.setupViewThemeProperty(view: self.base, key: "UIButton.titleColor.\(state.rawValue)", provider: colorProvider) {[weak baseItem] (style) in
            baseItem?.setTitleColor(colorProvider?.provider(style), for: state)
        }
    }
    func setTitleShadowColor(_ colorProvider: ThemeProvider<UIColor>?, for state: UIControl.State) {
        let baseItem = self.base
        ThemeTool.setupViewThemeProperty(view: self.base, key: "UIButton.titleShadowColor.\(state.rawValue)", provider: colorProvider) {[weak baseItem] (style) in
            baseItem?.setTitleShadowColor(colorProvider?.provider(style), for: state)
        }
    }
    func setAttributedTitle(_ textProvider: ThemeProvider<NSAttributedString>?, for state: UIControl.State) {
        let baseItem = self.base
        ThemeTool.setupViewThemeProperty(view: self.base, key: "UIButton.attributedTitle.\(state.rawValue)", provider: textProvider) {[weak baseItem] (style) in
            UIView.setAnimationsEnabled(false)
            baseItem?.setAttributedTitle(textProvider?.provider(style), for: state)
            baseItem?.layoutIfNeeded()
            UIView.setAnimationsEnabled(true)
        }
    }
    func setImage(_ imageProvider: ThemeProvider<UIImage>?, for state: UIControl.State) {
        let baseItem = self.base
        ThemeTool.setupViewThemeProperty(view: self.base, key: "UIButton.image.\(state.rawValue)", provider: imageProvider) {[weak baseItem] (style) in
            baseItem?.setImage(imageProvider?.provider(style), for: state)
        }
    }
    func setBackgroundImage(_ imageProvider: ThemeProvider<UIImage>?, for state: UIControl.State) {
        let baseItem = self.base
        ThemeTool.setupViewThemeProperty(view: self.base, key: "UIButton.backgroundImage.\(state.rawValue)", provider: imageProvider) {[weak baseItem] (style) in
            baseItem?.setBackgroundImage(imageProvider?.provider(style), for: state)
        }
    }
}
public extension ThemeWrapper where Base: UITextField {
    var font: ThemeProvider<UIFont>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupViewThemeProperty(view: self.base, key: "UITextField.font", provider: new) {[weak baseItem] (style) in
                baseItem?.font = new?.provider(style)
            }
        }
        get { return self.base.providers["UITextField.font"] as? ThemeProvider<UIFont> }
    }
    var textColor: ThemeProvider<UIColor>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupViewThemeProperty(view: self.base, key: "UITextField.textColor", provider: new) {[weak baseItem] (style) in
                baseItem?.textColor = new?.provider(style)
            }
        }
        get { return self.base.providers["UITextField.textColor"] as? ThemeProvider<UIColor> }
    }
    var attributedText: ThemeProvider<NSAttributedString>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupViewThemeProperty(view: self.base, key: "UITextField.attributedText", provider: new) {[weak baseItem] (style) in
                baseItem?.attributedText = new?.provider(style)
            }
        }
        get { return self.base.providers["UITextField.attributedText"] as? ThemeProvider<NSAttributedString> }
    }
    var attributedPlaceholder: ThemeProvider<NSAttributedString>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupViewThemeProperty(view: self.base, key: "UITextField.attributedPlaceholder", provider: new) {[weak baseItem] (style) in
                baseItem?.attributedPlaceholder = new?.provider(style)
            }
        }
        get { return self.base.providers["UITextField.attributedPlaceholder"] as? ThemeProvider<NSAttributedString> }
    }
    var keyboardAppearance: ThemeProvider<UIKeyboardAppearance>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupViewThemeProperty(view: self.base, key: "UITextField.keyboardAppearance", provider: new) {[weak baseItem] (style) in
                baseItem?.keyboardAppearance = new?.provider(style) ?? .default
            }
        }
        get { return self.base.providers["UITextField.keyboardAppearance"] as? ThemeProvider<UIKeyboardAppearance> }
    }
}
public extension ThemeWrapper where Base: UITextView {
    var font: ThemeProvider<UIFont>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupViewThemeProperty(view: self.base, key: "UITextView.font", provider: new) {[weak baseItem] (style) in
                baseItem?.font = new?.provider(style)
            }
        }
        get { return self.base.providers["UITextView.font"] as? ThemeProvider<UIFont> }
    }
    var textColor: ThemeProvider<UIColor>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupViewThemeProperty(view: self.base, key: "UITextView.textColor", provider: new) {[weak baseItem] (style) in
                baseItem?.textColor = new?.provider(style)
            }
        }
        get { return self.base.providers["UITextView.textColor"] as? ThemeProvider<UIColor> }
    }
    var attributedText: ThemeProvider<NSAttributedString>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupViewThemeProperty(view: self.base, key: "UITextView.attributedText", provider: new) {[weak baseItem] (style) in
                baseItem?.attributedText = new?.provider(style)
            }
        }
        get { return self.base.providers["UITextView.attributedText"] as? ThemeProvider<NSAttributedString> }
    }
    var keyboardAppearance: ThemeProvider<UIKeyboardAppearance>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupViewThemeProperty(view: self.base, key: "UITextView.keyboardAppearance", provider: new) {[weak baseItem] (style) in
                baseItem?.keyboardAppearance = new?.provider(style) ?? .default
            }
        }
        get { return self.base.providers["UITextView.keyboardAppearance"] as? ThemeProvider<UIKeyboardAppearance> }
    }
}
public extension ThemeWrapper where Base: UIImageView {
    var image: ThemeProvider<UIImage>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupViewThemeProperty(view: self.base, key: "UIImageView.image", provider: new) {[weak baseItem] (style) in
                baseItem?.image = new?.provider(style)
            }
        }
        get { return self.base.providers["UIImageView.image"] as? ThemeProvider<UIImage> }
    }
}
public extension ThemeWrapper where Base: CALayer {
    /// 刷新当前控件的所有的主题配置属性
    func refresh() {
        ThemeManager.shared.refreshTargetObject(self.base)
    }
    var overrideThemeStyle: ThemeStyle? {
        set(new) {
            self.base.overrideThemeStyle = new
        }
        get { return self.base.overrideThemeStyle }
    }
    var backgroundColor: ThemeProvider<UIColor>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupLayerThemeProperty(layer: self.base, key: "CALayer.backgroundColor", provider: new) {[weak baseItem] (style) in
                baseItem?.backgroundColor = new?.provider(style).cgColor
            }
        }
        get { return self.base.providers["CALayer.backgroundColor"] as? ThemeProvider<UIColor> }
    }
    var borderColor: ThemeProvider<UIColor>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupLayerThemeProperty(layer: self.base, key: "CALayer.borderColor", provider: new) {[weak baseItem] (style) in
                baseItem?.borderColor = new?.provider(style).cgColor
            }
        }
        get { return self.base.providers["CALayer.borderColor"] as? ThemeProvider<UIColor> }
    }
    var borderWidth: ThemeProvider<CGFloat>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupLayerThemeProperty(layer: self.base, key: "CALayer.borderWidth", provider: new) {[weak baseItem] (style) in
                baseItem?.borderWidth = new?.provider(style) ?? 0
            }
        }
        get { return self.base.providers["CALayer.borderWidth"] as? ThemeProvider<CGFloat> }
    }
    var shadowColor: ThemeProvider<UIColor>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupLayerThemeProperty(layer: self.base, key: "CALayer.shadowColor", provider: new) {[weak baseItem] (style) in
                baseItem?.shadowColor = new?.provider(style).cgColor
            }
        }
        get { return self.base.providers["CALayer.shadowColor"] as? ThemeProvider<UIColor> }
    }
    var customization: ThemeProvider<Void>? {
        set(new) {
            ThemeTool.setupLayerThemeProperty(layer: self.base, key: "CALayer.customization", provider: new) { (style) in
                new?.provider(style)
            }
        }
        get { return self.base.providers["CALayer.customization"] as? ThemeProvider<Void> }
    }
}
public extension ThemeWrapper where Base: CAShapeLayer {
    var fillColor: ThemeProvider<UIColor>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupLayerThemeProperty(layer: self.base, key: "CAShapeLayer.fillColor", provider: new) {[weak baseItem] (style) in
                baseItem?.fillColor = new?.provider(style).cgColor
            }
        }
        get { return self.base.providers["CAShapeLayer.fillColor"] as? ThemeProvider<UIColor> }
    }
    var strokeColor: ThemeProvider<UIColor>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupLayerThemeProperty(layer: self.base, key: "CAShapeLayer.strokeColor", provider: new) {[weak baseItem] (style) in
                baseItem?.strokeColor = new?.provider(style).cgColor
            }
        }
        get { return self.base.providers["CAShapeLayer.strokeColor"] as? ThemeProvider<UIColor> }
    }
}
public extension ThemeWrapper where Base: UINavigationBar {
    var barStyle: ThemeProvider<UIBarStyle>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupViewThemeProperty(view: self.base, key: "UINavigationBar.barStyle", provider: new) {[weak baseItem] (style) in
                baseItem?.barStyle = new?.provider(style) ?? .default
            }
        }
        get { return self.base.providers["UINavigationBar.barStyle"] as? ThemeProvider<UIBarStyle> }
    }
    var barTintColor: ThemeProvider<UIColor>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupViewThemeProperty(view: self.base, key: "UINavigationBar.barTintColor", provider: new) {[weak baseItem] (style) in
                baseItem?.barTintColor = new?.provider(style)
            }
        }
        get { return self.base.providers["UINavigationBar.barTintColor"] as? ThemeProvider<UIColor> }
    }
    var titleTextAttributes: ThemeProvider<[NSAttributedString.Key : Any]>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupViewThemeProperty(view: self.base, key: "UINavigationBar.titleTextAttributes", provider: new) {[weak baseItem] (style) in
                baseItem?.titleTextAttributes = new?.provider(style)
            }
        }
        get { return self.base.providers["UINavigationBar.titleTextAttributes"] as? ThemeProvider<[NSAttributedString.Key : Any]> }
    }
    @available(iOS 11.0, *)
    var largeTitleTextAttributes: ThemeProvider<[NSAttributedString.Key : Any]>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupViewThemeProperty(view: self.base, key: "UINavigationBar.largeTitleTextAttributes", provider: new) {[weak baseItem] (style) in
                baseItem?.largeTitleTextAttributes = new?.provider(style)
            }
        }
        get { return self.base.providers["UINavigationBar.largeTitleTextAttributes"] as? ThemeProvider<[NSAttributedString.Key : Any]> }
    }
}
public extension ThemeWrapper where Base: UITabBar {
    var barStyle: ThemeProvider<UIBarStyle>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupViewThemeProperty(view: self.base, key: "UITabBar.barStyle", provider: new) {[weak baseItem] (style) in
                baseItem?.barStyle = new?.provider(style) ?? .default
            }
        }
        get { return self.base.providers["UITabBar.barStyle"] as? ThemeProvider<UIBarStyle> }
    }
    var barTintColor: ThemeProvider<UIColor>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupViewThemeProperty(view: self.base, key: "UITabBar.barTintColor", provider: new) {[weak baseItem] (style) in
                baseItem?.barTintColor = new?.provider(style)
            }
        }
        get { return self.base.providers["UITabBar.barTintColor"] as? ThemeProvider<UIColor> }
    }
    var shadowImage: ThemeProvider<UIImage>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupViewThemeProperty(view: self.base, key: "UITabBar.shadowImage", provider: new) {[weak baseItem] (style) in
                baseItem?.shadowImage = new?.provider(style)
            }
        }
        get { return self.base.providers["UITabBar.shadowImage"] as? ThemeProvider<UIImage> }
    }
}
public extension ThemeWrapper where Base: UITabBarItem {
    var selectedImage: ThemeProvider<UIImage>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupBarItemThemeProperty(barItem: self.base, key: "UITabBarItem.selectedImage", provider: new) {[weak baseItem] (style) in
                baseItem?.selectedImage = new?.provider(style)
            }
        }
        get { return self.base.providers["UITabBarItem.selectedImage"] as? ThemeProvider<UIImage> }
    }
}
public extension ThemeWrapper where Base: UISearchBar {
    var barStyle: ThemeProvider<UIBarStyle>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupViewThemeProperty(view: self.base, key: "UISearchBar.barStyle", provider: new) {[weak baseItem] (style) in
                baseItem?.barStyle = new?.provider(style) ?? .default
            }
        }
        get { return self.base.providers["UISearchBar.barStyle"] as? ThemeProvider<UIBarStyle> }
    }
    var barTintColor: ThemeProvider<UIColor>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupViewThemeProperty(view: self.base, key: "UISearchBar.barTintColor", provider: new) {[weak baseItem] (style) in
                baseItem?.barTintColor = new?.provider(style)
            }
        }
        get { return self.base.providers["UISearchBar.barTintColor"] as? ThemeProvider<UIColor> }
    }
    var keyboardAppearance: ThemeProvider<UIKeyboardAppearance>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupViewThemeProperty(view: self.base, key: "UISearchBar.keyboardAppearance", provider: new) {[weak baseItem] (style) in
                baseItem?.keyboardAppearance = new?.provider(style) ?? .default
            }
        }
        get { return self.base.providers["UISearchBar.keyboardAppearance"] as? ThemeProvider<UIKeyboardAppearance> }
    }
}
public extension ThemeWrapper where Base: UIToolbar {
    var barStyle: ThemeProvider<UIBarStyle>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupViewThemeProperty(view: self.base, key: "UIToolbar.barStyle", provider: new) {[weak baseItem] (style) in
                baseItem?.barStyle = new?.provider(style) ?? .default
            }
        }
        get { return self.base.providers["UIToolbar.barStyle"] as? ThemeProvider<UIBarStyle> }
    }
    var barTintColor: ThemeProvider<UIColor>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupViewThemeProperty(view: self.base, key: "UIToolbar.barTintColor", provider: new) {[weak baseItem] (style) in
                baseItem?.barTintColor = new?.provider(style)
            }
        }
        get { return self.base.providers["UIToolbar.barTintColor"] as? ThemeProvider<UIColor> }
    }
}
public extension ThemeWrapper where Base: UISwitch {
    var onTintColor: ThemeProvider<UIColor>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupViewThemeProperty(view: self.base, key: "UISwitch.onTintColor", provider: new) {[weak baseItem] (style) in
                baseItem?.onTintColor = new?.provider(style)
            }
        }
        get { return self.base.providers["UISwitch.onTintColor"] as? ThemeProvider<UIColor> }
    }
    var thumbTintColor: ThemeProvider<UIColor>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupViewThemeProperty(view: self.base, key: "UISwitch.thumbTintColor", provider: new) {[weak baseItem] (style) in
                baseItem?.thumbTintColor = new?.provider(style)
            }
        }
        get { return self.base.providers["UISwitch.thumbTintColor"] as? ThemeProvider<UIColor> }
    }
}
public extension ThemeWrapper where Base: UISlider {
    var thumbTintColor: ThemeProvider<UIColor>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupViewThemeProperty(view: self.base, key: "UISlider.thumbTintColor", provider: new) {[weak baseItem] (style) in
                baseItem?.thumbTintColor = new?.provider(style)
            }
        }
        get { return self.base.providers["UISlider.thumbTintColor"] as? ThemeProvider<UIColor> }
    }
    var minimumTrackTintColor: ThemeProvider<UIColor>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupViewThemeProperty(view: self.base, key: "UISlider.minimumTrackTintColor", provider: new) {[weak baseItem] (style) in
                baseItem?.minimumTrackTintColor = new?.provider(style)
            }
        }
        get { return self.base.providers["UISlider.minimumTrackTintColor"] as? ThemeProvider<UIColor> }
    }
    var maximumTrackTintColor: ThemeProvider<UIColor>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupViewThemeProperty(view: self.base, key: "UISlider.maximumTrackTintColor", provider: new) {[weak baseItem] (style) in
                baseItem?.maximumTrackTintColor = new?.provider(style)
            }
        }
        get { return self.base.providers["UISlider.maximumTrackTintColor"] as? ThemeProvider<UIColor> }
    }
    var minimumValueImage: ThemeProvider<UIImage>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupViewThemeProperty(view: self.base, key: "UISlider.minimumValueImage", provider: new) {[weak baseItem] (style) in
                baseItem?.minimumValueImage = new?.provider(style)
            }
        }
        get { return self.base.providers["UISlider.minimumValueImage"] as? ThemeProvider<UIImage> }
    }
    var maximumValueImage: ThemeProvider<UIImage>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupViewThemeProperty(view: self.base, key: "UISlider.maximumValueImage", provider: new) {[weak baseItem] (style) in
                baseItem?.maximumValueImage = new?.provider(style)
            }
        }
        get { return self.base.providers["UISlider.maximumValueImage"] as? ThemeProvider<UIImage> }
    }
}
public extension ThemeWrapper where Base: UIRefreshControl {
    var attributedTitle: ThemeProvider<NSAttributedString>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupViewThemeProperty(view: self.base, key: "UIRefreshControl.attributedTitle", provider: new) {[weak baseItem] (style) in
                baseItem?.attributedTitle = new?.provider(style)
            }
        }
        get { return self.base.providers["UIRefreshControl.attributedTitle"] as? ThemeProvider<NSAttributedString> }
    }
}
public extension ThemeWrapper where Base: UIProgressView {
    var progressTintColor: ThemeProvider<UIColor>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupViewThemeProperty(view: self.base, key: "UIProgressView.progressTintColor", provider: new) {[weak baseItem] (style) in
                baseItem?.progressTintColor = new?.provider(style)
            }
        }
        get { return self.base.providers["UIProgressView.progressTintColor"] as? ThemeProvider<UIColor> }
    }
    var trackTintColor: ThemeProvider<UIColor>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupViewThemeProperty(view: self.base, key: "UIProgressView.trackTintColor", provider: new) {[weak baseItem] (style) in
                baseItem?.trackTintColor = new?.provider(style)
            }
        }
        get { return self.base.providers["UIProgressView.trackTintColor"] as? ThemeProvider<UIColor> }
    }
    var progressImage: ThemeProvider<UIImage>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupViewThemeProperty(view: self.base, key: "UIProgressView.progressImage", provider: new) {[weak baseItem] (style) in
                baseItem?.progressImage = new?.provider(style)
            }
        }
        get { return self.base.providers["UIProgressView.progressImage"] as? ThemeProvider<UIImage> }
    }
    var trackImage: ThemeProvider<UIImage>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupViewThemeProperty(view: self.base, key: "UIProgressView.trackImage", provider: new) {[weak baseItem] (style) in
                baseItem?.trackImage = new?.provider(style)
            }
        }
        get { return self.base.providers["UIProgressView.trackImage"] as? ThemeProvider<UIImage> }
    }
}
public extension ThemeWrapper where Base: UIPageControl {
    var pageIndicatorTintColor: ThemeProvider<UIColor>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupViewThemeProperty(view: self.base, key: "UIPageControl.pageIndicatorTintColor", provider: new) {[weak baseItem] (style) in
                baseItem?.pageIndicatorTintColor = new?.provider(style)
            }
        }
        get { return self.base.providers["UIPageControl.pageIndicatorTintColor"] as? ThemeProvider<UIColor> }
    }
    var currentPageIndicatorTintColor: ThemeProvider<UIColor>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupViewThemeProperty(view: self.base, key: "UIProgressView.currentPageIndicatorTintColor", provider: new) {[weak baseItem] (style) in
                baseItem?.currentPageIndicatorTintColor = new?.provider(style)
            }
        }
        get { return self.base.providers["UIProgressView.currentPageIndicatorTintColor"] as? ThemeProvider<UIColor> }
    }
}
public extension ThemeWrapper where Base: UIBarItem {
    /// 刷新当前控件的所有的主题配置属性
    func refresh() {
        ThemeManager.shared.refreshTargetObject(self.base)
    }
    var overrideThemeStyle: ThemeStyle? {
        set(new) {
            self.base.overrideThemeStyle = new
        }
        get { return self.base.overrideThemeStyle }
    }
    func setTitleTextAttributes(_ attributesProvider: ThemeProvider<[NSAttributedString.Key : Any]>?, for state: UIControl.State) {
        let baseItem = self.base
        ThemeTool.setupBarItemThemeProperty(barItem: self.base, key: "UIBarItem.setTitleTextAttributes", provider: attributesProvider) {[weak baseItem] (style) in
            baseItem?.setTitleTextAttributes(attributesProvider?.provider(style), for: state)
        }
    }
    var image: ThemeProvider<UIImage>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupBarItemThemeProperty(barItem: self.base, key: "UIBarItem.image", provider: new) {[weak baseItem] (style) in
                baseItem?.image = new?.provider(style)
            }
        }
        get { return self.base.providers["UIBarItem.image"] as? ThemeProvider<UIImage> }
    }
}
public extension ThemeWrapper where Base: UIBarButtonItem {
    var tintColor: ThemeProvider<UIColor>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupBarItemThemeProperty(barItem: self.base, key: "UIBarButtonItem.tintColor", provider: new) {[weak baseItem] (style) in
                baseItem?.tintColor = new?.provider(style)
            }
        }
        get { return self.base.providers["UIBarButtonItem.tintColor"] as? ThemeProvider<UIColor> }
    }
}
public extension ThemeWrapper where Base: UIActivityIndicatorView {
    var style: ThemeProvider<UIActivityIndicatorView.Style>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupViewThemeProperty(view: self.base, key: "UIActivityIndicatorView.style", provider: new) {[weak baseItem] (style) in
                baseItem?.style = new?.provider(style) ?? UIActivityIndicatorView.Style.gray
            }
        }
        get { return self.base.providers["UIActivityIndicatorView.style"] as? ThemeProvider<UIActivityIndicatorView.Style> }
    }
    var color: ThemeProvider<UIColor>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupViewThemeProperty(view: self.base, key: "UIActivityIndicatorView.color", provider: new) {[weak baseItem] (style) in
                baseItem?.color = new?.provider(style)
            }
        }
        get { return self.base.providers["UIActivityIndicatorView.color"] as? ThemeProvider<UIColor> }
    }
}
public extension ThemeWrapper where Base: UIScrollView {
    var indicatorStyle: ThemeProvider<UIScrollView.IndicatorStyle>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupViewThemeProperty(view: self.base, key: "UIScrollView.indicatorStyle", provider: new) {[weak baseItem] (style) in
                baseItem?.indicatorStyle = new?.provider(style) ?? UIScrollView.IndicatorStyle.default
            }
        }
        get { return self.base.providers["UIScrollView.indicatorStyle"] as? ThemeProvider<UIScrollView.IndicatorStyle> }
    }
}
public extension ThemeWrapper where Base: UITableView {
    var separatorColor: ThemeProvider<UIColor>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupViewThemeProperty(view: self.base, key: "UITableView.separatorColor", provider: new) {[weak baseItem] (style) in
                baseItem?.separatorColor = new?.provider(style)
            }
        }
        get { return self.base.providers["UITableView.separatorColor"] as? ThemeProvider<UIColor> }
    }
    var sectionIndexColor: ThemeProvider<UIColor>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupViewThemeProperty(view: self.base, key: "UITableView.sectionIndexColor", provider: new) {[weak baseItem] (style) in
                baseItem?.sectionIndexColor = new?.provider(style)
            }
        }
        get { return self.base.providers["UITableView.sectionIndexColor"] as? ThemeProvider<UIColor> }
    }
    var sectionIndexBackgroundColor: ThemeProvider<UIColor>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupViewThemeProperty(view: self.base, key: "UITableView.sectionIndexBackgroundColor", provider: new) {[weak baseItem] (style) in
                baseItem?.sectionIndexBackgroundColor = new?.provider(style)
            }
        }
        get { return self.base.providers["UITableView.sectionIndexBackgroundColor"] as? ThemeProvider<UIColor> }
    }
}

//MARK: - Extentsion Property
internal extension UIView {
    struct AssociatedKey {
        static var providers: Void?
        static var overrideThemeStyle: Void?
    }
    var providers: [String: Any] {
        set(new) {
            objc_setAssociatedObject(self, &AssociatedKey.providers, new, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            if objc_getAssociatedObject(self, &AssociatedKey.providers) == nil {
                self.providers = [String: Any]()
            }
            return objc_getAssociatedObject(self, &AssociatedKey.providers) as! [String: Any]
        }
    }
    var overrideThemeStyle: ThemeStyle? {
        set(new) {
            objc_setAssociatedObject(self, &AssociatedKey.overrideThemeStyle, new, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            subviews.forEach { $0.overrideThemeStyle = self.overrideThemeStyle }
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.overrideThemeStyle) as? ThemeStyle
        }
    }
}
internal extension CALayer {
    struct AssociatedKey {
        static var providers: Void?
        static var overrideThemeStyle: Void?
    }
    var providers: [String: Any] {
        set(new) {
            objc_setAssociatedObject(self, &AssociatedKey.providers, new, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            if objc_getAssociatedObject(self, &AssociatedKey.providers) == nil {
                self.providers = [String: Any]()
            }
            return objc_getAssociatedObject(self, &AssociatedKey.providers) as! [String: Any]
        }
    }
    var overrideThemeStyle: ThemeStyle? {
        set(new) {
            objc_setAssociatedObject(self, &AssociatedKey.overrideThemeStyle, new, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            sublayers?.forEach { $0.overrideThemeStyle = self.overrideThemeStyle }
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.overrideThemeStyle) as? ThemeStyle
        }
    }
}
internal extension UIBarItem {
    struct AssociatedKey {
        static var providers: Void?
        static var overrideThemeStyle: Void?
    }
    var providers: [String: Any] {
        set(new) {
            objc_setAssociatedObject(self, &AssociatedKey.providers, new, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            if objc_getAssociatedObject(self, &AssociatedKey.providers) == nil {
                self.providers = [String: Any]()
            }
            return objc_getAssociatedObject(self, &AssociatedKey.providers) as! [String: Any]
        }
    }
    var overrideThemeStyle: ThemeStyle? {
        set(new) {
            objc_setAssociatedObject(self, &AssociatedKey.overrideThemeStyle, new, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.overrideThemeStyle) as? ThemeStyle
        }
    }
}

//MARK: - Swizzle
func swizzleMethod(_ aClass: AnyClass, originalSelector: Selector, swizzledSelector: Selector) {
    if let originalMethod = class_getInstanceMethod(aClass, originalSelector),
        let swizzledMehod = class_getInstanceMethod(aClass, swizzledSelector) {
        let didAddMethod: Bool = class_addMethod(aClass, originalSelector, method_getImplementation(swizzledMehod), method_getTypeEncoding(swizzledMehod))
        if didAddMethod {
            class_replaceMethod(aClass, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
        }else {
            method_exchangeImplementations(originalMethod, swizzledMehod)
        }
    }
}

extension UIView {
    static let swizzleAddSubview: Void = {
        swizzleMethod(UIView.self, originalSelector: #selector(addSubview(_:)), swizzledSelector: #selector(swizzledAddSubview(_:)))
    }()

    @objc func swizzledAddSubview(_ subview: UIView) {
        swizzledAddSubview(subview)
        if overrideThemeStyle != nil {
            subview.overrideThemeStyle = overrideThemeStyle
        }
    }
}

extension CALayer {
    static let swizzleAddSublayer: Void = {
        swizzleMethod(CALayer.self, originalSelector: #selector(addSublayer(_:)), swizzledSelector: #selector(swizzledAddSublayer(_:)))
    }()

    @objc func swizzledAddSublayer(_ sublayer: CALayer) {
        swizzledAddSublayer(sublayer)
        if overrideThemeStyle != nil {
            sublayer.overrideThemeStyle = overrideThemeStyle
        }
    }
}
