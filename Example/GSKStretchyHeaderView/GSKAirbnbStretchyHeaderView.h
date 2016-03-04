#import <GSKStretchyHeaderView/GSKStretchyHeaderView.h>

@protocol GSKAirbnbStretchyHeaderViewDelegate;

typedef NS_ENUM(NSUInteger, GSKAirbnbSearchViewMode) {
    GSKAirbnbSearchViewModeButton,
    GSKAirbnbSearchViewModeTextField
};

@interface GSKAirbnbStretchyHeaderView : GSKStretchyHeaderView

@property (nonatomic, readonly) GSKAirbnbSearchViewMode mode;
@property (nonatomic, weak) id<GSKAirbnbStretchyHeaderViewDelegate> delegate;

@end

@protocol GSKAirbnbStretchyHeaderViewDelegate <NSObject>

- (void)airbnbStretchyHeaderView:(GSKAirbnbStretchyHeaderView *)headerView
                didTapBackButton:(id)sender;
- (void)airbnbStretchyHeaderView:(GSKAirbnbStretchyHeaderView *)headerView
              didTapSearchButton:(id)sender;
- (void)airbnbStretchyHeaderView:(GSKAirbnbStretchyHeaderView *)headerView
                 didTapSearchBar:(id)sender;

@end
