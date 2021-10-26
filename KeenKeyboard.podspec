
Pod::Spec.new do |s|
  s.name          = 'KeenKeyboard'
  s.version       = '1.0.0'
  s.summary       = '自定义安全键盘, 一行代码即可接入, 对业务无侵入, 支持数字、金额、身份证等常见样式'
  s.homepage      = 'https://github.com/chongzone/KeenKeyboard'
  s.license       = { :type => 'MIT', :file => 'LICENSE' }
  s.author        = { 'chongzone' => 'chongzone@163.com' }
  
  s.requires_arc  = true
  s.swift_version = '5.0'
  s.ios.deployment_target = '9.0'
  s.source = { :git => 'https://github.com/chongzone/KeenKeyboard.git', :tag => s.version }
  
  s.source_files = 'KeenKeyboard/Classes/**/*'
  s.resource_bundles = {
    'KeenKeyboard' => ['KeenKeyboard/Assets/*.png']
  }

end
