#import "GSKAirbnbStretchyHeaderView.h"
#import "UIView+GSKLayoutHelper.h"
#import <GSKStretchyHeaderView/GSKGeometry.h>

static const CGFloat kButtonEdge = 64;
static const CGFloat kAnimationDuration = 0.2;
@interface GSKAirbnbSearchView : UIView

@property (nonatomic, readonly) GSKAirbnbSearchViewMode mode;
@property (nonatomic) CGFloat searchFieldLeft;

@property (nonatomic) UIControl *contentControl;
@property (nonatomic) UIImageView *imageView;
@property (nonatomic) UILabel *placeholderLabel;

- (void)setMode:(GSKAirbnbSearchViewMode)mode animated:(BOOL)animated;

@end

@interface GSKAirbnbStretchyHeaderView ()

@property (nonatomic) UIView *statusBarBackground;
@property (nonatomic) UIButton *backButton;
@property (nonatomic) UIImageView *backgroundImageView;
@property (nonatomic) GSKAirbnbSearchView *searchView;
@property (nonatomic) UIView *bottomLine;

@end

@implementation GSKAirbnbStretchyHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self setupSubviews];
        [self setSearchViewMode:GSKAirbnbSearchViewModeButton animated:NO];
    }
    return self;
}

- (void)setupSubviews {
    self.backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"landscape"]];
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.backgroundImageView.clipsToBounds = YES;
    [self.contentView addSubview:self.backgroundImageView];

    self.searchView = [[GSKAirbnbSearchView alloc] initWithFrame:CGRectMake(0, 0, self.width, kButtonEdge)];
    [self.searchView.contentControl addTarget:self action:@selector(didTapSearchButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.searchView];

    self.backButton = [[UIButton alloc] init];
    [self.backButton setTitle:@"<" forState:UIControlStateNormal];
    self.backButton.titleLabel.font = [UIFont boldSystemFontOfSize:24];
    [self.backButton addTarget:self action:@selector(didTapBackButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.backButton];

    self.statusBarBackground = [[UIView alloc] init];
    self.statusBarBackground.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.statusBarBackground];

    self.bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 1)];
    self.bottomLine.backgroundColor = [UIColor colorWithWhite:0.4 alpha:1];
    [self.contentView addSubview:self.bottomLine];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.statusBarBackground.frame = CGRectMake(0, 0, self.contentView.width, 20);

    self.backButton.top = 20;
    self.backButton.size = CGSizeMake(self.contentView.width * 0.14, kButtonEdge);

    self.searchView.searchFieldLeft = self.backButton.right;
    self.searchView.size = CGSizeMake(self.contentView.width, kButtonEdge);
    self.searchView.bottom = self.contentView.height;

    self.backgroundImageView.frame = CGRectMake(0, 0, self.contentView.width, self.contentView.height - self.searchView.height / 2);

    self.bottomLine.width = self.contentView.width;
    self.bottomLine.bottom = self.contentView.bottom;
}

- (void)didChangeStretchFactor:(CGFloat)stretchFactor {
    [super didChangeStretchFactor:stretchFactor];
    GSKAirbnbSearchViewMode mode = self.contentView.height > self.minimumContentHeight ? GSKAirbnbSearchViewModeButton : GSKAirbnbSearchViewModeTextField;
    if (mode != self.searchView.mode) {
        [self setSearchViewMode:mode animated:YES];
    }
}

- (void)setSearchViewMode:(GSKAirbnbSearchViewMode)mode animated:(BOOL)animated {
    _mode = mode;
    [self.searchView setMode:mode animated:animated];
    [UIView animateWithDuration:animated ? kAnimationDuration : 0 animations:^{
        switch (mode) {
            case GSKAirbnbSearchViewModeButton:
                self.backgroundImageView.alpha = 1;
                [self.backButton setTitleColor:[UIColor whiteColor]
                                      forState:UIControlStateNormal];
                self.bottomLine.alpha = 0;
                break;

            case GSKAirbnbSearchViewModeTextField:
                self.backgroundImageView.alpha = 0;
                [self.backButton setTitleColor:[UIColor darkGrayColor]
                                      forState:UIControlStateNormal];
                self.bottomLine.alpha = 1;
                break;
        }
    }];
}

- (void)didTapBackButton:(id)sender {
    [self.delegate airbnbStretchyHeaderView:self didTapBackButton:sender];
}

- (void)didTapSearchButton:(id)sender {
    switch (self.mode) {
        case GSKAirbnbSearchViewModeButton: {
            [self.delegate airbnbStretchyHeaderView:self didTapSearchButton:sender];
            break;
        }
        case GSKAirbnbSearchViewModeTextField: {
            [self.delegate airbnbStretchyHeaderView:self didTapSearchBar:sender];
            break;
        }
    }
}

@end

#pragma mark - Search button

@implementation GSKAirbnbSearchView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    self.contentControl = [[UIControl alloc] initWithFrame:self.bounds];
    self.contentControl.clipsToBounds = YES;
    [self addSubview:self.contentControl];

    UIImage *magnifyingGlass = [[UIImage imageNamed:@"magnifying_glass"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.imageView = [[UIImageView alloc] initWithImage:magnifyingGlass];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentControl addSubview:self.imageView];

    self.placeholderLabel = [[UILabel alloc] init];
    self.placeholderLabel.textColor = [UIColor lightGrayColor];
    self.placeholderLabel.font = [UIFont systemFontOfSize:16];
    self.placeholderLabel.text = @"Where to go?";
    [self.contentControl addSubview:self.placeholderLabel];
}

- (void)setMode:(GSKAirbnbSearchViewMode)mode animated:(BOOL)animated {
    _mode = mode;

    NSTimeInterval animationDuration = animated ? kAnimationDuration : 0;
    UIColor *redColor = [UIColor colorWithRed:0.8 green:0.1 blue:0.1 alpha:1];

    BOOL buttonMode = (mode == GSKAirbnbSearchViewModeButton);
    [UIView animateWithDuration:animationDuration animations:^{
        self.contentControl.backgroundColor = buttonMode ? redColor : [UIColor whiteColor];
        self.imageView.tintColor = buttonMode ? [UIColor whiteColor] : redColor;
        self.placeholderLabel.alpha = buttonMode ? 0 : 1;
        [self layoutSubviews];
    }];

    CGFloat contentControlCornerRadius = buttonMode ? self.contentControl.height / 2 : 0;

    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.fromValue = @(self.contentControl.layer.cornerRadius);
    animation.toValue = @(contentControlCornerRadius);
    animation.duration = animationDuration;
    self.contentControl.layer.cornerRadius = contentControlCornerRadius;
    [self.contentControl.layer addAnimation:animation forKey:@"cornerRadius"];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    switch (self.mode) {
        case GSKAirbnbSearchViewModeButton: {
            self.contentControl.frame = CGRectMake(24, 0, self.height, self.height);
            CGFloat imageWidth = self.contentControl.width * 0.7;
            self.imageView.frame = CGRectMake((self.contentControl.width - imageWidth) / 2, 0,
                                              imageWidth, self.contentControl.height);

            break;
        }
        case GSKAirbnbSearchViewModeTextField: {
            self.contentControl.frame = CGRectMake(self.searchFieldLeft, 0, self.width - self.searchFieldLeft, self.height);
            CGFloat imageWidth = self.contentControl.height * 0.4;
            self.imageView.frame = CGRectMake(0, 0, imageWidth, self.contentControl.height);
            break;
        }
    }

    CGFloat textLeft = self.imageView.right + 8;
    self.placeholderLabel.frame = CGRectMake(textLeft, 0, MAX(self.contentControl.width - textLeft, 0), self.contentControl.height);
}

@end