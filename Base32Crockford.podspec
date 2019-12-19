#
# Be sure to run `pod lib lint Base32Crockford.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Base32Crockford'
  s.version          = '0.1.0'
  s.summary          = 'Generate, encode, and decode data in a Base32 format.'
  s.swift_version    = '4.2.1'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Using Douglas Crockford's Base32 encoding (https://www.crockford.com/wrmg/base32.html), this library can generate, encode, and decode data in a Base32 format.
                       DESC

  s.homepage         = 'https://github.com/brightdigit/Base32Crockford'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'leogdion@brightdigit.com' => 'leogdion@brightdigit.com' }
  s.source           = { :git => 'https://github.com/brightdigit/Base32Crockford.git' }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>

  s.source_files = 'Sources/Base32Crockford/**/*'
  s.ios.deployment_target = '8'
  s.osx.deployment_target = '10.9'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '2.0'
  # s.build_settings['EXPANDED_CODE_SIGN_IDENTITY'] = ""
  # s.build_settings['CODE_SIGNING_REQUIRED'] = "NO"
  # s.build_settings['CODE_SIGNING_ALLOWED'] = "NO"

  # s.resource_bundles = {
  #   'Base32Crockford' => ['Base32Crockford/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
