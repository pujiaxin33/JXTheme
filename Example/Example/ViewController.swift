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
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusSwitch: UISwitch!
    @IBOutlet weak var overrideThemeStyleParentView: UIView!
    @IBOutlet weak var overrideThemeStyleSubview: UIView!
    @IBOutlet weak var overrideThemeStyleLabel: UILabel!
    @IBOutlet var cellTitleLabels: [UILabel]!
    @IBOutlet var cells: [UITableViewCell]!

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(themeDidChange(notification:)), name: Notification.Name.JXThemeDidChange, object: nil)
        refreshToggleButton()
        tableView.theme.backgroundColor = ThemeProvider({ (style) in
            if style == .dark {
                return .black
            }else {
                return .white
            }
        })
        
        themeView.theme.backgroundColor = ThemeProvider({ (style) in
            if style == .dark {
                return .white
            }else {
                return .black
            }
        })
        //UIView customization
        themeView.theme.customization = ThemeProvider({[weak self] style in
            if style == .dark {
                self?.themeView.bounds = CGRect(x: 0, y: 0, width: 30, height: 30)
            }else {
                self?.themeView.bounds = CGRect(x: 0, y: 0, width: 80, height: 80)
            }
        })
        
        themeLabel.theme.backgroundColor = ThemeProvider({ (style) in
            if style == .dark {
                return .black
            }else {
                return .white
            }
        })
        themeLabel.theme.textColor = ThemeProvider({ (style) in
            if style == .dark {
                return .white
            }else {
                return .black
            }
        })
        //配置逻辑封装示例
//        themeLabel.theme.textColor = dynamicTextColor(.mainTitle)
//        themeLabel.theme.textColor = dynamicPlistTextColor(.subTitle)
//        themeLabel.theme.textColor = dynamicJSONTextColor(.subTitle)

        themeButton.theme.backgroundColor = ThemeProvider({ (style) in
            if style == .dark {
                return .black
            }else {
                return .white
            }
        })
        themeButton.theme.setTitleColor(ThemeProvider({ (style) in
            if style == .dark {
                return .white
            }else {
                return .black
            }
        }), for: .normal)
        themeButton.theme.setTitleColor(ThemeProvider({ (style) in
            if style == .dark {
                return .yellow
            }else {
                return .orange
            }
        }), for: .selected)

        attributedLabel.theme.backgroundColor = ThemeProvider({ (style) in
            if style == .dark {
                return .black
            }else {
                return .white
            }
        })
        attributedLabel.theme.attributedText = ThemeProvider({ (style) in
            if style == .dark {
                let attributedText = NSMutableAttributedString(string: "这是attributedText主题测试文本", attributes: [.foregroundColor : UIColor.white, .font : UIFont.systemFont(ofSize: 15)])
                attributedText.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 2, length: 14))
                return attributedText
            }else {
                let attributedText = NSMutableAttributedString(string: "这是attributedText主题测试文本", attributes: [.foregroundColor : UIColor.black, .font : UIFont.systemFont(ofSize: 15)])
                attributedText.addAttribute(.foregroundColor, value: UIColor.blue, range: NSRange(location: 2, length: 14))
                return attributedText
            }
        })

        themeTextField.theme.backgroundColor = ThemeProvider({ (style) in
            if style == .dark {
                return .black
            }else {
                return .white
            }
        })
        themeTextField.theme.textColor = ThemeProvider({ (style) in
            if style == .dark {
                return .white
            }else {
                return .black
            }
        })

        themeTextView.theme.backgroundColor = ThemeProvider({ (style) in
            if style == .dark {
                return .black
            }else {
                return .white
            }
        })
        themeTextView.theme.textColor = ThemeProvider({ (style) in
            if style == .dark {
                return .white
            }else {
                return .black
            }
        })

        themeImageView.theme.backgroundColor = ThemeProvider({ (style) in
            if style == .dark {
                return .black
            }else {
                return .white
            }
        })
        //图片本地静态配置(load image from bundle)
        themeImageView.theme.image = ThemeProvider({ (style) in
            if style == .dark {
                return UIImage(named: "catWhite")!
            }else {
                return UIImage(named: "catBlack")!
            }
        })
        //图片动态下载配置(load image from server)
        /*
        themeImageView.theme.customization = ThemeProvider({[weak self] style in
//            let url = switch sytle choose image url
//            self?.themeImageView.image = download image with url by other third library like Kingfisher
        })
        */

        themeLayerContainerView.layer.addSublayer(themeLayer)
        themeLayer.theme.backgroundColor = ThemeProvider({ (style) in
            if style == .dark {
                return .white
            }else {
                return .black
            }
        })
        //CALayer customization
        themeLayer.theme.customization = ThemeProvider({ [weak self] style in
            if style == .dark {
                self?.themeLayer.bounds = CGRect(x: 0, y: 0, width: 30, height: 30)
            }else {
                self?.themeLayer.bounds = CGRect(x: 0, y: 0, width: 80, height: 80)
            }
        })

        //可以下面这行注释掉，看看运行效果(Try comment below code.)
        overrideThemeStyleParentView.theme.overrideThemeStyle = .dark
        overrideThemeStyleParentView.theme.backgroundColor = ThemeProvider({ (style) in
            if style == .dark {
                return .red
            }else {
                return .green
            }
        })
        overrideThemeStyleSubview.theme.backgroundColor = ThemeProvider({ (style) in
            if style == .dark {
                return .green
            }else {
                return .blue
            }
        })
        overrideThemeStyleLabel.theme.backgroundColor = ThemeProvider({ (style) in
            if style == .dark {
                return .black
            }else {
                return .white
            }
        })
        overrideThemeStyleLabel.theme.textColor = ThemeProvider({ (style) in
            if style == .dark {
                return .white
            }else {
                return .black
            }
        })

        statusLabel.theme.textColor = ThemeProvider({[weak self] (style) in
            if self?.statusSwitch.isOn == true {
                if style == .dark {
                    return .red
                }else {
                    return .green
                }
            }else {
                if style == .dark {
                    return .white
                }else {
                    return .black
                }
            }
        })

        //ThemeStyle customization
        customThemeStyleLabel.theme.backgroundColor = ThemeProvider({ (style) in
            if style == .dark {
                return .black
            }else if style == .pink {
                return UIColor(red: 255.0/255, green: 192.0/255, blue: 203.0/255, alpha: 1)
            }else {
                return .white
            }
        })
        customThemeStyleLabel.theme.textColor = ThemeProvider({ (style) in
            if style == .dark {
                return .white
            }else if style == .pink {
                return .white
            }else {
                return .black
            }
        })

        tableView.theme.separatorColor = ThemeProvider({ (style) in
            if style == .dark {
                return .white
            }else {
                return .black
            }
        })
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.theme.barStyle = ThemeProvider({ (style) in
            if style == .dark {
                return .black
            }else {
                return .default
            }
        })
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        themeLayer.frame = themeLayerContainerView.bounds
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 11 {
            navigationController?.pushViewController(ListViewController(style: .plain), animated: true)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if ThemeManager.shared.currentThemeStyle == .dark {
            cells.forEach { $0.contentView.backgroundColor = .black }
            cellTitleLabels.forEach { $0.textColor = .white }
        }else {
            cells.forEach { $0.contentView.backgroundColor = .white }
            cellTitleLabels.forEach { $0.textColor = .black }
        }
    }

    // The notification of theme did change
    @objc func themeDidChange(notification: Notification) {
        let newStyle = notification.userInfo?["style"] as! ThemeStyle
        if newStyle == .dark {
            cells.forEach { $0.contentView.backgroundColor = .black }
            cellTitleLabels.forEach { $0.textColor = .white }
        }else {
            cells.forEach { $0.contentView.backgroundColor = .white }
            cellTitleLabels.forEach { $0.textColor = .black }
        }
    }

    func refreshToggleButton() {
        let barButtonItem = UIBarButtonItem(title: ThemeManager.shared.currentThemeStyle.rawValue, style: .plain, target: self, action: #selector(toggleThemeStyle))
        barButtonItem.theme.tintColor = ThemeProvider({ (style) in
            if style == .dark {
                return .white
            }else {
                return .black
            }
        })
        navigationItem.rightBarButtonItem = barButtonItem
    }

    @objc func toggleThemeStyle() {
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

    @IBAction func statusSwitchDidClicked(_ sender: UISwitch) {
        //当statusLabel的状态发生变化时，调用目标主题属性的refresh方法，触发主题色更新
        statusLabel.theme.textColor?.refresh()
        //如果你的状态控件有许多支持状态的主题属性，你也可以使用下面的方法，触发所有的主题属性刷新
//        statusLabel.theme.refresh()
    }
}

//自定义ThemeStyle示例
extension ThemeStyle {
    static let light = ThemeStyle(rawValue: "light")
    static let dark = ThemeStyle(rawValue: "dark")
    static let pink = ThemeStyle(rawValue: "pink")
}

//业务自己封装配置逻辑
enum TextColorLevel: String {
    case normal
    case mainTitle
    case subTitle
}

func dynamicTextColor(_ level: TextColorLevel) -> ThemeProvider<UIColor> {
    switch level {
    case .normal:
        return ThemeProvider({ (style) in
            if style == .dark {
                return UIColor.white
            }else {
                return UIColor.gray
            }
        })
    case .mainTitle:
        return ThemeProvider({ (style) in
            if style == .dark {
                return UIColor.white
            }else {
                return UIColor.black
            }
        })
    case .subTitle:
        return ThemeProvider({ (style) in
            if style == .dark {
                return UIColor.white
            }else {
                return UIColor.lightGray
            }
        })
    }
}

//静态plist使用示例
func dynamicPlistTextColor(_ level: TextColorLevel) -> ThemeProvider<UIColor> {
    return ThemeProvider({ (style) in
        return StaticSourceManager.shared.textColor(style: style, level: level)
    })
}

//动态json使用示例
func dynamicJSONTextColor(_ level: TextColorLevel) -> ThemeProvider<UIColor> {
    return ThemeProvider({ (style) in
        return DynamicSourceManager.shared.textColor(style: style, level: level)
    })
}
