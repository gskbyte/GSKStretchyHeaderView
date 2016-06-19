#import "GSKNibStretchyHeaderView.h"
#import <GSKStretchyHeaderView/GSKGeometry.h>

static const BOOL kNavBar = YES;

@interface GSKNibStretchyHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *navigationTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *expansionModeButton;
@end

@implementation GSKNibStretchyHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:1];
    self.expansionMode = GSKStretchyHeaderViewExpansionModeImmediate;
    if (kNavBar) {
        self.minimumContentHeight = 64;
    } else {
        self.navigationTitleLabel.hidden = YES;
    }
    
    self.expansionModeButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.expansionModeButton.layer.borderWidth = 2;
    self.expansionModeButton.layer.cornerRadius = 4;
    [self updateExpansionModeButtonTitle];
}

- (void)didChangeStretchFactor:(CGFloat)stretchFactor {
    CGFloat alpha = CGFloatTranslateRange(stretchFactor, 0.2, 0.8, 0, 1);
    alpha = MAX(0, MIN(1, alpha));

    self.userImage.alpha = alpha;
    self.userNameLabel.alpha = alpha;

    if (kNavBar) {
        self.backgroundImageView.alpha = alpha;

        CGFloat navTitleFactor = 0.4;
        CGFloat navTitleAlpha = 0;
        if (stretchFactor < navTitleFactor) {
            navTitleAlpha = CGFloatTranslateRange(stretchFactor, 0, navTitleFactor, 1, 0);
        }
        self.navigationTitleLabel.alpha = navTitleAlpha;
    }
}

- (void)updateExpansionModeButtonTitle {
    switch (self.expansionMode) {
        case GSKStretchyHeaderViewExpansionModeTopOnly: {
            [self.expansionModeButton setTitle:@"Expansion: top"
                                      forState:UIControlStateNormal];
            break;
        }
        case GSKStretchyHeaderViewExpansionModeImmediate: {
            [self.expansionModeButton setTitle:@"Expansion: immediate"
                                      forState:UIControlStateNormal];
            break;
        }
    }
}

- (IBAction)didTapExpansionModeButton:(id)sender {
    switch (self.expansionMode) {
        case GSKStretchyHeaderViewExpansionModeTopOnly: {
            self.expansionMode = GSKStretchyHeaderViewExpansionModeImmediate;
            break;
        }
        case GSKStretchyHeaderViewExpansionModeImmediate: {
            self.expansionMode = GSKStretchyHeaderViewExpansionModeTopOnly;
            break;
        }
    }
    [self updateExpansionModeButtonTitle];
}

@end
