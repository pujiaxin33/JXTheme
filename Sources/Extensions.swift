//
//  Extensions.swift
//  JXTheme
//
//  Created by jiaxin on 2019/7/10.
//  Copyright © 2019 jiaxin. All rights reserved.
//

import Foundation

//MARK: - ThemeWapper
public extension ThemeWapper where Base: UIView {
    var backgroundColor: ThemeColorDynamicProvider? {
        set(new) {
            self.base.dynamicBackgroundColor = new
        }
        get {
            return self.base.dynamicBackgroundColor
        }
    }
    var customization: ThemeCustomizationClosure? {
        set(new) {
            self.base.themeCustomization = new
        }
        get {
            return self.base.themeCustomization
        }
    }
}
public extension ThemeWapper where Base: UILabel {
    var textColor: ThemeColorDynamicProvider? {
        set(new) {
            self.base.dynamicTextColor = new
        }
        get {
            return self.base.dynamicTextColor
        }
    }
    //    var attributedText: NSAttributedString? {
    //
    //    }
}
//TODO:attributeString
public extension ThemeWapper where Base: UITextField {
    var textColor: ThemeColorDynamicProvider? {
        set(new) {
            self.base.dynamicTextColor = new
        }
        get {
            return self.base.dynamicTextColor
        }
    }
}
public extension ThemeWapper where Base: UITextView {
    var textColor: ThemeColorDynamicProvider? {
        set(new) {
            self.base.dynamicTextColor = new
        }
        get {
            return self.base.dynamicTextColor
        }
    }
}
public extension ThemeWapper where Base: UIImageView {
    var image: ThemeImageDynamicProvider? {
        set(new) {
            self.base.dynamicImage = new
        }
        get {
            return self.base.dynamicImage
        }
    }
}
public extension ThemeWapper where Base: CALayer {
    var backgroundColor: ThemeColorDynamicProvider? {
        set(new) {
            self.base.dynamicBackgroundColor = new
        }
        get {
            return self.base.dynamicBackgroundColor
        }
    }
    var customization: ThemeCustomizationClosure? {
        set(new) {
            self.base.themeCustomization = new
        }
        get {
            return self.base.themeCustomization
        }
    }
}

//MARK: - ThemeCustomizable
extension UIView: ThemeCustomizable {
    struct CustomizationAssociatedKey {
        static var customization = "kDynamicCustomization"
    }
    var themeCustomization: ThemeCustomizationClosure? {
        set(new) {
            objc_setAssociatedObject(self, &CustomizationAssociatedKey.customization, new, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if new != nil {
                new?(ThemeManager.shared.currentThemeStyle)
                ThemeManager.shared.viewsHashTable.add(self)
            }
        }
        get {
            return objc_getAssociatedObject(self, &CustomizationAssociatedKey.customization) as? ThemeCustomizationClosure
        }
    }
}

extension CALayer: ThemeCustomizable {
    struct CustomizationAssociatedKey {
        static var customization = "kDynamicCustomization"
    }
    var themeCustomization: ThemeCustomizationClosure? {
        set(new) {
            objc_setAssociatedObject(self, &CustomizationAssociatedKey.customization, new, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if new != nil {
                new?(ThemeManager.shared.currentThemeStyle)
                ThemeManager.shared.viewsHashTable.add(self)
            }
        }
        get {
            return objc_getAssociatedObject(self, &CustomizationAssociatedKey.customization) as? ThemeCustomizationClosure
        }
    }
}

//MARK: - Extentsion Property
internal extension UIView {
    struct AssociatedKey {
        static var backgroundColor = "kDynamicBackgroundColor"
    }
    var dynamicBackgroundColor: ThemeColorDynamicProvider? {
        set(new) {
            objc_setAssociatedObject(self, &AssociatedKey.backgroundColor, new, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if new != nil {
                backgroundColor = new?(ThemeManager.shared.currentThemeStyle)
                ThemeManager.shared.viewsHashTable.add(self)
            }
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.backgroundColor) as? ThemeColorDynamicProvider
        }
    }
}

internal extension UILabel {
    struct AssociatedKey {
        static var textColor = "kDynamicTextColor"
    }
    var dynamicTextColor: ThemeColorDynamicProvider? {
        set(new) {
            objc_setAssociatedObject(self, &AssociatedKey.textColor, new, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if new != nil {
                textColor = new?(ThemeManager.shared.currentThemeStyle)
                ThemeManager.shared.viewsHashTable.add(self)
            }
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.textColor) as? ThemeColorDynamicProvider
        }
    }
}

internal extension UITextField {
    struct AssociatedKey {
        static var textColor = "kDynamicTextColor"
    }
    var dynamicTextColor: ThemeColorDynamicProvider? {
        set(new) {
            objc_setAssociatedObject(self, &AssociatedKey.textColor, new, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if new != nil {
                textColor = new?(ThemeManager.shared.currentThemeStyle)
                ThemeManager.shared.viewsHashTable.add(self)
            }
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.textColor) as? ThemeColorDynamicProvider
        }
    }
}

internal extension UITextView {
    struct AssociatedKey {
        static var textColor = "kDynamicTextColor"
    }
    var dynamicTextColor: ThemeColorDynamicProvider? {
        set(new) {
            objc_setAssociatedObject(self, &AssociatedKey.textColor, new, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if new != nil {
                textColor = new?(ThemeManager.shared.currentThemeStyle)
                ThemeManager.shared.viewsHashTable.add(self)
            }
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.textColor) as? ThemeColorDynamicProvider
        }
    }
}

internal extension UIImageView {
    struct AssociatedKey {
        static var image = "kDynamicImage"
    }
    var dynamicImage: ThemeImageDynamicProvider? {
        set(new) {
            objc_setAssociatedObject(self, &AssociatedKey.image, new, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if new != nil {
                image = new?(ThemeManager.shared.currentThemeStyle)
                ThemeManager.shared.viewsHashTable.add(self)
            }
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.image) as? ThemeImageDynamicProvider
        }
    }
}

internal extension CALayer {
    struct AssociatedKey {
        static var backgroundColor = "kDynamicBackgroundColor"
    }
    var dynamicBackgroundColor: ThemeColorDynamicProvider? {
        set(new) {
            objc_setAssociatedObject(self, &AssociatedKey.backgroundColor, new, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if new != nil {
                backgroundColor = new?(ThemeManager.shared.currentThemeStyle).cgColor
                ThemeManager.shared.viewsHashTable.add(self)
            }
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKey.backgroundColor) as? ThemeColorDynamicProvider
        }
    }
}
