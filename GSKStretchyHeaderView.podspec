Pod::Spec.new do |s|
  s.name             = "GSKStretchyHeaderView"
  s.version          = "0.12.0"
  s.summary          = "A generic, easy to use stretchy header view for UITableView and UICollectionView"
  s.description      = <<-DESC
                       GSKStretchyHeaderView allows you to add a stretchy header view (like Twitter's or Spotify's) to any existing UITableView and UICollectionView. There is no need inherit from custom view controllers, just create your custom header view and add it to your UITableView or UICollectionView. Creating a custom stretchy header view is as easy as inheriting from the base class or using Interface Builder.
                       DESC
  s.homepage         = "https://github.com/gskbyte/GSKStretchyHeaderView"
  s.screenshots      = "https://raw.githubusercontent.com/gskbyte/GSKStretchyHeaderView/master/screenshots/spoty_default.jpg", "https://raw.githubusercontent.com/gskbyte/GSKStretchyHeaderView/master/screenshots/gradient.jpg"
  s.license          = 'MIT'
  s.author           = { "Jose Alcalá Correa" => "jose.alcala.correa@gmail.com" }
  s.source           = { :git => "https://github.com/gskbyte/GSKStretchyHeaderView.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/gskbyte'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.private_header_files = 'Pod/Classes/Private/*.h'
end
