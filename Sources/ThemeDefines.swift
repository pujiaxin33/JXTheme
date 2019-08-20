//
//  ThemeDefines.swift
//  JXTheme
//
//  Created by jiaxin on 2019/7/10.
//  Copyright © 2019 jiaxin. All rights reserved.
//

import Foundation
import UIKit

//MARK: - ThemeCompatible
public protocol ThemeCompatible: AnyObject { }
public extension ThemeCompatible {
    var theme: ThemeWrapper<Self> {
        get { return ThemeWrapper<Self>(self) }
        set { }
    }
}
extension UIView: ThemeCompatible { }
extension CALayer: ThemeCompatible { }
extension UIBarItem: ThemeCompatible { }

//MARK: - ThemeWrapper
public struct ThemeWrapper<Base> {
    let base: Base
    init(_ base: Base) {
        self.base = base
    }
}

//MARK: - Defines
public struct ThemeStyle: RawRepresentable, Equatable, Hashable, Comparable {
    public typealias RawValue = String
    public var rawValue: String
    public var hashValue: Int { return rawValue.hashValue }
    public static let unspecified = ThemeStyle(rawValue: "unspecified")

    public init(rawValue: String) {
        self.rawValue = rawValue
    }

    public static func <(lhs: ThemeStyle, rhs: ThemeStyle) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
    public static func == (lhs: ThemeStyle, rhs: ThemeStyle) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}

public struct ThemeProvider<T> {
    var provider: ThemePropertyProvider<T>
    var config: ThemeCustomizationClosure?
    public init(_ provider: @escaping ThemePropertyProvider<T>) {
        self.provider = provider
    }
    /// Refresh theme value with style.The default value is `.unspecified` that's say use `ThemeManager.shared.currentThemeStyle`.
    ///
    /// - Parameter style: ThemeStyle
    public func refresh(style: ThemeStyle = .unspecified) {
        if style == .unspecified {
            config?(ThemeManager.shared.currentThemeStyle)
        }else {
            config?(style)
        }
    }
}

public typealias ThemePropertyProvider<T> = (ThemeStyle) -> T
internal typealias ThemeCustomizationClosure = (ThemeStyle) -> ()



