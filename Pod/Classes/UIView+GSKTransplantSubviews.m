#import "UIView+GSKTransplantSubviews.h"

@interface NSLayoutConstraint (GSKTransplantSubviews)

- (NSLayoutConstraint *)gsk_copyWithFirstItem:(id)firstItem secondItem:(id)secondItem;

@end

@implementation UIView (GSKTransplantSubviews)

- (void)gsk_transplantSubviewsToView:(UIView *)newSuperview {
    NSArray<UIView *> *oldSubviews = self.subviews;
    NSArray<NSLayoutConstraint *> *oldConstraints = self.constraints;

    for (UIView *view in oldSubviews) {
        [view removeFromSuperview];
        [newSuperview addSubview:view];
    }

    [self removeConstraints:oldConstraints];
    for (NSLayoutConstraint *oldConstraint in oldConstraints) {
        id firstItem = oldConstraint.firstItem == self ? newSuperview : oldConstraint.firstItem;
        id secondItem = oldConstraint.secondItem == self ? newSuperview : oldConstraint.secondItem;
        NSLayoutConstraint *constraint = [oldConstraint gsk_copyWithFirstItem:firstItem
                                                                   secondItem:secondItem];
        [newSuperview addConstraint:constraint];
    }
}

@end

@implementation NSLayoutConstraint (GSKTransplantSubviews)

- (NSLayoutConstraint *)gsk_copyWithFirstItem:(id)firstItem secondItem:(id)secondItem {
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:firstItem
                                                                  attribute:self.firstAttribute
                                                                  relatedBy:self.relation
                                                                     toItem:secondItem
                                                                  attribute:self.secondAttribute
                                                                 multiplier:self.multiplier
                                                                   constant:self.constant];
    constraint.identifier = self.identifier;
    if ([self respondsToSelector:@selector(isActive)]) {
        constraint.active = self.active;
    }
    return constraint;
}

@end
