#import "GSKTestStretchyHeaderView.h"
#import "GSKGradientView.h"
#import "UIView+GSKLayoutHelper.h"
#import "GSKGeometry.h"

@interface GSKTestStretchyHeaderView ()
@property (nonatomic) GSKGradientView *gradientView;
@property (nonatomic) UIImageView *imageView;
@property (nonatomic) UIButton *button;
@end

@implementation GSKTestStretchyHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.stretchContentView = YES;
        self.minimumHeight = 64;
        [self setupGradient];
        [self setupImageView];
        [self setupButton];
    }
    return self;
}

- (void)setupGradient {
    self.gradientView = [[GSKGradientView alloc] initWithFrame:self.contentView.frame];
    self.gradientView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.contentView addSubview:self.gradientView];
}

- (void)setupImageView {
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lab"]];
    [self.contentView addSubview:self.imageView];
}

- (void)setupButton {
    self.button = [[UIButton alloc] init];
    [self.button setTitle:@"I'm a button"
                 forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor whiteColor]
                      forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor lightGrayColor]
                      forState:UIControlStateHighlighted];
    [self.button addTarget:self
                    action:@selector(didTapButton:)
          forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.button];
    [self.button sizeToFit];
}


- (void)layoutSubviews {
    [super layoutSubviews];

    CGFloat normalizedStretchFactor = self.normalizedStretchFactor;
    CGFloat limitedStretchFactor = MIN(1, normalizedStretchFactor);

    CGSize minImageSize = CGSizeMake(32, 32);
    CGSize maxImageSize = CGSizeMake(96, 96);
    CGPoint minImageOrigin = CGPointMake(12, 20);
    CGPoint maxImageOrigin = CGPointMake((self.contentView.width - maxImageSize.width) / 2, 32);

    self.imageView.size = CGSizeInterpolate(limitedStretchFactor, minImageSize, maxImageSize);
    self.imageView.left = CGFloatInterpolate(limitedStretchFactor, minImageOrigin.x, maxImageOrigin.x);
    self.imageView.top = CGFloatInterpolate(normalizedStretchFactor, minImageOrigin.y, maxImageOrigin.y);

    self.button.top = CGFloatInterpolate(normalizedStretchFactor,
                                         self.imageView.centerY - self.button.height / 2,
                                         self.imageView.bottom + 8);
    self.button.left = CGFloatInterpolate(limitedStretchFactor,
                                          minImageOrigin.x + minImageSize.width + 12,
                                          self.contentView.width / 2 - self.button.width / 2);
}

- (void)didTapButton:(id)sender {
    NSLog(@"tap!");
}

@end
