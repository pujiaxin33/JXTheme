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
    @IBOutlet weak var themeTextField: UITextField!
    @IBOutlet weak var themeTextView: UITextView!
    @IBOutlet weak var themeImageView: UIImageView!
    @IBOutlet weak var themeLayerContainerView: UIView!
    lazy var themeLayer: CALayer = { CALayer() }()
    @IBOutlet weak var attributedLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        refreshToggleButton()
        //swizzle uiview.setbackgroundcolor方法
        //extension UIColor 添加新的初始化器
        //extension UIColor 添加存储closure属性
        //extension uiview 添加存储当前UIColor（因为有些color设置，系统内部会copy，又因为UIColor是类族，我没有办法全部swizzle copywithzon方法赋值新增的属性，即使能行，对于系统入侵也太大了。）
        //将UIView添加到trackedItems，等到theme改变时，先调用UIColor存储的闭包获取对应theme的颜色值，再更新UIView.backgroundColor

        //extension UIView 2 新增一个[closure]，里面是先获取最新的backgroundColor，然后设置自己的backgroundColor代码，
        //2 将UIView添加到trackedItems，等到theme改变时，直接调用UIView存储的更新closure
        

        //虽然可以模仿系统api完成指定的api适配darkMode。比如设置背景色、文本色。但是必须要swizzle指定的方法，才能完成该方法的适配。且不能把自定义的UIColor赋值给一个不支持darkMode的属性。

        UIView.swizzleBackgoundColor
        UILabel.swizzleTextColor
//        themeLabel.backgroundColor = UIColor(dynamicColor: { (style) -> UIColor in
//            if style == .dark {
//                return .black
//            }else {
//                return .blue
//            }
//        })
//        themeLabel.textColor = UIColor(dynamicColor: { (style) -> UIColor in
//            if style == .dark {
//                return .white
//            }else {
//                return .red
//            }
//        })

        themeLabel.backgroundColor = DynamicColor(dynamicProvider: { (style) -> UIColor in
            if style == .dark {
                return .black
            }else {
                return .blue
            }
        })
//        themeLabel.textColor = DynamicColor(dynamicProvider: { (style) -> UIColor in
//            if style == .dark {
//                return .white
//            }else {
//                return .red
//            }
//        })
        let attributedText = NSMutableAttributedString(string: "这是attributedText主题测试文本", attributes: [.foregroundColor : UIColor.white, .font : UIFont.systemFont(ofSize: 15)])
        attributedText.addAttribute(.foregroundColor, value: DynamicColor(dynamicProvider: { (style) -> UIColor in
            if style == .dark {
                return .purple
            }else {
                return .orange
            }
        }), range: NSRange(location: 2, length: 14))
        themeLabel.attributedText = attributedText
        /*
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

 */
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

//        themeLayer.frame = themeLayerContainerView.bounds
    }

    func refreshToggleButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: ThemeManager.shared.currentThemeStyle.rawValue, style: .plain, target: self, action: #selector(toggleThemeStyle))
    }

    @objc func toggleThemeStyle() {
        if ThemeManager.shared.currentThemeStyle == .dark {
            ThemeManager.shared.changeTheme(to: .light)
        }else {
            ThemeManager.shared.changeTheme(to: .dark)
        }
        refreshToggleButton()
    }
}

