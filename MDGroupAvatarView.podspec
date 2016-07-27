#
# Be sure to run `pod lib lint MDGroupAvatarView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MDGroupAvatarView'
  s.version          = '0.0.3'
  s.summary          = 'Custom UIView show group of avatar'
  s.description      = 'This library provides a custom UIView with support for showing group of avatars. It’s use for group chat. The images list can be loaded from local or web url. The dependency CocoaPod is SDWebImage'

  s.homepage         = 'https://github.com/ttmdung203/MDGroupAvatarView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ttmdung203' => 'ttmdung203@gmail.com' }
  s.source           = { :git => 'https://github.com/ttmdung203/MDGroupAvatarView.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'MDGroupAvatarView/Classes/**/*'
  s.dependency 'SDWebImage', '~>3.8'
end
