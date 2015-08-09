Pod::Spec.new do |s|
  s.name             = "AHTextView"
  s.version          = "1.0"
  s.summary          = "UITextView with a placeholder like UITextField"
  s.homepage         = "https://github.com/AndersHqst/AHTextView"
  s.license          = 'MIT'
  s.source           = { :git => "https://github.com/AndersHqst/AHTextView", :tag => s.version }

  s.ios.deployment_target = '8.0'

  s.source_files = 'AHTextView.swift'

  s.requires_arc = true
end