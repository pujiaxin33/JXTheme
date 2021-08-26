
<div align=center><img width="468" height="90" src="https://github.com/pujiaxin33/JXTheme/blob/master/GIF/JXTheme.png"/></div>

[中文文档](https://github.com/pujiaxin33/JXTheme/blob/master/README-CN.md)

JXTheme is a lightweight library for theme properties configuration. 

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
If the library does not natively support a certain attribute, it can be handled uniformly in the customization.
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

## extension ThemeWrapper add property

If a certain attribute is frequently used in the project, and it is troublesome to use the above **Custom Properties Configuration**, you can add the desired property by yourself with the extension ThemeWrapper. (Ps: You can also submit a Pull Request  to add)

The following is an example of UILabel adding shadowColor:
```Swift
//Custom add ThemeProperty, currently only supports UIView, CALayer, UIBarItem and their subclasses
extension ThemeWrapper where Base: UILabel {
    var shadowColor: ThemeProvider<UIColor>? {
        set(new) {
            let baseItem = self.base
            ThemeTool.setupViewThemeProperty(view: self.base, key: "UILabel.shadowColor", provider: new) {[weak baseItem] (style) in
                baseItem?.shadowColor = new?.provider(style)
            }
        }
        get {return ThemeTool.getThemeProvider(target: self.base, with: "UILabel.shadowColor") as? ThemeProvider<UIColor>}
    }
}
```
The call is still the same:
```Swift
//Custom attribute shadowColor
shadowColorLabel.shadowOffset = CGSize(width: 0, height: 2)
shadowColorLabel.theme.shadowColor = ThemeProvider({ style in
    if style == .dark {
        return .red
    }else {
        return .green
    }
})
```

## Configuring the package example
`JXTheme` is a lightweight base library that provides configuration of theme properties, and does not restrict which way to load resources. The three examples provided below are for reference only.

### ThemeProvider custom initializer
For example, add the following code to the project:
```Swift
extension ThemeProvider {
     //Adjust according to the ThemeStyle supported by the project
     init(light: T, dark: T) {
         self.init {style in
             switch style {
             case .light: return light
             case .dark: return dark
             default: return light
             }
         }
     }
}
```
Call in business code:
```Swift
tableView.theme.backgroundColor = ThemeProvider(light: UIColor.white, dark: UIColor.white)
```
In this way, the form of ThemeProvider closure can be avoided and it is more concise.

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

# Principle

- [Principle](https://github.com/pujiaxin33/JXTheme/blob/master/Document/Principle.md)

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
- `shadowImage`

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
- `image`

## UIBarButtonItem

- `tintColor`

## UIActivityIndicatorView

- `style`
- `color`

## UIScrollView

- `indicatorStyle`

## UITableView

- `separatorColor`
- `sectionIndexColor`
- `sectionIndexBackgroundColor`

# Contribution

If you have any questions or suggestions, please feel free to contact us by Issue and Pull Request🤝



