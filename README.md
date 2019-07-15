# 简介
实现主题切换，主要解决以下五个问题：
## 1.如何优雅的设置主题属性
通过给控件扩展命名空间属性`theme`，类似于`SnapKit`的`snp`、`Kingfisher`的`kf`，这样可以将支持主题修改的属性，集中到`theme`属性。这样比直接给控件扩展方法`theme_setBackgroundColor`更加优雅。
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
```
var backgroundColor: ThemeColorDynamicProvider? {
    set(new) {
        if new != nil {
            let baseItem = self.base
            let config: ThemeCustomizationClosure = {[weak baseItem] (style) in
                baseItem?.backgroundColor = new?(style)
            }
            self.base.configs["UIView.backgroundColor"] = config
            ThemeManager.shared.addTrackedObject(self.base, addedConfig: config)
        }else {
            self.base.configs.removeValue(forKey: "UIView.backgroundColor")
        }
    }
    get { return nil }
}
```

## 4.如何记录支持主题属性的控件
为了在主题切换的时候，通知到支持主题属性配置的控件。通过在设置主题属性时，就记录目标控件。
核心代码就是第3步里面的`ThemeManager.shared.addTrackedObject(self.base, addedConfig: config)`

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
- [x] 使用`theme`命名空间属性，`view.theme.xx = xx`，告别`theme_xx`属性扩展用法；
- [x] 使用`ThemePropertyDynamicProvider`闭包，根据不同的`ThemeStyle`完成主题配置，实现最大化的自定义；
- [x] `ThemeStyle`可通过`extension`自定义style，不再局限于只有`light`和`dark`;
- [x] 提供`ThemeCustomizationClosure`闭包，可以灵活配置任何属性。不再局限于提供的`backgroundColor`、`textColor`等属性；
- [x] 提供根据`ThemeStyle`配置属性的常规封装、Plist文件静态加载、服务器JSON动态加载示例；

# 预览

# 要求

- iOS 9.0+
- XCode 12.1+
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

## 常规配置封装示例

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

## 本地Plist文件配置示例
与**常规配置封装**一样，只是该方法是从本地Plist文件加载配置的具体值，生成配置闭包的代码如下：
```Swift
func dynamicPlistTextColor(_ level: TextColorLevel) -> ThemeColorDynamicProvider {
    return { (style) -> UIColor in
        //StaticSourceManager具体的加载逻辑，请参看源码示例
        return StaticSourceManager.shared.textColor(style: style, level: level)
    }
}
```
主题属性配置时的代码如下：
```Swift
themeLabel.theme.textColor = dynamicPlistTextColor(.subTitle)
```

## 根据服务器动态添加主题

切换到服务器新增的主题，代码如下：
```Swift
if let themes = DynamicSourceManager.shared.themes, let newTheme = themes.first {
    //这里的newTheme完全是透明的String，依赖于服务器的数据
    ThemeManager.shared.changeTheme(to: ThemeStyle(rawValue: newTheme))
}else {
    //当前暂无服务器下发的主题资源，这里是你配置默认主题的地方。当然你也可以整合进DynamicSourceManager里面。
}
```
生成配置闭包的代码如下：
```Swift
func dynamicJSONTextColor(_ level: TextColorLevel) -> ThemeColorDynamicProvider {
    return { (style) -> UIColor in
        //DynamicSourceManager具体的加载逻辑，请参看源码示例
        return DynamicSourceManager.shared.textColor(style: style, level: level)
    }
}
```
主题属性配置时的代码如下：
```Swift
themeLabel.theme.textColor = dynamicJSONTextColor(.subTitle)
```

## 扩展`ThemeStyle`
```Swift
extension ThemeStyle {
    static let pink = ThemeStyle(rawValue: "pink")
}
```
然后就可以根据新的pink style进行适配了。

## 支持设置主题属性的类

请查阅源码`Extensions`类，所有支持主题属性的类，都在这里扩展。如果有你想要支持的类或新的属性，欢迎你提PullRequest。

# 其他说明

## 为什么使用`theme`命名空间属性，而不是使用`theme_xx`扩展属性呢？
- 如果你给系统的类扩展了N个函数，当你在使用该类时，进行函数索引时，就会有N个扩展的方法干扰你的选择。尤其是你在进行其他业务开发，而不是想配置主题属性时。
- 像`Kingfisher`、`SnapKit`等知名三方库，都使用了命名空间属性实现对系统类的扩展，这是一个更`Swift`的写法，值得学习。

