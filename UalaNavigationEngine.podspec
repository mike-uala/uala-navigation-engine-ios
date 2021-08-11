Pod::Spec.new do |s|
  s.name             = 'UalaNavigationEngine'
  s.version          = '1.0.1'
  s.summary          = 'UalaNavigationEngine Module'
  s.description      = 'Framework to handler navigation e.g deep links'
  s.swift_version    = '5.4'

  s.homepage         = 'https://medium.com/@shahabejaz/create-and-distribute-private-libraries-with-cocoapods-5b6507b57a03'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'mike-uala' => 'miguel.olmedo@ua.la' }
  s.source           = { :git => 'https://github.com/mike-uala/uala-navigation-engine-ios.git', :tag => s.version.to_s }


  s.ios.deployment_target = '11.0'



  s.source_files = 'UalaNavigationEngine/Classes/**/*'
  
  # s.resource_bundles = {
  #   'UalaNavigationEngine' => ['UalaNavigationEngine/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'Stateful'
  s.dependency 'PromiseKit'
end


