
Pod::Spec.new do |s|
  s.name         = "JXTheme"
  s.version = "0.0.6"
  s.summary      = "A powerful and lightweight and customization theme/skin library for iOS 9+ in swift. 主题、换肤、暗黑模式"
  s.homepage     = "https://github.com/pujiaxin33/JXTheme"
  s.license      = "MIT"
  s.author       = { "pujiaxin33" => "317437084@qq.com" }
  s.platform     = :ios, "9.0"
  s.swift_version = "5.0"
  s.source       = { :git => "https://github.com/pujiaxin33/JXTheme.git", :tag => "#{s.version}" }
  s.framework    = "UIKit"
  s.source_files  = "Sources", "Sources/*.{swift}"
  s.requires_arc = true
end
