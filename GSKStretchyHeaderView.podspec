#
# Be sure to run `pod lib lint GSKStretchyHeaderView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "GSKStretchyHeaderView"
  s.version          = "0.1.0"
  s.summary          = "A short description of GSKStretchyHeaderView."

  s.description      = <<-DESC
                       DESC

  s.homepage         = "https://github.com/<GITHUB_USERNAME>/GSKStretchyHeaderView"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Jose Alcalá Correa" => "jose.alcala@xing.com" }
  s.source           = { :git => "https://github.com/gskbyte/GSKStretchyHeaderView.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/gskbyte'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'GSKStretchyHeaderView' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
end
