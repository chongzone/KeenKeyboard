![KeenKeyboard](https://raw.githubusercontent.com/chongzone/KeenKeyboard/master/Resources/KeenKeyboardLogo.png)

![CI Status](https://img.shields.io/travis/chongzone/KeenKeyboard.svg?style=flat)
![](https://img.shields.io/badge/swift-5.0%2B-orange.svg?style=flat)
![](https://img.shields.io/badge/pod-v1.0.2-brightgreen.svg?style=flat)
![](https://img.shields.io/badge/platform-iOS-orange.svg?style=flat)
![](https://img.shields.io/badge/license-MIT-blue.svg)

## 效果样式 

样式说明 | Gif 图 |
----|------|
数字键盘 |  <img src="https://raw.githubusercontent.com/chongzone/KeenKeyboard/master/Resources/Keyboard_01.gif" width="318" height="315"> |
数字键盘2 |  <img src="https://raw.githubusercontent.com/chongzone/KeenKeyboard/master/Resources/Keyboard_02.gif" width="318" height="315"> |
数字键盘3 |  <img src="https://raw.githubusercontent.com/chongzone/KeenKeyboard/master/Resources/Keyboard_03.gif" width="318" height="315"> |
金额键盘 |  <img src="https://raw.githubusercontent.com/chongzone/KeenKeyboard/master/Resources/Keyboard_04.gif" width="318" height="315"> |
身份证键盘 |  <img src="https://raw.githubusercontent.com/chongzone/KeenKeyboard/master/Resources/Keyboard_05.gif" width="318" height="315"> |

## API 说明

- [x] 自定义安全键盘, 支持数字、金额、身份证等常见的键盘样式等 
- [x] 一行代码即可接入, 对业务无侵入，可针对不同场景按需配置其属性参数

支持的键盘样式
```ruby
enum Style {
    /// 数字样式
    case number
    /// 金额样式 数字 & 小数点
    case decimal
    /// 身份证样式 数字 & X
    case identityCard
}
```

支持的布局样式
```ruby
enum LayoutMode {
    /// 分割线
    case separator
    /// 固定(间隔固定 等分布局)
    case fixed
}
```

在属性参数对象 `KeenKeyboardAtrributes` 中可查看支持定制的参数属性
```ruby
// ...

/// 样式  默认 number
public var style: KeenKeyboardAtrributes.Style = .number
/// 布局样式 默认 fixed
public var layout: KeenKeyboardAtrributes.LayoutMode = .fixed

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

// ...
```

在属性参数对象 `KeenAccessoryAtrributes` 中可查看支持定制的参数属性
```ruby
// ...

/// 是否添加阴影 默认 false
public var showShadow: Bool = false
/// 阴影颜色 默认 #848688
public var shadowColor: UIColor = UIColor.color(hexString: "#848688")
/// 阴影透明度 默认 0.15
public var shadowOpacity: Float = 0.15

// ...

/// 标题
public var title: String = "KEEN安全键盘"
/// 标题字体 默认常规 15pt
public var titleFont: UIFont = UIFont.systemFont(ofSize: 15, weight: .regular)
/// 标题颜色 默认 #666666
public var titleColor: UIColor = UIColor.color(hexString: "#666666")

// ...
```

## 使用介绍

### `KeenKeyboard` 示例

```ruby
let field = UITextField(frame: xxx)
    .backColor(.orange)
    .addViewTo(view)

/// 方式 1 绑定自定义键盘
KeenKeyboard.bindCustomKeyboard(field: field, delegate: self)

/// 方式 2 绑定自定义键盘
field.bindCustomKeyboard(delegate: self)
```

### `KeenKeyboardDelegate` 代理

```ruby
/// 输入事件
func insert(_ keyboard: KeenKeyboard, text: String)

/// 删除事件
func delete(_ keyboard: KeenKeyboard, text: String)

/// 其他事件 仅对 number 样式生效
func other(_ keyboard: KeenKeyboard, text: String)

/// 属性参数 不设置取默认值
/// - Returns: 属性对象
func attributesOfKeyboard(for keyboard: KeenKeyboard) -> KeenKeyboardAtrributes
```
> 具体可下载查看源码实现 

### `KeenAccessoryView` 示例

```ruby
/// 方式 1 绑定键盘附件 View
KeenAccessoryView.bindAccessoryView(height: 45, delegate: self, field: field)

/// 方式 2 绑定键盘附件 View
field.bindAccessoryView(height: 45, delegate: self)
```

### `KeenAccessoryViewDelegate` 代理

```ruby
/// 属性参数 不设置取默认值
/// - Returns: 属性对象
func attributesOfAccessoryView(for accessoryView: KeenAccessoryView) -> KeenAccessoryAtrributes

/// 回调事件 优先级高于闭包回调
func complete(_ accessoryView: KeenAccessoryView)
```
> 具体可下载查看源码实现 

## 安装方式 

### CocoaPods

```ruby
platform :ios, '9.0'
use_frameworks!

target 'TargetName' do

pod 'KeenKeyboard'

end
```
> `iOS` 版本要求 `9.0+`
> `Swift` 版本要求 `5.0+`

## Contact Me

QQ: 2209868966
邮箱: chongzone@163.com

> 若在使用过程中遇到什么问题, 请 `issues` 我, 看到之后会尽快修复 

## License

KeenKeyboard is available under the MIT license. [See the LICENSE](https://github.com/chongzone/KeenKeyboard/blob/main/LICENSE) file for more info.
