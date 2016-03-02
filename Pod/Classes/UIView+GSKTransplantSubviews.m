#import "UIView+GSKTransplantSubviews.h"

@implementation UIView (GSKTransplantSubviews)

- (void)gsk_transplantSubviewsToView:(UIView *)newSuperview {
    NSArray<UIView *> *oldSubviews = self.subviews;
    NSArray<NSLayoutConstraint *> *oldConstraints = self.constraints;

    for (UIView *view in oldSubviews) {
        [view removeFromSuperview];
        [newSuperview addSubview:view];
    }

    for (NSLayoutConstraint *oldConstraint in oldConstraints) {
        id firstItem = oldConstraint.firstItem == self ? newSuperview : oldConstraint.firstItem;
        id secondItem = oldConstraint.secondItem == self ? newSuperview : oldConstraint.secondItem;
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:firstItem
                                                                      attribute:oldConstraint.firstAttribute
                                                                      relatedBy:oldConstraint.relation
                                                                         toItem:secondItem
                                                                      attribute:oldConstraint.secondAttribute
                                                                     multiplier:oldConstraint.multiplier
                                                                       constant:oldConstraint.constant];
        constraint.identifier = oldConstraint.identifier;
        if ([oldConstraint respondsToSelector:@selector(isActive)]) {
            constraint.active = oldConstraint.active;
        }

        [newSuperview addConstraint:constraint];
        [self removeConstraint:oldConstraint];
    }
}

@end
