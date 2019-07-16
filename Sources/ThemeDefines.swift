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
    var theme: ThemeWapper<Self> {
        get { return ThemeWapper<Self>(self) }
        set { }
    }
}
extension UIView: ThemeCompatible { }
extension CALayer: ThemeCompatible { }
extension UIBarItem: ThemeCompatible { }

//MARK: - ThemeWapper
public struct ThemeWapper<Base> {
    let base: Base
    init(_ base: Base) {
        self.base = base
    }
}

//MARK: - Defines
/// 为了便于外部自定义style，使用了struct类型。如果使用枚举类型，外部就无法自定义扩展了。
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
    /// 根据传入的style直接触发主题属性的刷新。默认值unspecified表示用ThemeManager.shared.currentThemeStyle刷新，否则用传入的style刷新。
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



