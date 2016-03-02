#import "GSKTabsStretchyHeaderView.h"
#import <GSKStretchyHeaderView/GSKGeometry.h>

@interface GSKTabsStretchyHeaderView ()
@property (weak, nonatomic) IBOutlet UIButton *firstTab;
@property (weak, nonatomic) IBOutlet UIButton *secondTab;
@property (weak, nonatomic) IBOutlet UIButton *thirdTab;

@property (nonatomic, readonly) NSArray *tabs;
@end

@implementation GSKTabsStretchyHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
}

- (NSUInteger)tabsCount {
    return self.tabs.count;
}

- (NSArray *)tabs {
    return @[self.firstTab, self.secondTab, self.thirdTab];
}

- (IBAction)didTapTabButton:(id)sender {
    [self.tabsDelegate tabsStretchyHeaderView:self
                          didSelectTabAtIndex:[self.tabs indexOfObject:sender]];
}

- (void)didChangeStretchFactor:(CGFloat)stretchFactor {
    self.contentView.backgroundColor = [UIColor colorWithRed:CGFloatTranslateRange(stretchFactor, 0, 1, 0.2, 0.3)
                                                       green:CGFloatTranslateRange(stretchFactor, 0, 1, 0.7, 0.3)
                                                        blue:0.3
                                                       alpha:1];
}

@end
