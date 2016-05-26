# GSKStretchyHeaderView

[![License](https://img.shields.io/cocoapods/l/GSKStretchyHeaderView.svg?style=flat)](http://cocoapods.org/pods/GSKStretchyHeaderView)
[![Platform](https://img.shields.io/cocoapods/p/GSKStretchyHeaderView.svg?style=flat)](http://cocoapods.org/pods/GSKStretchyHeaderView)

Master: 
[![CI Status](https://travis-ci.org/gskbyte/GSKStretchyHeaderView.svg?branch=master)](https://travis-ci.org/gskbyte/GSKStretchyHeaderView)

Latest stable: 
[![Version](https://img.shields.io/cocoapods/v/GSKStretchyHeaderView.svg?style=flat)](http://cocoapods.org/pods/GSKStretchyHeaderView)

![Example 1](https://raw.githubusercontent.com/gskbyte/GSKStretchyHeaderView/master/screenshots/airbnb_small.gif)
![Example 2](https://raw.githubusercontent.com/gskbyte/GSKStretchyHeaderView/master/screenshots/stretchy_blur_small.gif)
![Example 3](https://raw.githubusercontent.com/gskbyte/GSKStretchyHeaderView/master/screenshots/tabs_small.gif)
![Example 4](https://raw.githubusercontent.com/gskbyte/GSKStretchyHeaderView/master/screenshots/twitter_small.gif)
![Example 5](https://raw.githubusercontent.com/gskbyte/GSKStretchyHeaderView/master/screenshots/scalable_text_small.gif)

GSKStretchyHeaderView is an implementation of the stretchy header paradigm as seen on many apps, like Twitter, Spotify or airbnb. It's designed in order to accomplish the following requirements:

- Compatibility with `UITableView` and `UICollectionView`
- Data source and delegate independency: can be added to an existing view controller
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

## Author

Jose Alcalá Correa, jose.alcala.correa@gmail.com

## License

GSKStretchyHeaderView is available under the MIT license. See the LICENSE file for more info.

## Changelog

### 0.10.0

- Move `UIView+GSKLayoutHelper` to the example project, because its functionality shouldn't belong to the library and the method names may collide with others
- Add a new example resizing a `UILabel`

### 0.9.0

- Simplify internal code thanks to [`KVOController`](https://github.com/facebook/KVOController)
- Add lots of tests (coverage **above 94%**)
- Add Twitter example
- Fix a couple of smaller issues

### 0.8.2

- Make stretchy header view stay always on top, so that section headers and footers do not overlap it.

### 0.8.1

- `contentInset` recalculation bugfixes
- Add airbnb-like example

### 0.8.0 Improved API

- Add new anchorMode
- Add `contentInset` property
- Add code documentation
- Unify stretchFactor properties

### 0.7.0 Initial version

- Initial working version
