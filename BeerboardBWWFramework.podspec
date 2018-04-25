#
#  Be sure to run `pod spec lint BeerboardBWWFramework.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "BeerboardBWWFramework"

  s.version      = "0.1.4"

  s.summary      = "It Contains menu button along with Beerchip view. In beerchipView we have a View/Redeem button, which will open the pod functionality"


  s.description  = "This framework contains Menu button and  beerchip view. Beerchip view contains View/Redeem button. if we click this button, the actual pod functionality will open. and the menu button will show the available Menu Options."

 s.homepage     = "http://vmokshagroup.com"

  s.license      = "MIT"

  s.author       = { "Srinivasulu3264" => "srinivasulu.budharapu@vmokshagroup.com" }

  s.platform     = :ios, "9.0"

  s.ios.deployment_target = "11.0"

   s.source       = { :git => "https://github.com/Srinivasulu3264/BeerboardBWWFramework.git", :tag => "0.1.4" }

  s.source_files  = "BeerboardBWWFramework", "BeerboardBWWFramework/**/*.{h,m, swift}"

  s.resources = "BeerboardBWWFramework/**/*.{xcassets,png,jpeg,jpg,storyboard,xib}"

  s.resource_bundle = {
     'BeerboardBWWFramework' => 
        'BeerboardBWWFramework/**/*.{xcassets,png,jpeg,jpg,storyboard,xib}'
   }


  s.framework  = "UIKit"

  s.requires_arc = true

  `echo "3.2" > .swift-version`


end
