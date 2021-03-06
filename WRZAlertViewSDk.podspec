
Pod::Spec.new do |spec|

  spec.name         = "WRZAlertViewSDk"
  spec.version      = "1.0.0"
  spec.summary      = "iOS alert view . show and hidden with beautiful animation"

  spec.homepage     = "https://github.com/gree180160/WRZAlertView"
  spec.swift_version = '5.0'

  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #spec.license      = "MIT"
 spec.license      = { :type => "MIT", :file => "LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #


  spec.author             = { "gree180160" => "1459287460@qq.com" }


  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  spec.ios.deployment_target  = '10.0'


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #


  spec.source       = { :git => "https://github.com/gree180160/WRZAlertView.git", :tag => "#{spec.version}" }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
 

  spec.source_files  = "WRZAlertView/Cocopodsfiles/**/*.{swift}"
  #spec.exclude_files = "Classes/Exclude"

  # spec.public_header_files = "Classes/**/*.h"


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #



  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  spec.framework  = "UIKit"
  # spec.frameworks = "SomeFramework", "AnotherFramework"

  # spec.library   = "iconv"
  # spec.libraries = "iconv", "xml2"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

spec.requires_arc = true

   spec.dependency "SnapKit"

end
