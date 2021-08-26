# Principle

In order to achieve the theme switching, the following five problems are mainly solved:
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
