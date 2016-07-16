// UIView+GSKTransplantSubviews.h
// Copyright (c) 2016 Jose Alcalá Correa ( http://github.com/gskbyte )
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "UIView+GSKTransplantSubviews.h"

@interface NSLayoutConstraint (GSKTransplantSubviews)

- (NSLayoutConstraint *)gsk_copyWithFirstItem:(id)firstItem secondItem:(id)secondItem;

@end

@implementation UIView (GSKTransplantSubviews)

- (void)gsk_transplantSubviewsToView:(UIView *)newSuperview {
    NSArray<UIView *> *oldSubviews = self.subviews;
    NSArray<NSLayoutConstraint *> *oldConstraints = self.constraints;
    NSMutableArray<NSNumber *> *oldConstraintsActiveValues = [NSMutableArray array];
    
    if ([NSLayoutConstraint instancesRespondToSelector:@selector(isActive)]) {
        for (NSLayoutConstraint *constraint in oldConstraints) {
            [oldConstraintsActiveValues addObject:@(constraint.active)];
        }
    }

    for (UIView *view in oldSubviews) {
        [view removeFromSuperview];
        [newSuperview addSubview:view];
    }

    [self removeConstraints:oldConstraints];
    [oldConstraints enumerateObjectsUsingBlock:^(NSLayoutConstraint *oldConstraint, NSUInteger index, BOOL *stop) {
        id firstItem = oldConstraint.firstItem == self ? newSuperview : oldConstraint.firstItem;
        id secondItem = oldConstraint.secondItem == self ? newSuperview : oldConstraint.secondItem;
        NSLayoutConstraint *constraint = [oldConstraint gsk_copyWithFirstItem:firstItem
                                                                   secondItem:secondItem];
        if ([constraint respondsToSelector:@selector(setActive:)]) {
            constraint.active = oldConstraintsActiveValues[index].boolValue;
        } else {
            [newSuperview addConstraint:constraint];
        }
    }];
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
