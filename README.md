# GSKStretchyHeaderView, by [gskbyte](https://twitter.com/gskbyte)

[![License](https://img.shields.io/cocoapods/l/GSKStretchyHeaderView.svg?style=flat)](http://cocoapods.org/pods/GSKStretchyHeaderView)
[![Platform](https://img.shields.io/cocoapods/p/GSKStretchyHeaderView.svg?style=flat)](http://cocoapods.org/pods/GSKStretchyHeaderView)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Version](https://img.shields.io/cocoapods/v/GSKStretchyHeaderView.svg?style=flat)](http://cocoapods.org/pods/GSKStretchyHeaderView)

[![CI Status](https://travis-ci.org/gskbyte/GSKStretchyHeaderView.svg?branch=master)](https://travis-ci.org/gskbyte/GSKStretchyHeaderView)
[![Coverage](https://coveralls.io/repos/github/gskbyte/GSKStretchyHeaderView/badge.svg)](https://coveralls.io/github/gskbyte/GSKStretchyHeaderView)

![Example 1](https://raw.githubusercontent.com/gskbyte/GSKStretchyHeaderView/master/screenshots/airbnb_small.gif)
![Example 2](https://raw.githubusercontent.com/gskbyte/GSKStretchyHeaderView/master/screenshots/stretchy_blur_small.gif)
![Example 3](https://raw.githubusercontent.com/gskbyte/GSKStretchyHeaderView/master/screenshots/tabs_small.gif)
![Example 4](https://raw.githubusercontent.com/gskbyte/GSKStretchyHeaderView/master/screenshots/twitter_small.gif)
![Example 5](https://raw.githubusercontent.com/gskbyte/GSKStretchyHeaderView/master/screenshots/scalable_text_small.gif)

GSKStretchyHeaderView is an implementation of the stretchy header paradigm as seen on many apps, like Twitter, Spotify or airbnb. It's designed in order to accomplish the following requirements:

- Compatibility with `UITableView` and `UICollectionView`
- Data source and delegate independency: can be added to an existing view controller withouth interfering with your existing `delegate` or `dataSource`
- Provide support for frame layout, auto layout and Interface Builder `.xib` files
- No need to subclass a custom view controller or to use a custom `UICollectionViewLayout`
- Simple usage: just implement your own subclass and add it to your `UIScrollView` subclass
- Two expansion modes: the header view can grow only when the top of the scroll view is reached, or as soon as the user scrolls down.

If you are using this library in your project, I would be more than glad to [know about it!](mailto:gskbyte@gmail.com)

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

## Configuration

You can change multiple parameters in your stretchy header view:

```objc
// you can change wether it expands at the top or as soon as you scroll down
headerView.expansionMode = GSKStretchyHeaderViewExpansionModeImmediate;

// You can change the minimum and maximum content heights
headerView.minimumContentHeight = 64; // you can replace the navigation bar with a stretchy header view
headerView.maximumContentHeight = 280;

// You can specify if the content expands when the table view bounces, and if it shrinks if contentView.height < maximumContentHeight. This is specially convenient if you use auto layout inside the stretchy header view
headerView.contentShrinks = YES;
headerView.contentExpands = NO; // useful if you want to display the refreshControl below the header view

// You can specify wether the content view sticks to the top or the bottom of the header view if one of the previous properties is set to NO
// In this case, when the user bounces the scrollView, the content will keep its height and will stick to the bottom of the header view
headerView.contentAnchor = GSKStretchyHeaderViewContentAnchorBottom;
```

## Creating your stretchy header

There are two ways to create your own stretchy header:

- Create a stretchy header subclass and add subviews to its `contentView`. You can layout its subviews manipulating their frames or using Auto Layout (also works with [GranadaLayout](https://github.com/gskbyte/GranadaLayout) :trollface:).
- Create an Interface Builder file and map it to your `GSKStretchyHeaderView` subclass. Subviews added to the stretchy header will be automatically moved to the content view, keeping their constraints. Remember to set the properties `maximumContentHeight` and `minimumContentHeight` in the attributes inspector (fourth tab on the right panel in Interface Builder).

To modify the behaviour and layout of your stretchy header, just override the method `-didChangeStretchFactor:` in your subclass, where you can adjust it by using the `stretchFactor`. To get a more detailed description of the properties, please have a look at the source code. There are also a few usage examples in the example project. You can also take them as a reference for your own stretchy headers.

## Example project

To run the example project, clone the repo and open the workspace file `GSKStretchyHeaderView.xcworkspace`.

You can also use `pod try GSKStretchyHeaderView`.

## Installation

GSKStretchyHeaderView is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile, [you can check the Example Podfile to see how it looks like](https://github.com/gskbyte/GSKStretchyHeaderView/blob/master/Example/Podfile):

```ruby
pod "GSKStretchyHeaderView"
```


GSKStretchyHeaderView is also available through [Carthage](). To install it, just add this line to your `Cartfile:
```
github "gskbyte/GSKStretchyHeaderView"
```
and run
```bash
carthage update GSKStretchyHeaderView
```

## Author

Jose Alcalá Correa, jose.alcala.correa@gmail.com

## License

GSKStretchyHeaderView is available under the MIT license. See the LICENSE file for more info.

## [Changelog](https://github.com/gskbyte/GSKStretchyHeaderView/blob/master/CHANGELOG.md)
