#import <GSKStretchyHeaderView/GSKStretchyHeaderView.h>

@protocol GSKTabsStretchyHeaderViewDelegate;

@interface GSKTabsStretchyHeaderView : GSKStretchyHeaderView

@property (nonatomic, readonly) NSUInteger tabsCount;
@property (nonatomic, weak) id<GSKTabsStretchyHeaderViewDelegate> delegate;

@end

@protocol GSKTabsStretchyHeaderViewDelegate <NSObject>

- (void)tabsStretchyHeaderView:(GSKTabsStretchyHeaderView *)headerView
           didSelectTabAtIndex:(NSUInteger)index;

@end