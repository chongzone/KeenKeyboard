//
//  NextVc.swift
//  KeenKeyboard
//
//  Created by chongzone on 2021/1/26.
//

import UIKit
import KeenKeyboard

class NextVc: UIViewController {
    
    var type: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backColor(.white)
        
        let field = UITextField(frame: CGRect(x: 50, y: CGFloat.screenHeight - 400, width: CGFloat.screenWidth - 100, height: 50))
            .font(UIFont.systemFont(ofSize: 24, weight: .medium))
            .textColor(.white)
            .backColor(.orange)
            .addViewTo(view)
        
        switch type {
        case 0, 1, 2:
            field.bindAccessoryView(height: 45, delegate: self)
            field.bindCustomKeyboard(delegate: self)
        default: field.bindCustomKeyboard(delegate: self)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension NextVc: KeenAccessoryViewDelegate {

    func complete(_ accessoryView: KeenAccessoryView) {
        view.endEditing(true)
        print("完成啦")
    }
    
    func attributesOfAccessoryView(for accessoryView: KeenAccessoryView) -> KeenAccessoryAtrributes {
        var attr = KeenAccessoryAtrributes()
        attr.showShadow = true
        attr.layoutCenter = true
        attr.title = "KEEN 安全键盘"
        return attr
    }
}

extension NextVc: KeenKeyboardDelegate {

    func attributesOfKeyboard(for keyboard: KeenKeyboard) -> KeenKeyboardAtrributes {
        var attr = KeenKeyboardAtrributes()
        switch type {
        case 3, 4, 5, 6:
            attr.showShadow = true
            attr.displayRandom = true
            attr.layout = .separator
        default:
            attr.displayRandom = false
            attr.layout = .fixed
        }
        switch type {
        case 0, 3, 4: attr.style = .number
        case 1, 5: attr.style = .decimal
        case 2, 6: attr.style = .identityCard
        default: attr.style = .number
        }
        switch type {
        case 3:
            attr.titleOfOther = "完成"
            attr.backColorOfOther = .lightGray
            attr.highlightedBackColorOfOther = .darkGray
            
            attr.backColorOfDelete = .lightGray
            attr.highlightedBackColorOfDelete = .darkGray
        default: attr.titleOfOther = nil
        }
        return attr
    }
    
    func other(_ keyboard: KeenKeyboard, text: String) {
        print("点击了左下角按钮 \(text)")
    }
}


