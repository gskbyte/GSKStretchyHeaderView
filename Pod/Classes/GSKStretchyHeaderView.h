#import <UIKit/UIKit.h>

@interface GSKStretchyHeaderView : UIView

@property (nonatomic) BOOL expandOnBounce; // default YES
@property (nonatomic) BOOL stretchContentView; // default YES

@property (nonatomic, readonly) CGFloat initialHeight;
@property (nonatomic) CGFloat minimumHeight; // defaults to 0

@property (nonatomic, readonly) UIView *contentView; // add your stuff here

@end


@interface GSKStretchyHeaderView (StretchFactor)

@property (nonatomic, readonly) CGFloat stretchFactor;
@property (nonatomic, readonly) CGFloat minStretchFactor;
@property (nonatomic, readonly) CGFloat normalizedStretchFactor;

- (void)didChangeStretchFactor:(CGFloat)stretchFactor;

@end
