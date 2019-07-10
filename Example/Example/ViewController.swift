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

    override func viewDidLoad() {
        super.viewDidLoad()

        refreshToggleButton()
//        navigationController?.navigationItem

        themeView.theme.backgroundColor = { (style) -> UIColor in
            if style == .dark {
                return .black
            }else {
                return .blue
            }
        }
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
        themeImageView.theme.image = { (style) -> UIImage in
            if style == .dark {
                return UIImage(named: "catWhite")!
            }else {
                return UIImage(named: "catBlack")!
            }
        }

        themeLayerContainerView.layer.addSublayer(themeLayer)
        themeLayer.theme.backgroundColor = { (style) -> UIColor in
            if style == .dark {
                return .black
            }else {
                return .blue
            }
        }
        themeLayer.theme.customization = { [weak self] style in
            if style == .dark {
                self?.themeLayer.bounds = CGRect(x: 0, y: 0, width: 30, height: 30)
            }else {
                self?.themeLayer.bounds = CGRect(x: 0, y: 0, width: 80, height: 80)
            }
        }
        //TODO:自定义style
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        themeLayer.frame = themeLayerContainerView.bounds
    }

    func refreshToggleButton() {
        var styleTitle = "light"
        if ThemeManager.shared.currentThemeStyle == .dark {
            styleTitle = "dark"
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: styleTitle, style: .plain, target: self, action: #selector(toggleThemeStyle))
    }

    @objc func toggleThemeStyle() {
        if ThemeManager.shared.currentThemeStyle == .dark {
            ThemeManager.shared.themeStyleDidChange(.light)
        }else {
            ThemeManager.shared.themeStyleDidChange(.dark)
        }
    }
}


//TODO:添加业务示例封装
//enum DQDynamicBackgoundColorLevel {
//    case normal
//    case main
//    case sub
//}
//
//enum DQDynamicTextColorLevel {
//    case normal
//    case mainTitle
//    case subtitle
//}
//
//func dynamicBackgoundColor(level: DQDynamicBackgoundColorLevel) -> DQColorDynamicProvider {
//    switch level {
//    case .normal:
//        return { (style) -> UIColor in
//            if style == .light {
//                return UIColor.black
//            }else {
//                return UIColor.red
//            }
//        }
//    case .main:
//        return { (style) -> UIColor in
//            if style == .light {
//                return UIColor.black
//            }else {
//                return UIColor.red
//            }
//        }
//    case .sub:
//        return { (style) -> UIColor in
//            if style == .light {
//                return UIColor.black
//            }else {
//                return UIColor.red
//            }
//        }
//    }
//}
//
//func dynamicTextColor(level: DQDynamicTextColorLevel) -> DQColorDynamicProvider {
//    switch level {
//    case .normal:
//        return { (style) -> UIColor in
//            if style == .light {
//                return UIColor.white
//            }else {
//                return UIColor.black
//            }
//        }
//    case .mainTitle:
//        return { (style) -> UIColor in
//            if style == .light {
//                return UIColor.white
//            }else {
//                return UIColor.black
//            }
//        }
//    case .subtitle:
//        return { (style) -> UIColor in
//            if style == .light {
//                return UIColor.white
//            }else {
//                return UIColor.black
//            }
//        }
//    }
//}
