#
# Be sure to run `pod lib lint MDGroupAvatarView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MDGroupAvatarView'
  s.version          = ‘0.1.0’
  s.summary          = 'A short description of MDGroupAvatarView.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = ‘This library provides a custom UIView with support for showing group of avatars. It’s use for group chat. The images list can be loaded from local or web url. The dependency CocoaPod is SDWebImage’

  s.homepage         = 'https://github.com/ttmdung203/MDGroupAvatarView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'dungttm' => 'dungttm@vng.com.vn' }
  s.source           = { :git => 'https://github.com/ttmdung203/MDGroupAvatarView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'MDGroupAvatarView/Classes/**/*'
  
  # s.resource_bundles = {
  #   'MDGroupAvatarView' => ['MDGroupAvatarView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
    s.dependency 'SDWebImage', '~>3.8'
end
