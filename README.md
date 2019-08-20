
<div align=center><img width="468" height="90" src="https://github.com/pujiaxin33/JXTheme/blob/master/GIF/JXTheme.png"/></div>

[中文文档](https://github.com/pujiaxin33/JXTheme/blob/master/README-CN.md)

JXTheme is a lightweight library for theme properties configuration. In order to achieve the theme switching, the following five problems are mainly solved:
## 1. How to elegantly set theme properties
By extending the namespace property `theme` to the control, similar to the `snp` of `SnapKit` and the `kf` of `Kingfisher`, you can concentrate the properties that support the theme modification to the `theme` property. This is more elegant than directly extending the property 'theme_backgroundColor` to the control.
The core code is as follows:
```Swift
view.theme.backgroundColor = ThemeProvider({ (style) in
    If style == .dark {
        Return .white
    }else {
        Return .black
    }
})
```

## 2. How to configure the corresponding value according to the incoming style
Reference the iOS13 system API `UIColor(dynamicProvider: <UITraitCollection) -> UIColor>)`. Customize the `ThemeProvider` structure, the initializer is `init(_ provider: @escaping ThemePropertyProvider<T>)`. The passed argument `ThemePropertyProvider` is a closure defined as: `typealias ThemePropertyProvider<T> = (ThemeStyle) -> T`. This allows for maximum customization of different controls and different attribute configurations.
The core code refers to the first step sample code.

## 3. How to save the theme properties configuration closure
Add the `Associated object` property `providers` to the control to store `ThemeProvider`.
The core code is as follows:
```Swift
Public extension ThemeWrapper where Base: UIView {
    Var backgroundColor: ThemeProvider<UIColor>? {
        Set(new) {
            If new != nil {
                Let baseItem = self.base
                Let config: ThemeCustomizationClosure = {[weak baseItem] (style) in
                    baseItem?.backgroundColor = new?.provider(style)
                }
                / / Stored in the extended properties provider
                Var newProvider = new
                newProvider?.config = config
                Self.base.providers["UIView.backgroundColor"] = newProvider
                ThemeManager.shared.addTrackedObject(self.base, addedConfig: config)
            }else {
                self.base.configs.removeValue(forKey: "UIView.backgroundColor")
            }
        }
        Get { return self.base.providers["UIView.backgroundColor"] as? ThemeProvider<UIColor> }
    }
}
```

## 4. How to track controls that support theme properties
In order to switch to the theme, notify the control that supports the theme property configuration. By tracking the target control when setting the theme properties.
The core code is the code in step 3:
```Swift
ThemeManager.shared.addTrackedObject(self.base, addedConfig: config)
```

## 5. How to switch the theme and call the closure of theme property
The theme is switched by `ThemeManager.changeTheme(to: style)`, and the method internally calls the `ThemeProvider.provider` theme property in the `providers` of the tracked control to configure the closure.
The core code is as follows:
```Swift
Public func changeTheme(to style: ThemeStyle) {
    currentThemeStyle = style
    self.trackedHashTable.allObjects.forEach { (object) in
        If let view = object as? UIView {
            view.providers.values.forEach { self.resolveProvider($0) }
        }
    }
}
Private func resolveProvider(_ object: Any) {
    //castdown generic
    If let provider = object as? ThemeProvider<UIColor> {
        Provider.config?(currentThemeStyle)
    }else ...
}
```

# Feature

- [x] Support for iOS 9+, let your app implement `DarkMode` earlier;
- [x] Use the `theme` namespace attribute: `view.theme.xx = xx`. Say goodbye to the `theme_xx` attribute extension usage;
- [x] `ThemeStyle` can be customized by `extension`, no longer limited to `light` and `dark`;
- [x] provides the `customization` attribute as a callback entry for theme switching, with the flexibility to configure any property. It is no longer limited to the provided attributes such as `backgroundColor` and `textColor`;
- [x] supports the control setting `overrideThemeStyle`, which affects its child views;

# Preview
![preview](https://github.com/pujiaxin33/JXTheme/blob/master/GIF/preview.gif)

# Requirements

- iOS 9.0+
- XCode 10.2.1+
- Swift 5.0+

# Install

## Manual

Clone code, drag the Sources folder into the project, you can use it;

## CocoaPods

```ruby
Target '<Your Target Name>' do
     Pod 'JXTheme'
End
```
Execute `pod repo update` first, then execute `pod install`

## Carthage
Add in the cartfile:
```
Github "pujiaxin33/JXTheme"
```
Then execute `carthage update --platform iOS`. For other configurations, please refer to the Carthage documentation.

#Usage

## Add a custom style by extension`ThemeStyle` 
`ThemeStyle` only provides a default `unspecified` style. Other business styles need to be added by themselves. For example, only `light` and `dark` are supported. The code is as follows:
```Swift
Extension ThemeStyle {
    Static let light = ThemeStyle(rawValue: "light")
    Static let dark = ThemeStyle(rawValue: "dark")
}
```

## Basic use
```Swift
view.theme.backgroundColor = ThemeProvider({ (style) in
    If style == .dark {
        Return .white
    }else {
        Return .black
    }
})
imageView.theme.image = ThemeProvider({ (style) in
    If style == .dark {
        Return UIImage(named: "catWhite")!
    }else {
        Return UIImage(named: "catBlack")!
    }
})
```

## Custom Properties Configuration
```Swift
View.theme.customization = ThemeProvider({[weak self] style in
    / / You can choose any other property
    If style == .dark {
        Self?.view.bounds = CGRect(x: 0, y: 0, width: 30, height: 30)
    }else {
        Self?.view.bounds = CGRect(x: 0, y: 0, width: 80, height: 80)
    }
})
```

## Configuring the package example
`JXTheme` is a lightweight base library that provides configuration of theme properties, and does not restrict which way to load resources. The three examples provided below are for reference only.

### General Configuration Package Example

There is a UI standard for general skinning needs. For example, `UILabel.textColor` defines three levels, the code is as follows:
```Swift
Enum TextColorLevel: String {
    Case normal
    Case mainTitle
    Case subTitle
}
```
Then you can encapsulate a global function and pass `TextColorLevel` to return the corresponding configuration closure, which can greatly reduce the amount of code during configuration. The global functions are as follows:
```Swift
Func dynamicTextColor(_ level: TextColorLevel) -> ThemeProvider<UIColor> {
    Switch level {
    Case .normal:
        Return ThemeProvider({ (style) in
            If style == .dark {
                Return UIColor.white
            }else {
                Return UIColor.gray
            }
        })
    Case .mainTitle:
        ...
    Case .subTitle:
        ...
    }
}
```
The code for configuring the theme properties is as follows:
```Swift
themeLabel.theme.textColor = dynamicTextColor(.mainTitle)
```

### Local Plist file configuration example
Same as **General Configuration Package**, except that the method loads the configuration value from the local Plist file. The specific code participates in the `Example``StaticSourceManager` class.

### Add topics based on server dynamics
Same as **General Configuration Package**, except that the method loads the specific values ​​of the configuration from the server. The specific code participates in the `DynamicSourceManager` class of `Example`.

## Stateful controls
Some business requirements exist for a control with multiple states, such as checked and unchecked. Different states have different configurations for different theme. The configuration code is as follows:
```Swift
statusLabel.theme.textColor = ThemeProvider({[weak self] (style) in
    If self?.statusLabelStatus == .isSelected {
        / / selected state a configuration
        If style == .dark {
            Return .red
        }else {
            Return .green
        }
    }else {
        //Unselected another configuration
        If style == .dark {
            Return .white
        }else {
            Return .black
        }
    }
})
```

When the state of the control is updated, you need to refresh the current theme property configuration, the code is as follows:
```Swift
Func statusDidChange() {
    statusLabel.theme.textColor?.refresh()
}
```

If your control supports multiple state properties, such as `textColor`, `backgroundColor`, `font`, etc., you can call the `refresh` method without using one of the theme properties. You can use the following code to complete all the configured themes. Property refresh:
```Swift
Func statusDidChange() {
    statusLabel.theme.refresh()
}
```

## overrideThemeStyle
Regardless of how the theme switches, `overrideThemeStyleParentView` and its subview's `themeStyle` are `dark`
```Swift
overrideThemeStyleParentView.theme.overrideThemeStyle = .dark
```

# Other tips

## Why use the `theme` namespace attribute instead of the `theme_xx` extension attribute?
- If you extend N functions to the system class, when you use the class, there are N extended methods that interfere with your choice. Especially if you are doing other business development, not when you want to configure theme properties.
- Well-known three-party libraries like `Kingfisher`, `SnapKit`, etc., all use namespace attributes to implement extensions to system classes. This is a more `Swift` way of writing and worth learning.

## Theme Switch Notification
```Swift
Extension Notification.Name {
    Public static let JXThemeDidChange = Notification.Name("com.jiaxin.theme.themeDidChangeNotification")
}
```

## `ThemeManager` stores the theme configuration according to the user ID

```
/// Configure the stored flag key. Can be set to the user's ID, so that in the same phone, you can record the configuration of different users. You need to set this property first and then set other values.
Public var storeConfigsIdentifierKey: String = "default"
```

## Migrating to System API Guide
When your app supports iOS13 at the minimum, you can migrate to the system plan if you need to follow the guidelines below.
[Migrate to System API Guide, click to read] (https://github.com/pujiaxin33/JXTheme/blob/master/Document/%E8%BF%81%E7%A7%BB%E5%88%B0%E7% B3%BB%E7%BB%9FAPI%E6%8C%87%E5%8D%97.md)

# Currently supported classes and their properties

The properties here are inherited. For example, `UIView` supports the `backgroundColor` property, then its subclass `UILabel` also supports `backgroundColor`. If you don't have the class or property you want to support, you are welcome to extend the PullRequest.

## UIView

- `backgroundColor`
- `tintColor`
- `alpha`
- `customization`

## UILabel

- `font`
- `textColor`
- `shadowColor`
- `highlightedTextColor`
- `attributedText`

## UIButton

- `func setTitleColor(_ colorProvider: ThemeColorDynamicProvider?, for state: UIControl.State)`
- `func setTitleShadowColor(_ colorProvider: ThemeColorDynamicProvider?, for state: UIControl.State)`
- `func setAttributedTitle(_ textProvider: ThemeAttributedTextDynamicProvider?, for state: UIControl.State)`
- `func setImage(_ imageProvider: ThemeImageDynamicProvider?, for state: UIControl.State)`
- `func setBackgroundImage(_ imageProvider: ThemeImageDynamicProvider?, for state: UIControl.State)`

## UITextField

- `font`
- `textColor`
- `attributedText`
- `attributedPlaceholder`
- `keyboardAppearance`

## UITextView

- `font`
- `textColor`
- `attributedText`
- `keyboardAppearance`

## UIImageView

- `image`

## CALayer

- `backgroundColor`
- `borderColor`
- `borderWidth`
- `shadowColor`
- `customization`

## CAShapeLayer

- `fillColor`
- `strokeColor`

## UINavigationBar

- `barStyle`
- `barTintColor`
- `titleTextAttributes`
- `largeTitleTextAttributes`

## UITabBar

- `barStyle`
- `barTintColor`

## UISearchBar

- `barStyle`
- `barTintColor`
- `keyboardAppearance`

## UIToolbar

- `barStyle`
- `barTintColor`

## UISwitch

- `onTintColor`
- `thumbTintColor`

## UISlider

- `thumbTintColor`
- `minimumTrackTintColor`
- `maximumTrackTintColor`
- `minimumValueImage`
- `maximumValueImage`

## UIRefreshControl

- `attributedTitle`

## UIProgressView

- `progressTintColor`
- `trackTintColor`
- `progressImage`
- `trackImage`

## UIPageControl

- `pageIndicatorTintColor`
- `currentPageIndicatorTintColor`

## UIBarItem

- `func setTitleTextAttributes(_ attributesProvider: ThemeAttributesDynamicProvider?, for state: UIControl.State)`

## UIBarButtonItem

- `tintColor`

## UIActivityIndicatorView

- `style`

## UIScrollView

- `indicatorStyle`

## UITableView

- `separatorColor`
- `sectionIndexColor`
- `sectionIndexBackgroundColor`

# Contribution

If you have any questions or suggestions, please feel free to contact us by Issue and Pull Request🤝



