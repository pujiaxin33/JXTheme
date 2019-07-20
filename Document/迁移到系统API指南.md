# 迁移到系统API指南

当你的应用最低支持iOS13时，恭喜你可以按照如下指南，迁移到系统方案。该方案仅提供一个思路，实际执行时请灵活变通。

## UIColor迁移指南

系统API示例：
```Swift
view.backgroundColor = UIColor(dynamicProvider: { (trait) -> UIColor in
    if trait.userInterfaceStyle == .dark {
        return .white
    }else {
        return .black
    }
})
```
JXTheme代码示例：
```Swift
view.theme.backgroundColor = ThemeProvider({ (style) in
    if style == .dark {
        return .white
    }else {
        return .black
    }
})
```

### 第一步

全局搜索`theme.backgroundColor`然后替换为`backgroundColor`。

### 第二步

全局搜索`ThemeProvider({ (style)`然后替换为`IColor(dynamicProvider: { (trait) -> UIColor`。

### 第三步

全局搜索`if style == .dark`然后替换为`if trait.userInterfaceStyle == .dark`

## UIImage迁移指南

删除JXTheme配置代码:
```Swift
imageView.theme.image = ThemeProvider({ (style) in
    if style == .dark {
        return UIImage(named: "catWhite")!
    }else {
        return UIImage(named: "catBlack")!
    }
})
```
然后用XCode11版本里的Asset里面按照要求配置图片。


## 其他属性配置

其他支持主题属性配置的代码，迁移到方法`func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?)`里面。




