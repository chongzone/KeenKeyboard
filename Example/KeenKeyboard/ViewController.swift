//
//  ViewController.swift
//  KeenKeyboard
//
//  Created by chongzone on 01/26/2021.
//  Copyright (c) 2021 chongzone. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "KeenKeyboard"
        
        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: UITableViewCell.className
        )
    }

    override func numberOfSections(in tableView: UITableView) -> Int { 1 }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 7 }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.className, for: indexPath)
        switch indexPath.row {
        case 0: cell.textLabel?.text = "数字样式键盘"
        case 1: cell.textLabel?.text = "金额样式键盘"
        case 2: cell.textLabel?.text = "身份证样式键盘"
        case 3: cell.textLabel?.text = "数字随机样式键盘"
        case 4: cell.textLabel?.text = "数字随机样式键盘2"
        case 5: cell.textLabel?.text = "金额随机样式键盘"
        case 6: cell.textLabel?.text = "身份证随机样式键盘"
        default: cell.textLabel?.text = "其他模式"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = NextVc()
        vc.type = indexPath.row
        navigationController?.pushViewController(vc, animated: true)
    }
}
