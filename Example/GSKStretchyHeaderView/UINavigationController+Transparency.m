#import "UINavigationController+Transparency.h"

@implementation UINavigationController (Transparency)

- (void)gsk_setNavigationBarTransparent:(BOOL)transparent
                               animated:(BOOL)animated {
    [UIView animateWithDuration:animated ? 0.33 : 0 animations:^{
        if (transparent) {
            [self.navigationBar setBackgroundImage:[UIImage new]
                                     forBarMetrics:UIBarMetricsDefault];
            self.navigationBar.shadowImage = [UIImage new];
            self.navigationBar.translucent = YES;
            self.view.backgroundColor = [UIColor clearColor];
            self.navigationBar.backgroundColor = [UIColor clearColor];
        } else {
            [self.navigationBar setBackgroundImage:nil
                                     forBarMetrics:UIBarMetricsDefault];
        }
    }];
}

@end
