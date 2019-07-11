//
//  Extensions.swift
//  JXTheme
//
//  Created by jiaxin on 2019/7/10.
//  Copyright © 2019 jiaxin. All rights reserved.
//

import Foundation
import UIKit

// [JXTheme.DynamicColor colorSpaceName]: unrecognized selector sent to instance  系统内部属性未实现，我怎么知道系统内部还依赖多少未知属性哈，感觉subclass UIColor就是个巨坑啊！！！
public class DynamicColor: UIColor {
    var dynamicProvider: ThemeColorDynamicProvider?
    private var innerColor: UIColor {
        return UIColor.red
    }
    public convenience init(dynamicProvider: @escaping ThemeColorDynamicProvider) {
        self.init()
        self.dynamicProvider = dynamicProvider
    }
    @objc(CGColor) override public var cgColor: CGColor { return innerColor.cgColor }
    @objc(CIColor) override public var ciColor: CIColor { return innerColor.ciColor }
    @objc override public func set() { innerColor.set() }
    @objc override public func setFill() { innerColor.setFill() }
    @objc override public func setStroke() { innerColor.setStroke() }
    @objc override public func getWhite(_ white: UnsafeMutablePointer<CGFloat>?, alpha: UnsafeMutablePointer<CGFloat>?) -> Bool {
        return innerColor.getWhite(white, alpha: alpha)
    }
    @objc override public func getHue(_ hue: UnsafeMutablePointer<CGFloat>?, saturation: UnsafeMutablePointer<CGFloat>?, brightness: UnsafeMutablePointer<CGFloat>?, alpha: UnsafeMutablePointer<CGFloat>?) -> Bool {
        return innerColor.getHue(hue, saturation: saturation, brightness: brightness, alpha: alpha)
    }
    @objc override public func getRed(_ red: UnsafeMutablePointer<CGFloat>?, green: UnsafeMutablePointer<CGFloat>?, blue: UnsafeMutablePointer<CGFloat>?, alpha: UnsafeMutablePointer<CGFloat>?) -> Bool {
        return innerColor.getRed(red, green: green, blue: blue, alpha: alpha)
    }
    @objc(colorWithAlphaComponent:)
    override public func withAlphaComponent(_ alpha: CGFloat) -> UIColor {
        return innerColor.withAlphaComponent(alpha)
    }
}

//为什么不用下面的extension的方式呢？
//UIColor内部有缓存机制，相同参数的配置，会返回同一个值。猜测原因是，UIColor是对颜色的表述，且数据量较大，每次都初始化，很消耗性能。
//所以外部调用extension的初始器，得到的是同一个变量，这样就不会针对性保存ThemeColorDynamicProvider了
//public extension UIColor {
//    struct AssociatedKey {
//        static var dynamicColor: Void?
//    }
//    convenience init(dynamicColor: @escaping ThemeColorDynamicProvider) {
//        self.init(red: 1/255, green: 2/255, blue: 3/255, alpha: 4/255)
//        self.dynamicColor = dynamicColor
//    }
//
//    internal var dynamicColor: ThemeColorDynamicProvider? {
//        set(new) {
//            objc_setAssociatedObject(self, &AssociatedKey.dynamicColor, new, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//        }
//        get {
//            return objc_getAssociatedObject(self, &AssociatedKey.dynamicColor) as? ThemeColorDynamicProvider
//        }
//    }
//}

//MARK: - Extentsion Property
public extension UIView {
    struct AssociatedKey {
        static var themeConfigs: Void?
    }

    var themeConfigs: [ThemeConfigClosure] {
        set(new) {
            objc_setAssociatedObject(self, &AssociatedKey.themeConfigs, new, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            if objc_getAssociatedObject(self, &AssociatedKey.themeConfigs) as? [ThemeConfigClosure] == nil {
                self.themeConfigs = [ThemeConfigClosure]()
            }
            return objc_getAssociatedObject(self, &AssociatedKey.themeConfigs) as! [ThemeConfigClosure]
        }
    }

    static let swizzleBackgoundColor: Void = {
        let aClass: AnyClass! = object_getClass(UIView())
        let originalMethod = class_getInstanceMethod(aClass, #selector(setter: UIView.backgroundColor))
        let newMehod = class_getInstanceMethod(aClass, #selector(swizzledSetBackgroundColor(_:)))
        if let originalMethod = originalMethod, let newMehod = newMehod {
            method_exchangeImplementations(originalMethod, newMehod)
        }
    }()

    @objc func swizzledSetBackgroundColor(_ color: UIColor?) {
        guard let dynamicColor = color as? DynamicColor else {
            swizzledSetBackgroundColor(color)
            return
        }
        if dynamicColor.dynamicProvider != nil {
            swizzledSetBackgroundColor(dynamicColor.dynamicProvider?(ThemeManager.shared.currentThemeStyle))
            let config: ThemeConfigClosure = {[weak self] (style) in
                self?.swizzledSetBackgroundColor(dynamicColor.dynamicProvider?(ThemeManager.shared.currentThemeStyle))
            }
            themeConfigs.append(config)
            ThemeManager.shared.trackedHashTable.add(self)
        }
    }
}

func convertAttributedText(_ attributedText: NSAttributedString, in style: ThemeStyle) -> NSAttributedString {
    let resultText = NSMutableAttributedString()
    attributedText.enumerateAttributes(in: NSRange(location: 0, length: attributedText.string.count)) { (dict, range, point) in
        dict.forEach { (key, value) in
            if key == .foregroundColor {
                if let dynamicColor = value as? DynamicColor, let provider = dynamicColor.dynamicProvider {
                    resultText.addAttribute(key, value: provider(style), range: range)
                }else {
                    resultText.addAttribute(key, value: value, range: range)
                }
            }else {
                resultText.addAttribute(key, value: value, range: range)
            }
        }
    }
    return resultText
}

public extension UILabel {
    struct AssociatedKey {
        static var textColor: Void?
        static var attributedText: Void?
    }

    static let swizzleTextColor: Void = {
        let aClass: AnyClass! = object_getClass(UILabel())
        let originalMethod = class_getInstanceMethod(aClass, #selector(setter: UILabel.textColor))
        let newMehod = class_getInstanceMethod(aClass, #selector(swizzledSetTextColor(_:)))
        if let originalMethod = originalMethod, let newMehod = newMehod {
            method_exchangeImplementations(originalMethod, newMehod)
        }

    }()
    static let swizzleAttributedText: Void = {
        let aClass: AnyClass! = object_getClass(UILabel())
        let originalMethod = class_getInstanceMethod(aClass, #selector(setter: UILabel.attributedText))
        let newMehod = class_getInstanceMethod(aClass, #selector(swizzledSetAttributedText(_:)))
        if let originalMethod = originalMethod, let newMehod = newMehod {
            method_exchangeImplementations(originalMethod, newMehod)
        }
    }()

    @objc func swizzledSetTextColor(_ color: UIColor?) {
        guard let dynamicColor = color as? DynamicColor else {
            swizzledSetBackgroundColor(color)
            return
        }
        if dynamicColor.dynamicProvider != nil {
            swizzledSetTextColor(dynamicColor.dynamicProvider?(ThemeManager.shared.currentThemeStyle))
            let config: ThemeConfigClosure = {[weak self] (style) in
                self?.swizzledSetTextColor(dynamicColor.dynamicProvider?(ThemeManager.shared.currentThemeStyle))
            }
            themeConfigs.append(config)
            ThemeManager.shared.trackedHashTable.add(self)
        }else {
            swizzledSetTextColor(color)
        }
    }

    @objc func swizzledSetAttributedText(_ text: NSAttributedString?) {
        //如果当前的attributes没有DynamicColor，就调用原生实现
//        let darkAttributedText = text.mutableCopy() as! NSMutableAttributedString
        guard let attributedText = text else {
            swizzledSetAttributedText(text)
            return
        }
        var hasDynamicColor = false
        attributedText.enumerateAttributes(in: NSRange(location: 0, length: attributedText.string.count)) { (dict, range, stop) in
            for (key, value) in dict {
                if key == .foregroundColor {
                    if let _ = value as? DynamicColor {
                        hasDynamicColor = true
                        stop.pointee = true
                    }
                }
            }
        }
        if hasDynamicColor {
            swizzledSetAttributedText(convertAttributedText(attributedText, in: ThemeManager.shared.currentThemeStyle))
        }else {
            swizzledSetAttributedText(attributedText)
        }
    }

    //    var dynamicAttributedText: ThemeAttributedTextDynamicProvider? {
    //        set(new) {
    //            objc_setAssociatedObject(self, &AssociatedKey.attributedText, new, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    //            if new != nil {
    //                attributedText = new?(ThemeManager.shared.currentThemeStyle)
    //                ThemeManager.shared.trackedHashTable.add(self)
    //            }
    //        }
    //        get {
    //            return objc_getAssociatedObject(self, &AssociatedKey.attributedText) as? ThemeAttributedTextDynamicProvider
    //        }
    //    }
}

internal extension UITextField {
    struct AssociatedKey {
        static var textColor: Void?
        static var attributedText: Void?
    }
//    var dynamicTextColor: ThemeColorDynamicProvider? {
//        set(new) {
//            objc_setAssociatedObject(self, &AssociatedKey.textColor, new, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//            if new != nil {
//                textColor = new?(ThemeManager.shared.currentThemeStyle)
//                ThemeManager.shared.trackedHashTable.add(self)
//            }
//        }
//        get {
//            return objc_getAssociatedObject(self, &AssociatedKey.textColor) as? ThemeColorDynamicProvider
//        }
//    }
//    var dynamicAttributedText: ThemeAttributedTextDynamicProvider? {
//        set(new) {
//            objc_setAssociatedObject(self, &AssociatedKey.attributedText, new, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//            if new != nil {
//                attributedText = new?(ThemeManager.shared.currentThemeStyle)
//                ThemeManager.shared.trackedHashTable.add(self)
//            }
//        }
//        get {
//            return objc_getAssociatedObject(self, &AssociatedKey.attributedText) as? ThemeAttributedTextDynamicProvider
//        }
//    }
}

internal extension UITextView {
    struct AssociatedKey {
        static var textColor: Void?
        static var attributedText: Void?
    }
//    var dynamicTextColor: ThemeColorDynamicProvider? {
//        set(new) {
//            objc_setAssociatedObject(self, &AssociatedKey.textColor, new, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//            if new != nil {
//                textColor = new?(ThemeManager.shared.currentThemeStyle)
//                ThemeManager.shared.trackedHashTable.add(self)
//            }
//        }
//        get {
//            return objc_getAssociatedObject(self, &AssociatedKey.textColor) as? ThemeColorDynamicProvider
//        }
//    }
//    var dynamicAttributedText: ThemeAttributedTextDynamicProvider? {
//        set(new) {
//            objc_setAssociatedObject(self, &AssociatedKey.attributedText, new, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//            if new != nil {
//                attributedText = new?(ThemeManager.shared.currentThemeStyle)
//                ThemeManager.shared.trackedHashTable.add(self)
//            }
//        }
//        get {
//            return objc_getAssociatedObject(self, &AssociatedKey.attributedText) as? ThemeAttributedTextDynamicProvider
//        }
//    }
}

internal extension UIImageView {
    struct AssociatedKey {
        static var image: Void?
    }
//    var dynamicImage: ThemeImageDynamicProvider? {
//        set(new) {
//            objc_setAssociatedObject(self, &AssociatedKey.image, new, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//            if new != nil {
//                image = new?(ThemeManager.shared.currentThemeStyle)
//                ThemeManager.shared.trackedHashTable.add(self)
//            }
//        }
//        get {
//            return objc_getAssociatedObject(self, &AssociatedKey.image) as? ThemeImageDynamicProvider
//        }
//    }
}

internal extension CALayer {
    struct AssociatedKey {
        static var themeConfigs: Void?
    }

    var themeConfigs: [ThemeConfigClosure] {
        set(new) {
            objc_setAssociatedObject(self, &AssociatedKey.themeConfigs, new, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            if objc_getAssociatedObject(self, &AssociatedKey.themeConfigs) as? [ThemeConfigClosure] == nil {
                self.themeConfigs = [ThemeConfigClosure]()
            }
            return objc_getAssociatedObject(self, &AssociatedKey.themeConfigs) as! [ThemeConfigClosure]
        }
    }

    static let swizzleBackgoundColor: Void = {
        let aClass: AnyClass! = object_getClass(UIView())
        let originalMethod = class_getInstanceMethod(aClass, #selector(setter: UIView.backgroundColor))
        let newMehod = class_getInstanceMethod(aClass, #selector(swizzledSetBackgroundColor(_:)))
        if let originalMethod = originalMethod, let newMehod = newMehod {
            method_exchangeImplementations(originalMethod, newMehod)
        }
    }()

    @objc func swizzledSetBackgroundColor(_ color: UIColor?) {
        guard let dynamicColor = color as? DynamicColor else {
            swizzledSetBackgroundColor(color)
            return
        }
        if dynamicColor.dynamicProvider != nil {
            swizzledSetBackgroundColor(dynamicColor.dynamicProvider?(ThemeManager.shared.currentThemeStyle))
            let config: ThemeConfigClosure = {[weak self] (style) in
                self?.swizzledSetBackgroundColor(dynamicColor.dynamicProvider?(style))
            }
            themeConfigs.append(config)
            ThemeManager.shared.trackedHashTable.add(self)
        }else {
            swizzledSetBackgroundColor(color)
        }
    }
}
