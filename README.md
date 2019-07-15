# 简介
实现主题切换，主要解决以下五个问题：
## 1.如何优雅的设置主题属性
通过给控件扩展命名空间属性`theme`，类似于`SnapKit`的`snp`、`Kingfisher`的`kf`，这样可以将支持主题修改的属性，集中到`theme`属性。这样比直接给控件扩展属性`theme_backgroundColor`更加优雅。
核心代码如下：
```Swift
view.theme.backgroundColor = { (style) -> UIColor in
    if style == .dark {
        return .white
    }else {
        return .black
    }
}
```

## 2.如何根据传入的style配置对应的值
借鉴iOS13系统API`UIColor(dynamicProvider: <UITraitCollection) -> UIColor>)`，自定义`ThemePropertyDynamicProvider`闭包，根据传入的`ThemeStyle`返回对应值。这样就可以针对不同的控件，不同的属性配置，实现最大的自定义。
核心代码如下：
```Swift
let dynamicColorProvider: ThemeColorDynamicProvider = { (style) -> UIColor in
    if style == .dark {
        return .white
    }else {
        return .black
    }
}
view.theme.backgroundColor = dynamicColorProvider
```

## 3.如何保存主题属性配置闭包
对控件添加`Associated object`属性`configs`存储主题属性配置闭包。
核心代码如下：
```Swift
public extension ThemeWapper where Base: UIView {
    var backgroundColor: ThemeColorDynamicProvider? {
        set(new) {
            if new != nil {
                let baseItem = self.base
                let config: ThemeCustomizationClosure = {[weak baseItem] (style) in
                    baseItem?.backgroundColor = new?(style)
                }
                //存储在扩展属性configs里面
                self.base.configs["UIView.backgroundColor"] = config
                ThemeManager.shared.addTrackedObject(self.base, addedConfig: config)
            }else {
                self.base.configs.removeValue(forKey: "UIView.backgroundColor")
            }
        }
        get { return nil }
    }
}
```

## 4.如何记录支持主题属性的控件
为了在主题切换的时候，通知到支持主题属性配置的控件。通过在设置主题属性时，就记录目标控件。
核心代码就是第3步里面的
```Swift 
ThemeManager.shared.addTrackedObject(self.base, addedConfig: config)
```

## 5.如何切换主题并调用主题属性配置闭包
通过`ThemeManager.changeTheme(to: style)`完成主题切换，方法内部再调用被追踪的控件`configs`里面的主题属性配置闭包。
核心代码如下：
```Swift
public func changeTheme(to style: ThemeStyle) {
    currentThemeStyle = style
    self.trackedHashTable.allObjects.forEach { (object) in
        if let view = object as? UIView {
            view.configs.values.forEach { $0(style) }
        }
    }
}
```

# 特性

- [x] 支持iOS 9+，让你的APP更早的实现`DarkMode`;
- [x] 使用`theme`命名空间属性:`view.theme.xx = xx`。告别`theme_xx`属性扩展用法；
- [x] 使用`ThemePropertyDynamicProvider`闭包，根据不同的`ThemeStyle`完成主题属性配置，实现最大化的自定义；
- [x] `ThemeStyle`可通过`extension`自定义style，不再局限于`light`和`dark`;
- [x] 提供`ThemeCustomizationClosure`闭包，可以灵活配置任何属性。不再局限于提供的`backgroundColor`、`textColor`等属性；
- [x] 提供根据`ThemeStyle`配置属性的常规封装、Plist文件静态加载、服务器动态加载示例；

# 预览

# 要求

- iOS 9.0+
- XCode 10.2.1+
- Swift 5.0+

# 安装

# 使用示例

## 基础使用
```Swift
view.theme.backgroundColor = { (style) -> UIColor in
    if style == .dark {
        return .black
    }else {
        return .blue
    }
}
imageView.theme.image = { (style) -> UIImage in
    if style == .dark {
        return UIImage(named: "catWhite")!
    }else {
        return UIImage(named: "catBlack")!
    }
}
```

## 自定义属性配置
```Swift
view.theme.customization = {[weak self] style in
    //可以选择任一其他属性
    if style == .dark {
        self?.view.bounds = CGRect(x: 0, y: 0, width: 30, height: 30)
    }else {
        self?.view.bounds = CGRect(x: 0, y: 0, width: 80, height: 80)
    }
}
```

## 配置封装示例
`JXTheme`是一个提供主题属性配置的轻量级基础库，不限制使用哪种方式加载资源。下面提供的三个示例仅供参考。

### 常规配置封装示例

一般的换肤需求，都会有一个UI标准。比如`UILabel.textColor`定义三个等级，代码如下：
```Swift
enum TextColorLevel: String {
    case normal
    case mainTitle
    case subTitle
}
```
然后可以封装一个全局函数传入`TextColorLevel`返回对应的配置闭包，就可以极大的减少配置时的代码量，全局函数如下：
```Swift
func dynamicTextColor(_ level: TextColorLevel) -> ThemeColorDynamicProvider {
    switch level {
    case .normal:
        return { (style) -> UIColor in
            if style == .dark {
                return UIColor.white
            }else {
                return UIColor.gray
            }
        }
    case .mainTitle:
        ...
    case .subTitle:
        ...
    }
}
```
主题属性配置时的代码如下：
```Swift
themeLabel.theme.textColor = dynamicTextColor(.mainTitle)
```

### 本地Plist文件配置示例
与**常规配置封装**一样，只是该方法是从本地Plist文件加载配置的具体值，具体代码参加`Example`的`StaticSourceManager`类

### 根据服务器动态添加主题
与**常规配置封装**一样，只是该方法是从服务器加载配置的具体值，具体代码参加`Example`的`DynamicSourceManager`类

# 扩展`ThemeStyle`
```Swift
//自定义pink style
extension ThemeStyle {
    static let pink = ThemeStyle(rawValue: "pink")
}
//更新pink style自定义属性
customThemeStyleLabel.theme.backgroundColor = { (style) -> UIColor in
    if style == .dark {
        return .black
    }else if style == .pink {
        return UIColor(red: 255.0/255, green: 192.0/255, blue: 203.0/255, alpha: 1)
    }else {
        return .white
    }
}
//切换到pink style
ThemeManager.shared.changeTheme(to: .pink)
```


# 目前支持的类及其属性

这里的属性是有继承关系的，比如`UIView`支持`backgroundColor`属性，那么它的子类`UILabel`等也就支持`backgroundColor`。如果没有你想要支持的类或属性，欢迎提PullRequest进行扩展。

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

# 其他说明

## 为什么使用`theme`命名空间属性，而不是使用`theme_xx`扩展属性呢？
- 如果你给系统的类扩展了N个函数，当你在使用该类时，进行函数索引时，就会有N个扩展的方法干扰你的选择。尤其是你在进行其他业务开发，而不是想配置主题属性时。
- 像`Kingfisher`、`SnapKit`等知名三方库，都使用了命名空间属性实现对系统类的扩展，这是一个更`Swift`的写法，值得学习。

## 主题切换通知
```Swift
extension Notification.Name {
    public static let JXThemeDidChange = Notification.Name("com.jiaxin.theme.themeDidChangeNotification")
}
```

## `ThemeManager`根据用户ID存储主题配置

```
/// 配置存储的标志key。可以设置为用户的ID，这样在同一个手机，可以分别记录不同用户的配置。需要优先设置该属性再设置其他值。
public var storeConfigsIdentifierKey: String = "default"
```





