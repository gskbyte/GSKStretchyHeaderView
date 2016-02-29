#import "GSKTabsStretchyHeaderView.h"

@interface GSKTabsStretchyHeaderView ()
@property (weak, nonatomic) IBOutlet UIButton *firstTab;
@property (weak, nonatomic) IBOutlet UIButton *secondTab;
@property (weak, nonatomic) IBOutlet UIButton *thirdTab;

@property (nonatomic, readonly) NSArray *tabs;
@end

@implementation GSKTabsStretchyHeaderView

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


@end
