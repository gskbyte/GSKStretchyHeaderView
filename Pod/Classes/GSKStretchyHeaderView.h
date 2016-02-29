#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GSKStretchyHeaderViewStretchDelegate;
@interface GSKStretchyHeaderView : UIView

@property (nonatomic, readonly) UIView *contentView; // add your subviews here

@property (nonatomic) IBInspectable CGFloat maximumContentHeight; // defaults to initial frame height
@property (nonatomic) IBInspectable CGFloat minimumContentHeight; // defaults to 0
@property (nonatomic) IBInspectable UIEdgeInsets contentInsetz; // default UIEdgeInsetsZero

@property (nonatomic, weak) id<GSKStretchyHeaderViewStretchDelegate> stretchDelegate;
@property (nonatomic) IBInspectable BOOL stretchContentView; // default YES

- (void)setMaximumContentHeight:(CGFloat)maximumContentHeight
                  resetAnimated:(BOOL)animated;

@end


@interface GSKStretchyHeaderView (StretchFactor)

@property (nonatomic, readonly) CGFloat stretchFactor;

- (void)didChangeStretchFactor:(CGFloat)stretchFactor;

@end


@protocol GSKStretchyHeaderViewStretchDelegate <NSObject>

- (void)stretchyHeaderView:(GSKStretchyHeaderView *)headerView
    didChangeStretchFactor:(CGFloat)stretchFactor;

@end

NS_ASSUME_NONNULL_END