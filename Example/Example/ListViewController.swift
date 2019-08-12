//
//  ListViewController.swift
//  Example
//
//  Created by jiaxin on 2019/7/16.
//  Copyright © 2019 jiaxin. All rights reserved.
//

import UIKit
import JXTheme

class ListViewController: UITableViewController {

    override init(style: UITableView.Style) {
        super.init(style: style)

        tableView.register(ListCell.self, forCellReuseIdentifier: "cell")
        navigationController?.navigationBar.theme.barStyle = ThemeProvider({ (style) -> UIBarStyle in
            if style == .dark {
                return .black
            }else {
                return .default
            }
        })
        tableView.theme.separatorColor = ThemeProvider({ (style) -> UIColor in
            if style == .dark {
                return .white
            }else {
                return .black
            }
        })
        tableView.theme.backgroundColor = ThemeProvider({ (style) -> UIColor in
            if style == .dark {
                return .black
            }else {
                return .white
            }
        })
        tableView.theme.indicatorStyle = ThemeProvider({ (style) -> UIScrollView.IndicatorStyle in
            if style == .dark {
                return .white
            }else {
                return .black
            }
        })
        refreshToggleButton()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func refreshToggleButton() {
        let barButtonItem = UIBarButtonItem(title: ThemeManager.shared.currentThemeStyle.rawValue, style: .plain, target: self, action: #selector(toggleThemeStyle))
        barButtonItem.theme.tintColor = ThemeProvider({ (style) -> UIColor in
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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListCell
        cell.indexLabel.text = "index:\(indexPath.row)"
        return cell
    }
}

class ListCell: UITableViewCell {
    let nickLabel: UILabel
    let genderLabel: UILabel
    let indexLabel: UILabel

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        nickLabel = UILabel()
        genderLabel = UILabel()
        indexLabel = UILabel()
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.theme.backgroundColor = ThemeProvider({[weak self] (style) in
            if self?.isSelected == true && self?.selectedBackgroundView != nil {
                //①有背景选中视图且被选中状态，返回UIColor.clear
                return UIColor.clear
            }
            if style == .dark {
                return .black
            }else {
                return .white
            }
        })

        selectedBackgroundView = UIView()
        selectedBackgroundView?.theme.backgroundColor = ThemeProvider({ (style) in
            if style == .dark {
                return .red
            }else {
                return .green
            }
        })

        nickLabel.theme.textColor = ThemeProvider({ (style) in
            if style == .dark {
                return .white
            }else {
                return .black
            }
        })
        nickLabel.font = UIFont.systemFont(ofSize: 18)
        nickLabel.text = "这是昵称"
        contentView.addSubview(nickLabel)

        genderLabel.theme.textColor = ThemeProvider({ (style) in
            if style == .dark {
                return .white
            }else {
                return .gray
            }
        })
        genderLabel.font = UIFont.systemFont(ofSize: 15)
        genderLabel.text = "这是性别"
        contentView.addSubview(genderLabel)

        indexLabel.theme.textColor = ThemeProvider({ (style) in
            if style == .dark {
                return .white
            }else {
                return .lightGray
            }
        })
        indexLabel.font = UIFont.systemFont(ofSize: 13)
        indexLabel.text = "这是index"
        contentView.addSubview(indexLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if !selected && selectedBackgroundView != nil {
            //因为上面①处在选中状态设置为clear，所以在未选中时，就需要刷新backgroundColor
            contentView.theme.backgroundColor?.refresh()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        nickLabel.frame = CGRect(x: 20, y: 25, width: 100, height: 25)
        genderLabel.frame = CGRect(x: 20, y: 50 + 10, width: 100, height: 20)
        indexLabel.frame = CGRect(x: 150, y: 40, width: 100, height: 20)
    }
}
