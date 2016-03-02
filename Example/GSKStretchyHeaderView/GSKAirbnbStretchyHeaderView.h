#import <GSKStretchyHeaderView/GSKStretchyHeaderView.h>

@protocol GSKAirbnbStretchyHeaderViewDelegate;

@interface GSKAirbnbStretchyHeaderView : GSKStretchyHeaderView

@property (nonatomic, weak) id<GSKAirbnbStretchyHeaderViewDelegate> delegate;

@end

@protocol GSKAirbnbStretchyHeaderViewDelegate <NSObject>

- (void)airbnbStretchyHeaderView:(GSKAirbnbStretchyHeaderView *)headerView
                didTapBackButton:(id)sender;
- (void)airbnbStretchyHeaderView:(GSKAirbnbStretchyHeaderView *)headerView
              didTapSearchButton:(id)sender;

@end