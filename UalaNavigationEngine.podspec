Pod::Spec.new do |s|
  s.name             = 'UalaNavigationEngine'
  s.version          = '0.4.3'
  s.summary          = 'Loans module'
  s.swift_version    = '5.4'
  s.description      = 'Module for Uala Navigation Engine'

  s.homepage         = 'git@github.com:mike-uala/uala-navigation-engine-ios.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Ignacio' => 'ignacio.gomez@uala.com.ar' }
  s.source           = { :git => 'git@github.com:mike-uala/uala-navigation-engine-ios.git', :tag => s.version.to_s }
  
  s.ios.deployment_target = '11.0'
  
  s.source_files = 'UalaLoans/Classes/**/*'
  s.resource_bundles = {
      'Loans' => [
      'UalaLoans/Classes/**/*.xib',
      'UalaLoans/Assets/*.strings',
      'UalaLoans/Assets/*.xcassets',
      'UalaLoans/Assets/*.plist'
      ]
  }
  
  s.dependency 'Stateful'
end
