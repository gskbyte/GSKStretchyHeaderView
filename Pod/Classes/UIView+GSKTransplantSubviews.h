#import <UIKit/UIKit.h>

@interface UIView (GSKTransplantSubviews)

- (void)gsk_transplantToView:(UIView *)newSuperview;
- (void)gsk_transplantSubviewsToView:(UIView *)newSuperview;

@end
