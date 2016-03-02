# GSKStretchyHeaderView

[![CI Status](https://travis-ci.org/gskbyte/GSKStretchyHeaderView.svg?branch=master)](https://travis-ci.org/Jose Alcalá Correa/GSKStretchyHeaderView)
[![Version](https://img.shields.io/cocoapods/v/GSKStretchyHeaderView.svg?style=flat)](http://cocoapods.org/pods/GSKStretchyHeaderView)
[![License](https://img.shields.io/cocoapods/l/GSKStretchyHeaderView.svg?style=flat)](http://cocoapods.org/pods/GSKStretchyHeaderView)
[![Platform](https://img.shields.io/cocoapods/p/GSKStretchyHeaderView.svg?style=flat)](http://cocoapods.org/pods/GSKStretchyHeaderView)

![Example 1](https://raw.githubusercontent.com/gskbyte/GSKStretchyHeaderView/master/screenshots/airbnb.gif)
![Example 2](https://raw.githubusercontent.com/gskbyte/GSKStretchyHeaderView/master/screenshots/stretchy_blur.gif)
![Example 3](https://raw.githubusercontent.com/gskbyte/GSKStretchyHeaderView/master/screenshots/stretchy_tabs.gif)
![Example 4](https://raw.githubusercontent.com/gskbyte/GSKStretchyHeaderView/master/screenshots/stretchy_nib.gif)

GSKStretchyHeaderView is an implementation of the stretchy header paradigm as seen on the Twitter app or the Spotify app. It's designed in order to accomplish the following requirements:

- Compatibility with `UITableView` and `UICollectionView`
- Provide support for frame layout, auto layout and Interface Builder `.xib` files
- No need to subclass a custom view controller or to use a custom `UICollectionViewLayout`
- Simple usage: just implement your own subclass and add it to your `UIScrollView` subclass

## Usage

To add a stretchy header to your table or collection view, you just have to do this:

```objc
- (void)viewDidLoad {
    [super viewDidLoad];
    CGSize headerSize = CGSizeMake(self.tableView.frame.size.width, 200); // 200 will be the default height
    self.stretchyHeader = [[GSKStretchyHeaderViewSubclass alloc] initWithFrame:CGRectMake(0, 0, headerSize.width, headerSize.height)];
    self.stretchyHeader.delegate = self; // this is completely optional
    [self.tableView addSubview:self.stretchyHeader];
}
```
or
```objc
- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray<UIView *> *nibViews = [[NSBundle mainBundle] loadNibNamed:@"GSKTabsStretchyHeaderView"
                                                                owner:self
                                                              options:nil];
    self.stretchyHeaderView = nibViews.firstObject;
    [self.tableView addSubview:self.stretchyHeaderView];
}
```

## Creating your stretchy header

There are two ways to create your own stretchy header:

- Create a stretchy header subclass and add subviews to its `contentView`. You can layout its subviews with manual layouting (by using frames) or with Auto Layout.
- Create an Interface Builder file and map it to your `GSKStretchyHeaderView` subclass. Subviews added to the stretchy header will be automatically moved to the content view, keeping their constraints. Remember to set the property `initialHeight` in the attributes inspector (fourth tab on the right panel in Interface Builder).

To modify the behaviour and layout of your stretchy header, just override the method `-didChangeStretchFactor:` in your subclass, where you can adjust it by using the `stretchFactor`. To get a more detailed description of the properties, please have a look at the source code. There are also a few usage examples in the example project. You can also take them as a reference for your own stretchy headers.

## Example project

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

GSKStretchyHeaderView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "GSKStretchyHeaderView"
```

## Author

Jose Alcalá Correa, jose.alcala.correa@gmail.com

## License

GSKStretchyHeaderView is available under the MIT license. See the LICENSE file for more info.
