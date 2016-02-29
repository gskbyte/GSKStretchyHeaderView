Pod::Spec.new do |s|
  s.name             = "GSKStretchyHeaderView"
  s.version          = "0.1.0"
  s.summary          = "A short description of GSKStretchyHeaderView."

  s.description      = "A generic, easy to use stretchy header view for UITableView and UICollectionView"
  s.homepage         = "https://github.com/gskbyte/GSKStretchyHeaderView"
  s.screenshots      = "https://github.com/gskbyte/GSKStretchyHeaderView/screenshots/spoty_default.jpg", "https://github.com/gskbyte/GSKStretchyHeaderView/screenshots/gradient.jpg"
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
end
