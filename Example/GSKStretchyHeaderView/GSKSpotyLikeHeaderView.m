#import "GSKSpotyLikeHeaderView.h"
#import "UIView+GSKLayoutHelper.h"
#import <GSKStretchyHeaderView/GSKGeometry.h>
#import <Masonry/Masonry.h>

static const CGSize kUserImageSize = {.width = 64, .height = 64};

@interface GSKSpotyLikeHeaderView ()

@property (nonatomic) UIImageView *backgroundImageView;
@property (nonatomic) UIImageView *blurredBackgroundImageView;
@property (nonatomic) UIImageView *userImageView; // redondear y fondo blanco
@property (nonatomic) UILabel *title;
@property (nonatomic) UIButton *followButton;

@end

@implementation GSKSpotyLikeHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.minimumContentHeight = 64;
        self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:1];
        [self setupViews];
        [self setupViewConstraints];
    }
    return self;
}

- (void)setupViews {
    self.backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"landscape"]];
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.backgroundImageView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.backgroundImageView];

    self.blurredBackgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"landscape_blur"]];
    self.blurredBackgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.blurredBackgroundImageView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.blurredBackgroundImageView];

    self.userImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"artist"]];
    self.userImageView.clipsToBounds = YES;
    self.userImageView.layer.cornerRadius = kUserImageSize.width / 2;
    self.userImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.userImageView.layer.borderWidth = 4;
    [self.contentView addSubview:self.userImageView];

    self.title = [[UILabel alloc] init];
    self.title.text = @"Very important artist";
    self.title.textColor = [UIColor whiteColor];
    self.title.font = [UIFont boldSystemFontOfSize:20];
    [self.contentView addSubview:self.title];

    self.followButton = [[UIButton alloc] init];
    [self.followButton setTitle:@"  FOLLOW  " forState:UIControlStateNormal];
    self.followButton.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.8];
    self.followButton.titleLabel.font = [UIFont boldSystemFontOfSize:10];
    self.followButton.layer.cornerRadius = 4;
    self.followButton.layer.borderWidth = 1;
    self.followButton.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.followButton addTarget:self
                          action:@selector(didTapFollowButton:)
                forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.followButton];
}

- (void)setupViewConstraints {
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.width.equalTo(self.contentView.mas_width);
        make.height.equalTo(self.contentView.mas_height);
    }];

    [self.blurredBackgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.backgroundImageView);
    }];

    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.centerY.equalTo(self.contentView.mas_centerY).offset(-10);
        make.width.equalTo(@(kUserImageSize.width));
        make.height.equalTo(@(kUserImageSize.height));
    }];

    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.top.equalTo(self.userImageView.mas_bottom).offset(10);
    }];

    [self.followButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.top.equalTo(self.title.mas_bottom).offset(10);
    }];

}

- (void)didChangeStretchFactor:(CGFloat)stretchFactor {
    CGFloat alpha = 1;
    CGFloat blurAlpha = 1;
    if (stretchFactor > 1) {
        alpha = CGFloatTranslateRange(stretchFactor, 1, 1.12, 1, 0);
        blurAlpha = alpha;
    } else if (stretchFactor < 0.8) {
        alpha = CGFloatTranslateRange(stretchFactor, 0.2, 0.8, 0, 1);
    }

    alpha = MAX(0, alpha);
    self.blurredBackgroundImageView.alpha = blurAlpha;
    self.userImageView.alpha = alpha;
    self.title.alpha = alpha;
    self.followButton.alpha = alpha;
}

- (void)didTapFollowButton:(id)sender {
    [self.followButton setTitle:@"  FOLLOWING  " forState:UIControlStateNormal];
}

@end
