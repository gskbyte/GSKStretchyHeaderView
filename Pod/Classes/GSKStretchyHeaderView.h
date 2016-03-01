#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, GSKStretchyHeaderContentViewMode) {
    // anchors top and bottom, height changes
    GSKStretchyHeaderContentViewModeStretchHeight = 0,

    // top anchor, height = self.maximumContentHeight
    GSKStretchyHeaderContentViewModeFixedHeightAnchorTop,

    // bottom anchor, height = self.maximumContentHeight
    GSKStretchyHeaderContentViewModeFixedHeightAnchorBottom
};

@protocol GSKStretchyHeaderViewStretchDelegate;
@interface GSKStretchyHeaderView : UIView

@property (nonatomic, readonly) UIView *contentView; // add your subviews here

@property (nonatomic) IBInspectable CGFloat maximumContentHeight; // defaults to initial frame height
@property (nonatomic) IBInspectable CGFloat minimumContentHeight; // defaults to 0
@property (nonatomic) IBInspectable UIEdgeInsets contentInset; // default UIEdgeInsetsZero
@property (nonatomic) IBInspectable GSKStretchyHeaderContentViewMode contentViewMode; // default GSKStretchyHeaderViewContentModeStretchHeight

@property (nonatomic, weak) id<GSKStretchyHeaderViewStretchDelegate> stretchDelegate;

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