//
//  KeenAccessoryView.swift
//  KeenKeyboard
//
//  Created by chongzone on 2021/1/26.
//
//

import UIKit

//MARK: - 属性参数 
public struct KeenAccessoryAtrributes {
    
    /// 视图背景色 默认 #FFFFFF
    public var viewBackColor: UIColor = UIColor.color(hexString: "#FFFFFF")
    
    /// 是否添加阴影 默认 false
    public var showShadow: Bool = false
    /// 阴影颜色 默认 #848688
    public var shadowColor: UIColor = UIColor.color(hexString: "#848688")
    /// 阴影透明度 默认 0.15
    public var shadowOpacity: Float = 0.15
    
    /// 是否居中布局  默认 true 仅针对 标识 & 标题 等控件
    public var layoutCenter: Bool = true
    /// 控件间隔 默认 8 pt
    public var itemSpacing: CGFloat = 8
    /// 控件左边距 默认 15 pt
    public var itemLeftPadding: CGFloat = 15
    
    /// 标识 icon
    public var icon: UIImage! = Bundle.imageResouce(
        of: KeenKeyboard.self,
        bundle: "KeenKeyboard",
        name: "ic_keyboard_safe"
    )
    /// 标题
    public var title: String = "KEEN安全键盘"
    /// 标题字体 默认常规 15pt
    public var titleFont: UIFont = UIFont.systemFont(ofSize: 15, weight: .regular)
    /// 标题颜色 默认 #666666
    public var titleColor: UIColor = UIColor.color(hexString: "#666666")
    
    /// 右边按钮标题 默认 nil 其中仅当对应的图片为 nil 才会显示标题
    public var rightTitle: String? = nil
    /// 右边按钮 icon 优先显示图片
    public var rightIcon: UIImage? = Bundle.imageResouce(
        of: KeenKeyboard.self,
        bundle: "KeenKeyboard",
        name: "ic_keyboard_complete"
    )
    /// 右边按钮标题颜色  默认 #333333
    public var rightTitleColor: UIColor = UIColor.color(hexString: "#333333")
    /// 右边按钮标题字体 默认常规 15pt
    public var rightTitleFont: UIFont = UIFont.systemFont(ofSize: 15, weight: .regular)
    
    /// 线条颜色 默认 #EFEFEF
    public var lineColor: UIColor = UIColor.color(hexString: "#EFEFEF")
    
    public init() { }
}

//MARK: - 协议
public protocol KeenAccessoryViewDelegate: AnyObject {
    
    /// 属性参数 不设置取默认值
    /// - Returns: 属性对象
    func attributesOfAccessoryView(for accessoryView: KeenAccessoryView) -> KeenAccessoryAtrributes
    
    /// 回调事件 优先级高于闭包回调
    func complete(_ accessoryView: KeenAccessoryView)
}

public extension KeenAccessoryViewDelegate {
    
    func attributesOfAccessoryView(for accessoryView: KeenAccessoryView) -> KeenAccessoryAtrributes {
        return KeenAccessoryAtrributes()
    }
}

//MARK: - KeenAccessoryView 类
public class KeenAccessoryView: UIView {
    
    /// 代理
    public weak var delegate: KeenAccessoryViewDelegate?
    
    /// 属性参数
    private lazy var attributes: KeenAccessoryAtrributes = {
        if let d = delegate {
            return d.attributesOfAccessoryView(for: self)
        }else {
            return KeenAccessoryAtrributes()
        }
    }()
    /// 回调事件 优先级低于代理回调
    public var completeBlock: (()-> ())?
    
    /// 初始化 推荐
    /// - Parameters:
    ///   - height: accessoryView 高度
    ///   - delegate: 代理
    public init(height: CGFloat, delegate: KeenAccessoryViewDelegate?) {
        super.init(frame: CGRect(x: 0, y: 0, width: .screenWidth, height: height))
        self.delegate = delegate
        createSubviews()
    }
    
    /// 初始化
    /// - Parameters:
    ///   - height: accessoryView 高度
    ///   - attributes: 属性参数 若为 nil 取默认值
    public init(height: CGFloat, attributes: KeenAccessoryAtrributes? = nil) {
        super.init(frame: CGRect(x: 0, y: 0, width: .screenWidth, height: height))
        if let attr = attributes { self.attributes = attr }
        createSubviews()
    }
    
    /// 初始化
    /// - Parameters:
    ///   - height: accessoryView 高度
    ///   - attributes: 属性参数 若为 nil 取默认值
    ///   - completeBlock: 回调事件
    public init(
        height: CGFloat,
        attributes: KeenAccessoryAtrributes?,
        completeBlock: @escaping (() -> ())
    ) {
        super.init(frame: CGRect(x: 0, y: 0, width: .screenWidth, height: height))
        self.completeBlock = completeBlock
        if let attr = attributes { self.attributes = attr }
        createSubviews()
    }
    
    /// 绑定键盘附属 View
    /// - Parameters:
    ///   - height: 附属 View 高度 默认 44 pt
    ///   - delegate: 属性代理
    public static func bindAccessoryView(
        height: CGFloat = 44,
        delegate: KeenAccessoryViewDelegate?,
        field: UITextField
    ) {
        field.inputAccessoryView = KeenAccessoryView(height: 44, delegate: delegate)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - 布局|配置
private extension KeenAccessoryView {
    
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
        backColor(attributes.viewBackColor)
        let view = UIView().addViewTo(self)
        let labelW = attributes.title.calculateSize(
            font: attributes.titleFont,
            width: .greatestFiniteMagnitude,
            height: frame.height,
            kernSpace: 0,
            lineSpace: 0
        ).width
        let totalW = labelW + attributes.icon.size.width + attributes.itemSpacing
        
        view.y = 0
        if attributes.layoutCenter {
            view.centerX = centerX - totalW * 0.5
        }else {
            view.x = attributes.itemLeftPadding
        }
        view.size = CGSize(width: totalW, height: frame.height)
        
        /// 标识 icon
        let icon = UIImageView(image: attributes.icon)
            .contentMode(.scaleAspectFill)
            .clipsToBounds(true)
            .addViewTo(view)
        icon.x = 0
        icon.centerY = view.centerY
        icon.size = attributes.icon.size
        
        /// 标题
        let label = UILabel()
            .text(attributes.title)
            .font(attributes.titleFont)
            .textColor(attributes.titleColor)
            .addViewTo(view)
        label.y = 0
        label.x = icon.right + attributes.itemSpacing
        label.size = CGSize(width: labelW, height: view.height)
        
        /// 右边按钮
        let item = UIButton(type: .custom)
            .imageEdgeInsets(top:0, left:0, bottom:0, right:attributes.itemLeftPadding)
            .titleEdgeInsets(top:0, left:0, bottom:0, right:attributes.itemLeftPadding)
            .titleColor(attributes.rightTitleColor, .normal, .highlighted)
            .font(attributes.rightTitleFont)
            .horizontalAlignment(.right)
            .addViewTo(self)
        if attributes.rightIcon != nil {
            item.image(attributes.rightIcon)
        }else {
            item.title(attributes.rightTitle, .normal, .highlighted)
        }
        item.y = 0
        item.x = width - 180
        item.size = CGSize(width: 180, height: frame.height)
        item.addTarget(self, action: #selector(clickItemAction), for: .touchUpInside)
        
        /// 横线
        UIView(x: 0, y: 0, width: self.width, height: 0.5)
            .backColor(attributes.lineColor)
            .addViewTo(self)
    }
    
    @objc func clickItemAction() {
        if let d = self.delegate {
            d.complete(self)
        }else {
            if let complete = completeBlock {
                complete()
            }
        }
    }
}

extension UITextField {
    
    /// 绑定键盘附属 View
    /// - Parameters:
    ///   - height: 附属 View 高度
    ///   - delegate: 属性代理
    @discardableResult
    public func bindAccessoryView(
        height: CGFloat = 44,
        delegate: KeenAccessoryViewDelegate?
    ) -> Self {
        inputAccessoryView = KeenAccessoryView(height: 44, delegate: delegate)
        return self
    }
}
