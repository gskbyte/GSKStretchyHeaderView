#import "GSKNibStretchyHeaderView.h"
#import <GSKStretchyHeaderView/GSKGeometry.h>

@interface GSKNibStretchyHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@end

@implementation GSKNibStretchyHeaderView

- (void)awakeFromNib {
    self.contentView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:1];
    // uncoment to get a fade to custom navBar
    self.minimumHeight = 64;
}

- (void)didChangeStretchFactor:(CGFloat)stretchFactor {
    CGFloat alpha = CGFloatTranslateRange(self.normalizedStretchFactor, 0.2, 0.8, 0, 1);
    alpha = MAX(0, MIN(1, alpha));

    self.userImage.alpha = alpha;
    self.userNameLabel.alpha = alpha;
    // uncoment to get a fade to custom navBar
    self.backgroundImageView.alpha = alpha;
}


@end
