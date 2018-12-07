#
# Be sure to run `pod lib lint JWCTableViewController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JWCTableViewController'
  s.version          = '0.5.4'
  s.summary          = '快速生成列表的工具，支持header，自动高度和手动高度.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
快速生成列表的类封装，支持header，自动高度和手动高度. 

                       DESC

  s.homepage         = 'https://github.com/Juwencheng/JWCTableViewController'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Juwencheng' => 'juwenz@icloud.com' }
  s.source           = { :git => 'https://github.com/Juwencheng/JWCTableViewController.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'JWCTableViewController/Classes/**/*'
  
  # s.resource_bundles = {
  #   'JWCTableViewController' => ['JWCTableViewController/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
