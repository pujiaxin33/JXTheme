//
//  ViewController.swift
//  Example
//
//  Created by jiaxin on 2019/7/10.
//  Copyright © 2019 jiaxin. All rights reserved.
//

import UIKit
import JXTheme

class ViewController: UITableViewController {
    @IBOutlet weak var themeView: UIView!
    @IBOutlet weak var themeLabel: UILabel!
    @IBOutlet weak var themeButton: UIButton!
    @IBOutlet weak var themeTextField: UITextField!
    @IBOutlet weak var themeTextView: UITextView!
    @IBOutlet weak var themeImageView: UIImageView!
    @IBOutlet weak var themeLayerContainerView: UIView!
    lazy var themeLayer: CALayer = { CALayer() }()
    @IBOutlet weak var customThemeStyleLabel: UILabel!
    @IBOutlet weak var attributedLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        refreshToggleButton()

        themeView.theme.backgroundColor = { (style) -> UIColor in
            if style == .dark {
                return .black
            }else {
                return .blue
            }
        }
        //UIView customization自定义
        themeView.theme.customization = {[weak self] style in
            if style == .dark {
                self?.themeView.bounds = CGRect(x: 0, y: 0, width: 30, height: 30)
            }else {
                self?.themeView.bounds = CGRect(x: 0, y: 0, width: 80, height: 80)
            }
        }

        themeLabel.theme.backgroundColor = { (style) -> UIColor in
            if style == .dark {
                return .black
            }else {
                return .white
            }
        }
        themeLabel.theme.textColor = { (style) -> UIColor in
            if style == .dark {
                return .white
            }else {
                return .black
            }
        }
        //配置逻辑封装示例
//        themeLabel.theme.textColor = dynamicTextColor(.mainTitle)
//        themeLabel.theme.textColor = dynamicPlistTextColor(.subTitle)
//        themeLabel.theme.textColor = dynamicJSONTextColor(.subTitle)

        themeButton.theme.backgroundColor = { (style) -> UIColor in
            if style == .dark {
                return .black
            }else {
                return .white
            }
        }
        themeButton.theme.setTitleColor({ (style) -> UIColor in
            if style == .dark {
                return .white
            }else {
                return .black
            }
        }, for: .normal)
        themeButton.theme.setTitleColor({ (style) -> UIColor in
            if style == .dark {
                return .yellow
            }else {
                return .orange
            }
        }, for: .selected)
        /*
        themeButton.theme.setAttributedTitle({ (style) -> NSAttributedString in
            if style == .dark {
                let attributedText = NSMutableAttributedString(string: "这是attributedText主题测试文本", attributes: [.foregroundColor : UIColor.white, .font : UIFont.systemFont(ofSize: 15)])
                attributedText.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 2, length: 14))
                return attributedText
            }else {
                let attributedText = NSMutableAttributedString(string: "这是attributedText主题测试文本", attributes: [.foregroundColor : UIColor.black, .font : UIFont.systemFont(ofSize: 15)])
                attributedText.addAttribute(.foregroundColor, value: UIColor.blue, range: NSRange(location: 2, length: 14))
                return attributedText
            }
        }, for: .normal)
       */

        attributedLabel.theme.backgroundColor = { (style) -> UIColor in
            if style == .dark {
                return .black
            }else {
                return .white
            }
        }
        attributedLabel.theme.attributedText = { (style) -> NSAttributedString in
            if style == .dark {
                let attributedText = NSMutableAttributedString(string: "这是attributedText主题测试文本", attributes: [.foregroundColor : UIColor.white, .font : UIFont.systemFont(ofSize: 15)])
                attributedText.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 2, length: 14))
                return attributedText
            }else {
                let attributedText = NSMutableAttributedString(string: "这是attributedText主题测试文本", attributes: [.foregroundColor : UIColor.black, .font : UIFont.systemFont(ofSize: 15)])
                attributedText.addAttribute(.foregroundColor, value: UIColor.blue, range: NSRange(location: 2, length: 14))
                return attributedText
            }
        }

        themeTextField.theme.backgroundColor = { (style) -> UIColor in
            if style == .dark {
                return .black
            }else {
                return .white
            }
        }
        themeTextField.theme.textColor = { (style) -> UIColor in
            if style == .dark {
                return .white
            }else {
                return .black
            }
        }

        themeTextView.theme.backgroundColor = { (style) -> UIColor in
            if style == .dark {
                return .black
            }else {
                return .white
            }
        }
        themeTextView.theme.textColor = { (style) -> UIColor in
            if style == .dark {
                return .white
            }else {
                return .black
            }
        }

        themeImageView.theme.backgroundColor = { (style) -> UIColor in
            if style == .dark {
                return .black
            }else {
                return .white
            }
        }
        //图片本地静态配置
        themeImageView.theme.image = { (style) -> UIImage in
            if style == .dark {
                return UIImage(named: "catWhite")!
            }else {
                return UIImage(named: "catBlack")!
            }
        }
        //图片动态下载配置
        /*
        themeImageView.theme.customization = {[weak self] style in
//            let url = switch sytle choose image url
//            self?.themeImageView.image = download image with url by other third library like Kingfisher
        }
        */

        themeLayerContainerView.layer.addSublayer(themeLayer)
        themeLayer.theme.backgroundColor = { (style) -> UIColor in
            if style == .dark {
                return .black
            }else {
                return .blue
            }
        }
        //CALayer customization自定义
        themeLayer.theme.customization = { [weak self] style in
            if style == .dark {
                self?.themeLayer.bounds = CGRect(x: 0, y: 0, width: 30, height: 30)
            }else {
                self?.themeLayer.bounds = CGRect(x: 0, y: 0, width: 80, height: 80)
            }
        }

        //自定义ThemeStyle示例
        customThemeStyleLabel.theme.backgroundColor = { (style) -> UIColor in
            if style == .dark {
                return .black
            }else if style == .pink {
                return UIColor(red: 255.0/255, green: 192.0/255, blue: 203.0/255, alpha: 1)
            }else {
                return .white
            }
        }
        customThemeStyleLabel.theme.textColor = { (style) -> UIColor in
            if style == .dark {
                return .white
            }else if style == .pink {
                return .white
            }else {
                return .black
            }
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        themeLayer.frame = themeLayerContainerView.bounds
    }

    func refreshToggleButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: ThemeManager.shared.currentThemeStyle.rawValue, style: .plain, target: self, action: #selector(toggleThemeStyle))
    }

    @objc func toggleThemeStyle() {
        //动态json配置设置
        /*
        if let themes = DynamicSourceManager.shared.themes, let newTheme = themes.first {
            //这里的newTheme完全是透明的，依赖于服务器的数据
            ThemeManager.shared.changeTheme(to: ThemeStyle(rawValue: newTheme))
        }else {
            //当前暂无服务器下发的主题资源，这里是你配置默认主题的地方。当然你也可以整合进DynamicSourceManager里面。
        }
 */
        if ThemeManager.shared.currentThemeStyle == .dark {
            ThemeManager.shared.changeTheme(to: .light)
        }else {
            ThemeManager.shared.changeTheme(to: .dark)
        }
        refreshToggleButton()
    }

    @IBAction func togglePinkButtonClicked(_ sender: UIButton) {
        ThemeManager.shared.changeTheme(to: .pink)
        refreshToggleButton()
    }


    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        /*
        //如果你设置了ThemeManager.shared.isFollowSystem = true，你需要在你rootController里面的traitCollectionDidChange方法里面，监听userInterfaceStyle的改变。并且告知themeManager。
        if previousTraitCollection?.userInterfaceStyle != traitCollection.userInterfaceStyle {
            //之前的userInterfaceStyle和当前的userInterfaceStyle不同，才触发themeManager的更新
            ThemeManager.shared.refreshSystemTheme()
        }
 */
    }
}

//自定义ThemeStyle示例
extension ThemeStyle {
    static let pink = ThemeStyle(rawValue: "pink")
}

//业务自己封装配置逻辑
enum TextColorLevel: String {
    case normal
    case mainTitle
    case subTitle
}

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
        return { (style) -> UIColor in
            if style == .dark {
                return UIColor.white
            }else {
                return UIColor.black
            }
        }
    case .subTitle:
        return { (style) -> UIColor in
            if style == .dark {
                return UIColor.white
            }else {
                return UIColor.lightGray
            }
        }
    }
}

//静态plist使用示例
func dynamicPlistTextColor(_ level: TextColorLevel) -> ThemeColorDynamicProvider {
    return { (style) -> UIColor in
        return StaticSourceManager.shared.textColor(style: style, level: level)
    }
}

//动态json使用示例
func dynamicJSONTextColor(_ level: TextColorLevel) -> ThemeColorDynamicProvider {
    return { (style) -> UIColor in
        return DynamicSourceManager.shared.textColor(style: style, level: level)
    }
}
