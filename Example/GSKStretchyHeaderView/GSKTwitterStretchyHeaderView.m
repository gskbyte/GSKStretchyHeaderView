#import "GSKTwitterStretchyHeaderView.h"
#import "UIView+GSKLayoutHelper.h"
#import <Masonry/Masonry.h>
#import <GSKStretchyHeaderView/GSKGeometry.h>

static const CGFloat kMaxImageSize = 64;
static const CGFloat kMinImageSize = 42;
static const CGFloat kMinHeaderImageHeight = 64;
static const CGFloat kNavigationTitleTop = 30;

@interface GSKTwitterStretchyHeaderView ()

@property (nonatomic) UIView *navigationBar;
@property (nonatomic) UIImageView *navigationBackground;
@property (nonatomic) UILabel *navigationBarTitle;
@property (nonatomic) UIButton *backButton;
@property (nonatomic) UIButton *searchButton;
@property (nonatomic) UIButton *writeButton;

@property (nonatomic) UIImageView *headerImageView;
@property (nonatomic) UIImageView *userImageView;
@property (nonatomic) UIButton *followButton;
@property (nonatomic) UILabel *realNameLabel;
@property (nonatomic) UILabel *nicknameLabel;
@property (nonatomic) UILabel *descriptionLabel;
@property (nonatomic) UILabel *infoLabel;
@property (nonatomic) UILabel *statsLabel;
@property (nonatomic) UISegmentedControl *tabs;

@property (nonatomic) CGFloat initialHeaderImageHeight;
@property (nonatomic) BOOL headerImageOnTop;

@end

@implementation GSKTwitterStretchyHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];

        [self setupHeaderImageView];
        [self setupUserImageView];
        [self setupFollowButton];
        [self setupLabels];
        [self setupTabs];
        [self setupNavigationBar];

        [self setupConstraints];

        self.maximumContentHeight = 360;
        self.minimumContentHeight = 106;

        [self fillSubviews];
    }
    return self;
}

- (void)setupNavigationBar {
    self.navigationBar = [[UIView alloc] init];
    self.navigationBar.clipsToBounds = YES;
    [self.contentView addSubview:self.navigationBar];

    self.navigationBackground = [[UIImageView alloc] init];
    self.navigationBackground.contentMode = UIViewContentModeScaleAspectFill;
    self.navigationBackground.clipsToBounds = YES;
    [self.navigationBar addSubview:self.navigationBackground];

    self.navigationBarTitle = [[UILabel alloc] init];
    self.navigationBarTitle.textColor = [UIColor whiteColor];
    self.navigationBarTitle.font = [UIFont boldSystemFontOfSize:16];
    [self.navigationBar addSubview:self.navigationBarTitle];

    self.backButton = [[UIButton alloc] init];
    [self.backButton setTitle:@"<" forState:UIControlStateNormal];
    [self.backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.backButton.titleLabel.font = [UIFont boldSystemFontOfSize:24];
    self.backButton.contentEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
    [self.backButton addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationBar addSubview:self.backButton];

    self.writeButton = [[UIButton alloc] init];
    [self.writeButton setImage:[UIImage imageNamed:@"write"] forState:UIControlStateNormal];
    [self.navigationBar addSubview:self.writeButton];

    self.searchButton = [[UIButton alloc] init];
    [self.searchButton setImage:[UIImage imageNamed:@"magnifying_glass"] forState:UIControlStateNormal];
    [self.navigationBar addSubview:self.searchButton];
}

- (void)setupHeaderImageView {
    self.headerImageView = [[UIImageView alloc] init];
    self.headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.headerImageView.clipsToBounds = YES;
    [self.contentView addSubview:self.headerImageView];
}

- (void)setupUserImageView {
    self.userImageView = [[UIImageView alloc] init];
    self.userImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.userImageView.clipsToBounds = YES;
    self.userImageView.layer.cornerRadius = 8;
    self.userImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.userImageView.layer.borderWidth = 4;
    [self.contentView addSubview:self.userImageView];
}

- (void)setupFollowButton {
    self.followButton = [[UIButton alloc] init];
    self.followButton.backgroundColor = [UIColor colorWithRed:0.0 green:0.4 blue:0.8 alpha:1];
    self.followButton.contentEdgeInsets = UIEdgeInsetsMake(4, 8, 4, 8);
    self.followButton.clipsToBounds = YES;
    self.followButton.layer.cornerRadius = 4;
    [self.contentView addSubview:self.followButton];
}

- (void)setupLabels {
    self.realNameLabel = [[UILabel alloc] init];
    self.realNameLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.contentView addSubview:self.realNameLabel];

    self.nicknameLabel = [[UILabel alloc] init];
    self.nicknameLabel.font = [UIFont systemFontOfSize:12];
    self.nicknameLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.nicknameLabel];

    self.descriptionLabel = [[UILabel alloc] init];
    self.descriptionLabel.numberOfLines = 3;
    self.descriptionLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.descriptionLabel];

    self.infoLabel = [[UILabel alloc] init];
    self.infoLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.infoLabel];

    self.statsLabel = [[UILabel alloc] init];
    self.statsLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.statsLabel];
}

- (void)setupTabs {
    self.tabs = [[UISegmentedControl alloc] initWithItems:@[@"Tweets", @"Media", @"Likes"]];
    [self.contentView addSubview:self.tabs];
}

- (void)fillSubviews {
    self.navigationBackground.image = [UIImage imageNamed:@"landscape_blur"]; // could be computed
    self.navigationBarTitle.text = @"A Twitter user";
    self.headerImageView.image = [UIImage imageNamed:@"landscape"];
    self.userImageView.image = [UIImage imageNamed:@"artist"];
    [self.followButton setTitle:@"Follow"
                       forState:UIControlStateNormal];
    self.realNameLabel.text = @"A Twitter user";
    self.nicknameLabel.text = @"@twitterUser";
    self.descriptionLabel.text = @"Lorem fistrum qué dise usteer pecador a gramenawer mamaar a peich torpedo a gramenawer condemor está la cosa muy malar. Benemeritaar llevame al sircoo a gramenawer apetecan al ataquerl quietooor condemor sexuarl diodenoo la caidita no puedor.";
    self.infoLabel.text = @"Information goes here";
    self.statsLabel.text = @"99 Following    1024 Followers";
}

- (void)setupConstraints {
    [self.navigationBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.height.equalTo(@64);
    }];

    [self.navigationBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];

    [self.navigationBarTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(@0).offset(kNavigationTitleTop);
    }];

    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.left.equalTo(@12);
    }];

    [self.writeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0).offset(10);
        make.right.equalTo(@(-12));
        make.height.equalTo(@24);
        make.width.equalTo(@24);
    }];

    [self.searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.writeButton);
        make.size.equalTo(self.writeButton);
        make.right.equalTo(self.writeButton.mas_left).offset(-12);
    }];

    [self.tabs mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(-6));
        make.left.equalTo(@(12));
        make.right.equalTo(@(-12));
    }];

    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.tabs.mas_top).offset(-12);
        make.left.equalTo(self.tabs.mas_left);
        make.right.equalTo(self.tabs.mas_right);
    }];

    [self.statsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.infoLabel.mas_top).offset(-8);
        make.left.equalTo(self.tabs.mas_left);
        make.right.equalTo(self.tabs.mas_right);
    }];

    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.statsLabel.mas_top).offset(-8);
        make.left.equalTo(self.tabs.mas_left);
        make.right.equalTo(self.tabs.mas_right);
    }];

    [self.nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.descriptionLabel.mas_top).offset(-8);
        make.left.equalTo(self.tabs.mas_left);
        make.right.equalTo(self.tabs.mas_right);
    }];

    [self.realNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.nicknameLabel.mas_top);
        make.left.equalTo(self.tabs.mas_left);
        make.right.equalTo(self.tabs.mas_right);
    }];

    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *  make) {
        make.width.equalTo(@(kMaxImageSize));
        make.height.equalTo(@(kMaxImageSize));
        make.bottom.equalTo(self.realNameLabel.mas_top).offset(-4);
        make.centerX.equalTo(self.tabs.mas_left).offset(kMaxImageSize / 2);
    }];

    [self.followButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(32));
        make.right.equalTo(self.tabs.mas_right);
        make.bottom.equalTo(self.userImageView.mas_bottom);
    }];

    [self remakeHeaderImageConstraints];
}

- (void)remakeHeaderImageConstraints {
    [self.headerImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        if (self.headerImageOnTop) {
            make.height.equalTo(@(kMinHeaderImageHeight));
        } else {
            make.bottom.equalTo(self.followButton.mas_top).offset(-12);
        }
    }];
}

- (void)updateNavigationTitleConstraints {
    [self.navigationBarTitle mas_updateConstraints:^(MASConstraintMaker *make) {
        CGFloat titleTop = MAX(kNavigationTitleTop, self.realNameLabel.top);
        make.top.equalTo(@0).offset(titleTop);
    }];
}

- (void)didChangeStretchFactor:(CGFloat)stretchFactor {
    [super didChangeStretchFactor:stretchFactor];
    if (self.initialHeaderImageHeight == 0) {
        return;
    }

    if (self.headerImageOnTop) {
        [self updateNavigationTitleConstraints];
        CGFloat navigationBackgroundAlpha = CGFloatTranslateRange(self.userImageView.bottom, self.navigationBar.bottom, self.navigationBar.bottom - 8, 0, 1);
        self.navigationBackground.alpha = MIN(1, MAX(0, navigationBackgroundAlpha));

    } else {
        [self updateNavigationTitleConstraints];
        self.navigationBackground.alpha = 0;

        CGFloat userImageSizeFactor = CGFloatTranslateRange(self.headerImageView.height, 64, self.initialHeaderImageHeight, 0, 1);
        userImageSizeFactor = MIN(1, MAX(0, userImageSizeFactor));
        CGFloat userImageEdge = CGFloatInterpolate(userImageSizeFactor, kMinImageSize, kMaxImageSize);
        [self.userImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(userImageEdge));
            make.height.equalTo(@(userImageEdge));
        }];
    }
}

- (void)contentViewDidLayoutSubviews {
    [super contentViewDidLayoutSubviews];
    if (self.stretchFactor == 1 && self.initialHeaderImageHeight == 0) {
        self.initialHeaderImageHeight = self.headerImageView.height;
        [self didChangeStretchFactor:1];
    }

    if (self.headerImageOnTop) {
        if (self.userImageView.top > self.headerImageView.bottom) {
            self.headerImageOnTop = NO;
            [self.contentView sendSubviewToBack:self.headerImageView];
            [self remakeHeaderImageConstraints];
            [self updateNavigationTitleConstraints];
        }
    } else {
        if (self.headerImageView.height <= 64) {
            self.headerImageOnTop = YES;
            [self.contentView bringSubviewToFront:self.headerImageView];
            [self.contentView bringSubviewToFront:self.navigationBar];
            [self remakeHeaderImageConstraints];
            [self updateNavigationTitleConstraints];
        }
    }
}

#pragma mark - Callbacks

- (void)backButtonPressed:(id)sender {
    [self.delegate headerView:self didTapBackButton:sender];
}

@end
