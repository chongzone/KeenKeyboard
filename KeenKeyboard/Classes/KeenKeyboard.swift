//
//  KeenKeyboard.swift
//  KeenKeyboard
//
//  Created by chongzone on 2021/1/26.
//

import UIKit

public extension KeenKeyboardAtrributes {
    
    /// 键盘样式
    enum Style {
        /// 数字样式
        case number
        /// 金额样式 数字 & 小数点
        case decimal
        /// 身份证样式 数字 & X
        case identityCard
    }
    
    /// 布局样式
    enum LayoutMode {
        /// 分割线
        case separator
        /// 固定(间隔固定 等分布局)
        case fixed
    }
}

//MARK: - 属性参数
public struct KeenKeyboardAtrributes {
    
    /// 视图背景色 默认 #F5F5F5
    public var viewBackColor: UIColor = UIColor.color(hexString: "#F5F5F5")
    
    /// 样式  默认 number
    public var style: KeenKeyboardAtrributes.Style = .number
    /// 布局样式 默认 fixed
    public var layout: KeenKeyboardAtrributes.LayoutMode = .fixed
    
    /// 是否添加阴影 默认 false
    public var showShadow: Bool = false
    /// 阴影颜色 默认 #848688
    public var shadowColor: UIColor = UIColor.color(hexString: "#848688")
    /// 阴影透明度 默认 0.15
    public var shadowOpacity: Float = 0.15
    
    /// 数值是否随机 默认 false
    public var displayRandom: Bool = false
    /// 键盘高度 默认 X 系列键盘距离其安全区域底部高度为 34
    public var keyboardHeight: CGFloat = 216 + .safeAreaBottomHeight
    
    /// 控件间隔 默认 6pt 仅对 fixed 布局生效
    public var itemSpacing: CGFloat = 6
    /// 控件圆角 默认 5pt 仅对 fixed 布局生效
    public var itemRadius: CGFloat = 5
    /// 阴影颜色 默认 #848688 仅对 fixed 布局生效
    public var itemShadowColor: UIColor = UIColor.color(hexString: "#848688")
    /// 阴影透明度 默认 0.15 仅对 fixed 布局生效
    public var itemShadowOpacity: Float = 0.15
    
    /// 分割线的大小 默认 0.5 pt 仅对 separator 布局生效
    public var separatorScale: CGFloat = 0.5
    /// 分割线的颜色 默认 #EFEFEF 仅对 separator 布局生效
    public var separatorColor: UIColor = UIColor.color(hexString: "#EFEFEF")
    
    /// 字体 默认系统 medium  24pt
    public var titleFont: UIFont = UIFont.systemFont(ofSize: 24, weight: .medium)
    /// 颜色 默认 #333333
    public var titleColor: UIColor = UIColor.color(hexString: "#333333")
    /// 高亮颜色  默认 #151515
    public var titleHighlightedColor: UIColor = UIColor.color(hexString: "#151515")
    /// 背景色 默认 #FFFFFF
    public var titleBackColor: UIColor = UIColor.color(hexString: "#FFFFFF")
    /// 高亮时背景色  默认 #E6E6E6
    public var titleHighlightedBackColor: UIColor = UIColor.color(hexString: "#E6E6E6")
    
    /// 左下角的标题 默认 nil  其中仅当对应的图片为 nil 才会显示标题  仅对 number 样式生效
    public var titleOfOther: String? = nil
    /// 左下角的图片 默认 nil 优先显示图片 仅对 number 样式生效
    public var imageOfOther: UIImage? = nil
    /// 左下角标题的字体  默认系统 medium 16pt 仅对 number 样式生效
    public var fontOfOther: UIFont = UIFont.systemFont(ofSize: 16, weight: .medium)
    /// 左下角标题的颜色 默认 #333333 仅对 number 样式生效
    public var colorOfOther: UIColor = UIColor.color(hexString: "#333333")
    /// 左下角标题高亮时的颜色 默认 #151515 仅对 number 样式生效
    public var highlightedColorOfOther: UIColor = UIColor.color(hexString: "#151515")
    /// 左下角背景色 默认 #F5F5F5 仅对 number 样式生效
    public var backColorOfOther: UIColor = UIColor.color(hexString: "#F5F5F5")
    /// 左下角高亮时背景色 默认 #E6E6E6 仅对 number 样式生效
    public var highlightedBackColorOfOther: UIColor = UIColor.color(hexString: "#E6E6E6")
    
    /// 右下角的标题 默认 nil 仅图片为 nil 才会显示标题
    public var titleOfDelete: String? = nil
    /// 右下角的图片 优先显示图片
    public var imageOfDelete: UIImage? = Bundle.imageResouce(
        of: KeenKeyboard.self,
        bundle: "KeenKeyboard",
        name: "ic_keyboard_delete"
    )
    /// 右下角标题的字体 默认系统 medium 16pt
    public var fontOfDelete: UIFont = UIFont.systemFont(ofSize: 16, weight: .medium)
    /// 右下角标题的颜色 默认 #333333
    public var colorOfDelete: UIColor = UIColor.color(hexString: "#333333")
    /// 右下角标题高亮时颜色 默认 #151515
    public var highlightedColorOfDelete: UIColor = UIColor.color(hexString: "#151515")
    /// 右下角背景色 默认 #F5F5F5
    public var backColorOfDelete: UIColor = UIColor.color(hexString: "#F5F5F5")
    /// 右下角高亮时背景色 默认 #E6E6E6
    public var highlightedBackColorOfDelete: UIColor = UIColor.color(hexString: "#E6E6E6")
    
    public init() { }
}

//MARK: - 协议
public protocol KeenKeyboardDelegate: AnyObject {
    
    /// 输入事件
    func insert(_ keyboard: KeenKeyboard, text: String)
    
    /// 删除事件
    func delete(_ keyboard: KeenKeyboard, text: String)
    
    /// 其他事件 仅对 number 样式生效
    func other(_ keyboard: KeenKeyboard, text: String)
    
    /// 属性参数 不设置取默认值
    /// - Returns: 属性对象
    func attributesOfKeyboard(for keyboard: KeenKeyboard) -> KeenKeyboardAtrributes
}

public extension KeenKeyboardDelegate {
    
    func insert(_ keyboard: KeenKeyboard, text: String) {}
    
    func delete(_ keyboard: KeenKeyboard, text: String) {}
    
    func other(_ keyboard: KeenKeyboard, text: String) {}
    
    func attributesOfKeyboard(for keyboard: KeenKeyboard) -> KeenKeyboardAtrributes {
        return KeenKeyboardAtrributes()
    }
}

//MARK: - KeenKeyboard 类
public class KeenKeyboard: UIView {
    
    /// 代理
    public weak var delegate: KeenKeyboardDelegate?
    
    /// 输入内容
    private var content: String = ""
    /// 文本框
    private var textField: UITextField!
    /// 左下角 item 标记 仅对 number 样式生效
    private let tagOfOther: Int = LONG_MAX - 215
    /// 右下角 item 标记
    private let tagOfDelete: Int = LONG_MAX - 216
    /// 右下角 item 标识
    private let identifierOfDelete: String = "rightIdentifier"
    
    /// 属性参数
    private lazy var attributes: KeenKeyboardAtrributes = {
        if let d = delegate {
            return d.attributesOfKeyboard(for: self)
        }else {
            return KeenKeyboardAtrributes()
        }
    }()
    /// 数据源  数据元素为空时该键不允许点击
    private lazy var datas: [String] = {
        let leftTitle: String!
        var nums = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
        switch attributes.style {
        case .number: leftTitle = attributes.titleOfOther ?? ""
        case .decimal: leftTitle = "."
        case .identityCard: leftTitle = "X"
        }
        if attributes.displayRandom { nums = nums.shuffled() }
        let endEle = nums.suffix(1)
        nums = Array(nums.prefix(9))
        nums.append(leftTitle)
        nums.append(endEle.first!)
        nums.append(identifierOfDelete)
        return nums
    }()
    
    /// 初始化
    /// - Parameters:
    ///   - field: 文本框
    ///   - delegate: 属性代理
    public init(field: UITextField, delegate: KeenKeyboardDelegate?) {
        super.init(frame: .zero)
        self.delegate = delegate
        var viewFrame = frame
        viewFrame.origin.x = 0
        viewFrame.size.width = CGFloat.screenWidth
        viewFrame.size.height = attributes.keyboardHeight
        viewFrame.origin.y = .screenHeight - attributes.keyboardHeight
        self.frame = viewFrame
        self.backColor(attributes.viewBackColor)
        textField = field
        createSubviews()
    }
    
    /// 绑定自定义键盘 其中代理不设置的话 属性参数取默认值 回调事件可选
    /// - Parameters:
    ///   - field: 文本框
    ///   - delegate: 属性代理
    public static func bindCustomKeyboard(
        field: UITextField,
        delegate: KeenKeyboardDelegate?
    ) {
        _ = KeenKeyboard(
            field: field,
            delegate: delegate
        )
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - 布局|配置
private extension KeenKeyboard {
    
    /// 布局控件
    func createSubviews() {
        /// View 阴影
        if attributes.showShadow {
            viewShadow(
                color: attributes.shadowColor,
                opacity: attributes.shadowOpacity,
                radius: 3,
                offset: CGSize(width: 0, height: -1)
            )
        }
        var index = 0
        let row: Int = 4, column: Int = 3;
        let safeAreaHeight = attributes.keyboardHeight - 216
        let space = attributes.layout == .separator ? 0 : attributes.itemSpacing
        let hSpaces = CGFloat(row)*space + CGFloat((column-1))*attributes.separatorScale
        let vSpaces = CGFloat(row + 1) * space + CGFloat(row) * attributes.separatorScale
        let itemW = (frame.width - hSpaces) / CGFloat(column)
        let itemH = (frame.height - vSpaces - safeAreaHeight) / CGFloat(row)
        
        for idx in 0..<4 {
            for ikx in 0..<3 {
                let itemX = space + CGFloat(ikx) * (itemW+space) + 0.5 * CGFloat((ikx+1))
                let itemY = space + CGFloat(idx) * (itemH+space) + 0.5 * CGFloat((idx+1))
                let item = UIButton(type: .custom)
                    .frame(CGRect(x: itemX, y: itemY, width: itemW, height: itemH))
                    .title(datas[index])
                    .font(attributes.titleFont)
                    .titleColor(attributes.titleColor, .normal)
                    .titleColor(attributes.titleHighlightedColor, .highlighted)
                    .isUserInteractionEnabled(!datas[index].isEmpty)
                    .addViewTo(self)
                if datas[index].isEmpty {
                    index += 1
                    continue
                }else {
                    item.backColor(attributes.titleBackColor, .normal)
                        .backColor(attributes.titleHighlightedBackColor, .highlighted)
                }
                item.addTarget(
                    self,
                    action: #selector(clickKeyboardAction(_:)),
                    for: .touchUpInside
                )
                /// 处理左下角
                if idx == row - 1, ikx == 0, attributes.style == .number {
                    item.tag(tagOfOther)
                        .font(attributes.fontOfOther)
                        .titleColor(attributes.colorOfOther, .normal)
                        .titleColor(attributes.highlightedColorOfOther, .highlighted)
                        .backColor(attributes.backColorOfOther, .normal)
                        .backColor(attributes.highlightedBackColorOfOther, .highlighted)
                    /// item 内容
                    if attributes.imageOfOther != nil {
                        item.title(nil)
                            .image(attributes.imageOfOther)
                    }else {
                        item.title(attributes.titleOfOther, .normal, .highlighted)
                    }
                }
                /// 处理右下角
                if idx == row - 1, ikx == 2 {
                    item.tag(tagOfDelete)
                        .font(attributes.fontOfDelete)
                        .titleColor(attributes.colorOfDelete, .normal)
                        .titleColor(attributes.highlightedColorOfDelete, .highlighted)
                        .backColor(attributes.backColorOfDelete, .normal)
                        .backColor(attributes.highlightedBackColorOfDelete, .highlighted)
                    /// item 内容
                    if attributes.imageOfDelete != nil {
                        item.title(nil)
                            .image(attributes.imageOfDelete)
                    }else {
                        item.title(attributes.titleOfDelete, .normal, .highlighted)
                    }
                }
                /// 圆角阴影
                if attributes.layout == .fixed {
                    if datas[index].isEmpty == false,
                       datas[index] != identifierOfDelete {
                        item.viewCornerShadow(
                            superview: self,
                            rect: item.frame,
                            radius: attributes.itemRadius,
                            corner: .allCorners,
                            shadowColor: attributes.itemShadowColor,
                            shadowOpacity: attributes.itemShadowOpacity,
                            shadowRadius: 0,
                            shadowOffset: CGSize(width: 0, height: 1)
                        )
                    }else {
                        item.viewCorner(size: item.size, radius: attributes.itemRadius)
                    }
                }
                /// 竖线
                if attributes.layout == .separator {
                    let lineH = frame.height - safeAreaHeight
                    let lineX = (itemW + attributes.separatorScale) * CGFloat(ikx + 1)
                    UIView(x: lineX, y: 0, width: 0.5, height: lineH)
                        .backColor(attributes.separatorColor)
                        .addViewTo(self)
                }
                index += 1
            }
            /// 横线
            if attributes.layout == .separator {
                let lineY = (itemH + attributes.separatorScale) * CGFloat(idx)
                UIView(x: 0, y: lineY, width: frame.width, height: attributes.separatorScale)
                    .backColor(attributes.separatorColor)
                    .addViewTo(self)
            }
        }
        textField.inputView = self
    }
    
    /// 点击键盘
    @objc func clickKeyboardAction(_ sender: UIButton) {
        if sender.tag == tagOfDelete {
            if content.count > 0 {
                content.removeLast()
                if let d = delegate {
                    d.delete(self, text: content)
                }
            }
        }else if sender.tag == tagOfOther {
            if attributes.style == .number {
                textField.resignFirstResponder()
                if let d = delegate {
                    d.other(self, text: content)
                }
                return
            }
        }else {
            content += sender.currentTitle!
            if let d = delegate {
                d.insert(self, text: content)
            }
        }
        var range = selectedTextRange(of: textField)
        let isDelete = sender.tag == tagOfDelete
        if isDelete {
            if range.length == 0, range.location > 0 {
                range.location -= 1
                range.length = 1
            }
        }
        let flag = textField.delegate?.textField?(textField, shouldChangeCharactersIn: range, replacementString: isDelete ? "" : sender.currentTitle!)
        if flag != false {
            if isDelete {
                textField.deleteBackward()
            }else {
                textField.insertText(sender.currentTitle!)
            }
        }
    }
    
    func selectedTextRange(of field: UITextField) -> NSRange {
        let from = field.selectedTextRange!.start
        let to = field.selectedTextRange!.end
        let location = field.offset(from: field.beginningOfDocument, to: from)
        let length = field.offset(from: from, to: to)
        return NSRange(location: location, length: length)
    }
}

extension KeenKeyboard: UIInputViewAudioFeedback {
    
    public var enableInputClicksWhenVisible: Bool { true }
}

//MARK: - UITextField 扩展
extension UITextField {
    
    /// 绑定自定义键盘 其中代理不设置的话 属性参数取默认值 回调事件可选
    /// - Parameters:
    ///   - delegate: 属性代理
    ///   - field: 文本框
    @discardableResult
    public func bindCustomKeyboard(
        delegate: KeenKeyboardDelegate?
    ) -> Self {
        _ = KeenKeyboard(field: self, delegate: delegate)
        return self
    }
}
