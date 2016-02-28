#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GSKStretchyHeaderView : UIView

@property (nonatomic) IBInspectable BOOL expandOnBounce; // default YES
@property (nonatomic) IBInspectable BOOL stretchContentView; // default YES

@property (nonatomic, readonly) IBInspectable CGFloat initialHeight;
@property (nonatomic) IBInspectable CGFloat minimumHeight; // defaults to 0

@property (nonatomic, readonly) UIView *contentView; // add your stuff here

@end


@interface GSKStretchyHeaderView (StretchFactor)

@property (nonatomic, readonly) CGFloat stretchFactor;
@property (nonatomic, readonly) CGFloat minStretchFactor;
@property (nonatomic, readonly) CGFloat normalizedStretchFactor;

- (void)didChangeStretchFactor:(CGFloat)stretchFactor;

@end

NS_ASSUME_NONNULL_END