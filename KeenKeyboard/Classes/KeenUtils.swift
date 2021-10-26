//
//  KeenUtils.swift
//  KeenKeyboard
//
//  Created by chongzone on 2021/1/26.
//

import UIKit

// 更多控件的扩展可参考地址 https://github.com/chongzone/KeenExtension.git
extension NSObject {
    
    /// 类名
    public var className: String {
        let name = type(of: self).description()
        if name.contains(".") {
            return name.components(separatedBy: ".").last!
        }else {
            return name
        }
    }
    
    /// 类名
    public static var className: String {
        return String(describing: self)
    }
}

extension String {
    
    /// 计算字符串宽高
    /// - Parameters:
    ///   - font: 字体
    ///   - width: 设定的宽度
    ///   - height: 设定的高度
    ///   - kernSpace: 字符间距
    ///   - lineSpace: 行间距
    /// - Returns: CGSize 值
    public func calculateSize(
        font: UIFont,
        width: CGFloat = CGFloat.greatestFiniteMagnitude,
        height: CGFloat = CGFloat.greatestFiniteMagnitude,
        kernSpace: CGFloat = 0,
        lineSpace: CGFloat = 0
    ) -> CGSize {
        if kernSpace == 0, lineSpace == 0 {
            let rect = self.boundingRect(
                with: CGSize(width: width, height: height),
                options: .usesLineFragmentOrigin,
                attributes: [.font: font],
                context: nil
            )
            return CGSize(width: ceil(rect.width), height: ceil(rect.height))
        }else {
            let rect = CGRect(x: 0, y: 0, width: width, height: height)
            let label = UILabel(frame: rect)
            label.numberOfLines = 0
            label.font = font
            label.text = self
            let style = NSMutableParagraphStyle()
            style.lineSpacing = lineSpace
            let attr = NSMutableAttributedString(
                string: self,
                attributes: [.kern : kernSpace]
            )
            attr.addAttribute(
                .paragraphStyle,
                value: style,
                range: NSMakeRange(0, self.count)
            )
            label.attributedText = attr
            return label.sizeThatFits(rect.size)
        }
    }
}

extension Bundle {
    
    /// 获取当前 bundle 资源
    /// - Parameters:
    ///   - aClass: 资源库类
    ///   - bundle: 当前 bundle 名称
    ///   - name: 资源名称
    ///   - ext: 资源后缀  默认 png
    /// - Returns: 图片
    public static func imageResouce(of aClass: AnyClass, bundle: String, name: String, ofType ext: String = "png") -> UIImage? {
        let mainBundle = Bundle(for: aClass)
        let bundlePath = mainBundle.path(forResource: bundle, ofType: "bundle")!
        let imgName = String(format: "%@@%.fx.%@", name, UIScreen.main.scale, ext)
        return UIImage(named: imgName, in: Bundle(path: bundlePath), compatibleWith: nil)
    }
}

extension CGFloat {
    
    /// 屏幕宽度
    public static var screenWidth: CGFloat { UIScreen.main.bounds.size.width }
    /// 屏幕高度
    public static var screenHeight: CGFloat { UIScreen.main.bounds.size.height }
    /// 安全区域底部高度
    public static var safeAreaBottomHeight: CGFloat { UIDevice.isIPhoneXSeries ? 34.0 : 0.0 }
}

extension UIColor {
    
    /// 由 Hex 生成 Color 透明度默认 1.0
    /// - Parameters:
    ///   - hexString: 十六进制字符串
    ///   - alpha: 透明度
    /// - Returns: 对应的 Color
    public static func color(hexString: String, alpha: CGFloat = 1.0) -> UIColor {
        var hex = hexString.trimmingCharacters(in: .whitespaces).lowercased()
        if hex.hasPrefix("#") {
            hex = "\(hex.dropFirst())"
        }
        if hex.hasPrefix("0x") {
            hex = "\(hexString.dropFirst(2))"
        }
        var hexValue: UInt64 = 0
        let scanner: Scanner = Scanner(string: hex)
        scanner.scanHexInt64(&hexValue)
        return UIColor(
            red: CGFloat(Int(hexValue >> 16) & 0x0000FF) / 255.0,
            green: CGFloat(Int(hexValue >> 8) & 0x0000FF) / 255.0,
            blue: CGFloat(Int(hexValue) & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
    
    /// 随机色 用于调试等
    public static var colorRandom: UIColor {
        let red   = CGFloat(arc4random()%256)/255.0
        let green = CGFloat(arc4random()%256)/255.0
        let blue  = CGFloat(arc4random()%256)/255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

extension UIView {
    
    /// 初始化
    public convenience init(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        self.init(frame: CGRect(x: x, y: y, width: width, height: height))
    }
}

extension UIView {
    
    /// frame
    /// - Parameter frame: frame
    /// - Returns: 自身
    @discardableResult
    public func frame(_ frame: CGRect) -> Self {
        self.frame = frame
        return self
    }
    
    /// 背景色
    /// - Parameter color: 颜色
    /// - Returns: 自身
    @discardableResult
    public func backColor(_ color: UIColor?) -> Self {
        backgroundColor = color
        return self
    }
    
    /// tag 值
    /// - Parameter tag: tag 值
    /// - Returns: 自身
    @discardableResult
    public func tag(_ tag: Int) -> Self {
        self.tag = tag
        return self
    }
    
    /// 是否支持响应 label & imageView 默认 false
    /// - Parameter enabled: 是否支持响应
    /// - Returns: 自身
    @discardableResult
    public func isUserInteractionEnabled(_ enabled: Bool) -> Self {
        isUserInteractionEnabled = enabled
        return self
    }
    
    /// 显示模式
    /// - Parameter mode: 模式类型
    /// - Returns: 自身
    @discardableResult
    public func contentMode(_ mode: UIView.ContentMode) -> Self {
        contentMode = mode
        return self
    }
    
    /// 是否超出的裁剪 默认 true
    /// - Parameter isClips: 是否裁剪
    /// - Returns: 自身
    @discardableResult
    public func clipsToBounds(_ isClips: Bool = true) -> Self {
        clipsToBounds = isClips
        return self
    }
    
    /// 添加到父视图
    /// - Parameter superView: 父视图
    /// - Returns: 自身
    @discardableResult
    public func addViewTo(_ superView: UIView) -> Self {
        superView.addSubview(self)
        return self
    }
}

extension UIView {
    
    public var x: CGFloat {
        get {
            return frame.origin.x
        } set(value) {
            frame = CGRect(x: value, y: y, width: width, height: height)
        }
    }
    
    public var y: CGFloat {
        get {
            return frame.origin.y
        } set(value) {
            frame = CGRect(x: x, y: value, width: width, height: height)
        }
    }
    
    public var width: CGFloat {
        get {
            return frame.size.width
        } set(value) {
            frame = CGRect(x: x, y: y, width: value, height: height)
        }
    }
    
    public var height: CGFloat {
        get {
            return frame.size.height
        } set(value) {
            frame = CGRect(x: x, y: y, width: width, height: value)
        }
    }
    
    public var origin: CGPoint {
        get {
            return frame.origin
        } set(value) {
            frame = CGRect(origin: value, size: frame.size)
        }
    }
    
    public var size: CGSize {
        get {
            return frame.size
        } set(value) {
            frame = CGRect(origin: frame.origin, size: value)
        }
    }
    
    public var centerX: CGFloat {
        get {
            return center.x
        } set(value) {
            center = CGPoint(x: value, y: centerY)
        }
    }
    
    public var centerY: CGFloat {
        get {
            return center.y
        } set(value) {
            center = CGPoint(x: centerX, y: value)
        }
    }
    
    public var top: CGFloat {
        get {
            return y
        } set(value) {
            y = value
        }
    }
    
    public var left: CGFloat {
        get {
            return x
        } set(value) {
            x = value
        }
    }
    
    public var bottom: CGFloat {
        get {
            return y + height
        } set(value) {
            y = value - height
        }
    }

    public var right: CGFloat {
        get {
            return x + width
        } set(value) {
            x = value - width
        }
    }
}

extension UIView {
    
    /// View 阴影 默认偏移量 (0, -3)
    /// - Parameters:
    ///   - color: 阴影颜色
    ///   - opacity: 透明度 默认 0
    ///   - radius: 半径 默认 3
    ///   - offset: 偏移量 默认 (0, -3) 其中 X 正右负左 Y 正下负上
    public func viewShadow(
        color: UIColor,
        opacity: Float = 0.0,
        radius: CGFloat = 3,
        offset: CGSize = CGSize(width: 0, height: -3)
    ) {
        layer.shadowColor   = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowRadius  = radius
        layer.shadowOffset  = offset
    }
    
    /// View 圆角  默认 View 四周皆有圆角
    /// - Parameters:
    ///   - size: View 宽高
    ///   - radius: 圆角大小
    ///   - corner: 圆角位置
    public func viewCorner(
        size: CGSize,
        radius: CGFloat,
        corner: UIRectCorner = .allCorners
    ) {
        let path = UIBezierPath(
            roundedRect: CGRect(origin: .zero, size: size),
            byRoundingCorners: corner,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = CGRect(origin: .zero, size: size)
        shapeLayer.path = path.cgPath
        layer.mask = shapeLayer
    }
    
    /// View 圆角和阴影
    /// - Parameters:
    ///   - superview: 父视图
    ///   - rect: View  对应的 Frame
    ///   - radius: 圆角大小
    ///   - corner: 圆角位置
    ///   - shadowColor: 阴影颜色
    ///   - shadowOpacity: 阴影透明度 默认 0
    ///   - shadowRadius: 阴影半径 默认 3
    ///   - shadowOffset: 阴影偏移量 默认 (0, -3) 其中 X 正右负左 Y 正下负上
    public func viewCornerShadow(
        superview: UIView,
        rect: CGRect,
        radius: CGFloat,
        corner: UIRectCorner,
        shadowColor: UIColor,
        shadowOpacity: Float,
        shadowRadius: CGFloat,
        shadowOffset: CGSize
    ) {
        viewCorner(size: rect.size, radius: radius, corner: corner)
        let subLayer = CALayer()
        subLayer.frame = rect
        subLayer.cornerRadius    = radius
        subLayer.backgroundColor = (backgroundColor ?? .white).cgColor
        subLayer.masksToBounds   = false
        subLayer.shadowColor     = shadowColor.cgColor
        subLayer.shadowOpacity   = shadowOpacity
        subLayer.shadowRadius    = shadowRadius
        subLayer.shadowOffset    = shadowOffset
        superview.layer.insertSublayer(subLayer, below: layer)
    }
}

extension UIImage {
    
    /// 由颜色生成图片
    /// - Parameter color: 颜色
    /// - Returns: 图片
    public static func image(color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
        let context = UIGraphicsGetCurrentContext()
        guard let ctx = context else {
            UIGraphicsEndImageContext()
            return nil
        }
        ctx.setFillColor(color.cgColor)
        ctx.fill(rect)
        
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            UIGraphicsEndImageContext()
            return nil
        }
        UIGraphicsEndImageContext()
        return image
    }
}

extension UILabel {
    
    /// 文本
    /// - Parameters:
    ///   - text: 文本
    /// - Returns: 自身
    @discardableResult
    public func text(_ text: String?) -> Self {
        self.text = text
        return self
    }
    
    /// 文本字体
    /// - Parameter font: 字体
    /// - Returns: 自身
    @discardableResult
    public func font(_ font: UIFont) -> Self {
        self.font = font
        return self
    }
    
    /// 文本颜色
    /// - Parameter color: 颜色
    /// - Returns:  自身
    @discardableResult
    public func textColor(_ color: UIColor) -> Self {
        textColor = color
        return self
    }
    
    /// 对齐方式
    /// - Parameter alignment: 对齐方式 默认靠左
    /// - Returns: 自身
    @discardableResult
    public func alignment(_ alignment: NSTextAlignment = .left) -> Self {
        textAlignment = alignment
        return self
    }
}

extension UITextField {
    
    /// 代理
    /// - Parameter delegate: 代理
    /// - Returns: 自身
    @discardableResult
    public func delegate(_ delegate: UITextFieldDelegate?) -> Self {
        self.delegate = delegate
        return self
    }
    
    /// 文本
    /// - Parameter text: 文本
    /// - Returns: 自身
    @discardableResult
    public func text(_ text: String?) -> Self {
        self.text = text
        return self
    }
    
    /// 文本占位符
    /// - Parameter text: 占位符
    /// - Returns: 自身
    @discardableResult
    public func placeholder(_ text: String?) -> Self {
        placeholder = text
        return self
    }
    
    /// 字体 默认系统 12pt 字体
    /// - Parameter font: 字体
    /// - Returns: 自身
    @discardableResult
    public func font(_ font: UIFont?) -> Self {
        self.font = font
        return self
    }
    
    /// 文本颜色
    /// - Parameter color: 颜色
    /// - Returns:  自身
    @discardableResult
    public func textColor(_ color: UIColor?) -> Self {
        textColor = color
        return self
    }
    
    /// 对齐方式  默认靠左
    /// - Parameter alignment: 对齐方式
    /// - Returns: 自身
    @discardableResult
    public func alignment(_ alignment: NSTextAlignment = .left) -> Self {
        textAlignment = alignment
        return self
    }
    
    /// 边框样式
    /// - Parameter style: 边框样式
    /// - Returns: 自身
    @discardableResult
    public func borderStyle(_ style: UITextField.BorderStyle = .none) -> Self {
        borderStyle = style;
        return self
    }
    
    /// 键盘样式
    /// - Parameter type: 键盘样式
    /// - Returns: 自身
    @discardableResult
    public func keyboardType(_ type: UIKeyboardType) -> Self {
        keyboardType = type
        return self
    }
    
    /// 键盘 return 键样式
    /// - Parameter type: 样式
    /// - Returns: 自身
    @discardableResult
    public func returnKeyType(_ type: UIReturnKeyType) -> Self {
        returnKeyType = type
        return self
    }
    
    /// 清除按钮模式 默认 never
    /// - Parameter mode: 模式
    /// - Returns: 自身
    @discardableResult
    public func clearButtonMode(_ mode: UITextField.ViewMode = .never) -> Self {
        clearButtonMode = mode
        return self
    }
    
    /// 文本加密 默认 false
    /// - Parameter isSecure: 是否加密
    /// - Returns: 自身
    @discardableResult
    public func isSecureText(_ isSecure: Bool = false) -> Self {
        isSecureTextEntry = isSecure
        return self
    }
    
    /// 键盘自定义视图
    /// - Parameter inputView: 自定义视图
    /// - Returns: 自身
    @discardableResult
    public func inputView(_ inputView: UIView?) -> Self {
        self.inputView = inputView
        return self
    }
    
    /// 依附在键盘上的辅助视图
    /// - Parameter accessoryView: 自定义的视图
    /// - Returns: 自身
    @discardableResult
    public func inputAccessoryView(_ accessoryView: UIView?) -> Self {
        inputAccessoryView = accessoryView
        return self
    }
}

extension UIControl {
    
    /// 内容水平对齐方式
    /// - Parameter horizontalAlignment: 对齐方式
    /// - Returns: 自身
    @discardableResult
    public func horizontalAlignment(_ horizontalAlignment: UIControl.ContentHorizontalAlignment) -> Self {
        contentHorizontalAlignment = horizontalAlignment
        return self
    }
}

extension UIButton {
    
    /// 按钮文字 状态默认 normal
    /// - Parameters:
    ///   - title: 文案
    ///   - state: 状态
    /// - Returns: 自身
    @discardableResult
    public func title(_ title: String?, _ state: UIControl.State = .normal) -> Self {
        setTitle(title, for: state)
        return self
    }
    
    /// 按钮文字
    /// - Parameters:
    ///   - title: 文案
    ///   - state1: 状态 1
    ///   - state2: 状态 2
    /// - Returns: 自身
    @discardableResult
    public func title(_ title: String?, _ state1: UIControl.State, _ state2: UIControl.State) -> Self {
        setTitle(title, for: state1)
        setTitle(title, for: state2)
        return self
    }
    
    /// 按钮字体
    /// - Parameter font: 字体
    /// - Returns: 自身
    @discardableResult
    public func font(_ font: UIFont) -> Self {
        titleLabel?.font = font
        return self
    }
    
    /// 按钮文字颜色 状态默认 normal
    /// - Parameters:
    ///   - color: 文案颜色
    ///   - state: 状态
    /// - Returns: 自身
    @discardableResult
    public func titleColor(_ color: UIColor, _ state: UIControl.State = .normal) -> Self {
        setTitleColor(color, for: state)
        return self
    }
    
    /// 按钮文字颜色
    /// - Parameters:
    ///   - color: 文案颜色
    ///   - state1: 状态 1
    ///   - state2: 状态 2
    /// - Returns: 自身
    @discardableResult
    public func titleColor(_ color: UIColor, _ state1: UIControl.State, _ state2: UIControl.State) -> Self {
        setTitleColor(color, for: state1)
        setTitleColor(color, for: state2)
        return self
    }
    
    /// 按钮图片 状态默认 normal
    /// - Parameters:
    ///   - image: 图片
    ///   - state: 状态
    /// - Returns: 自身
    @discardableResult
    public func image(_ image: UIImage?, _ state: UIControl.State = .normal) -> Self {
        setImage(image, for: state)
        return self
    }
    
    /// 按钮图片
    /// - Parameters:
    ///   - image: 图片
    ///   - state1: 状态 1
    ///   - state2: 状态 2
    /// - Returns: 自身
    @discardableResult
    public func image(_ image: UIImage?, _ state1: UIControl.State, _ state2: UIControl.State) -> Self {
        setImage(image, for: state1)
        setImage(image, for: state2)
        return self
    }
    
    /// 按钮背景色 状态默认 normal
    /// - Parameters:
    ///   - color: 背景色
    ///   - state: 状态
    /// - Returns: 自身
    @discardableResult
    public func backColor(_ color: UIColor, _ state: UIControl.State = .normal) -> Self {
        setBackgroundImage(UIImage.image(color: color), for: state)
        return self
    }
    
    /// 按钮背景色
    /// - Parameters:
    ///   - color: 背景色
    ///   - state1: 状态 1
    ///   - state2: 状态 2
    /// - Returns: 自身
    @discardableResult
    public func backColor(_ color: UIColor, _ state1: UIControl.State, _ state2: UIControl.State) -> Self {
        setBackgroundImage(UIImage.image(color: color), for: state1)
        setBackgroundImage(UIImage.image(color: color), for: state2)
        return self
    }
    
    /// 按钮文字内边距
    /// - Parameters:
    ///   - edge: 边距
    /// - Returns: 自身
    @discardableResult
    public func titleEdgeInsets(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> Self {
        titleEdgeInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        return self
    }
    
    /// 按钮图片内边距
    /// - Parameters:
    ///   - top: 顶部边距
    ///   - left: 左边边距
    ///   - bottom: 底部边距
    ///   - right: 右边边距
    /// - Returns: 自身
    @discardableResult
    public func imageEdgeInsets(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> Self {
        imageEdgeInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        return self
    }
}

extension UIDevice {
    
    /// 主屏幕
    public static var keyWindow: UIWindow? {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.connectedScenes
                .first { $0.activationState == .foregroundActive }
                .map { $0 as? UIWindowScene }
                .map { $0?.windows.first } ?? UIApplication.shared.delegate?.window ?? nil
        }
        return UIApplication.shared.delegate?.window ?? nil
    }
    
    /// 是否 X 系列机型
    public static var isIPhoneXSeries: Bool {
        var iPhoneXSeries = false
        guard UIDevice.current.userInterfaceIdiom == .phone else { return iPhoneXSeries }
        if #available(iOS 11.0, *) {
            if let w = keyWindow {
                if w.safeAreaInsets.bottom > 0.0  {
                    iPhoneXSeries = true
                }
            }
        }
        return iPhoneXSeries
    }
}
