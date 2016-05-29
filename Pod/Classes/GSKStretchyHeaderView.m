// GSKStretchyHeaderView.m
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

#import "GSKStretchyHeaderView.h"
#import "GSKGeometry.h"
#import "UIView+GSKTransplantSubviews.h"
#import <KVOController/NSObject+FBKVOController.h>

NS_ASSUME_NONNULL_BEGIN

static const CGFloat kNibDefaultMaximumContentHeight = 240;

@interface GSKStretchyHeaderView ()
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) id<GSKStretchyHeaderViewStretchDelegate> stretchDelegate;
@property (nonatomic) CGFloat stretchFactor;
@end

@interface GSKStretchyHeaderContentView : UIView
@end

@implementation GSKStretchyHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    NSAssert(frame.size.height > 0, @"Initial height MUST be greater than 0");
    self = [super initWithFrame:frame];
    if (self) {
        self.maximumContentHeight = self.frame.size.height;
        [self setupView];
        [self setupContentView];
    }
    return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupView];
        [self setupContentView];
    }
    return self;
}

- (void)setupView {
    self.clipsToBounds = YES;
    self.minimumContentHeight = 0;
    self.contentAnchor = GSKStretchyHeaderViewContentAnchorTop;
    self.contentBounces = YES;
    self.contentStretches = YES;
}

- (void)setupContentView {
    _contentView = [[GSKStretchyHeaderContentView alloc] initWithFrame:self.bounds];
    [self gsk_transplantSubviewsToView:_contentView];
    [self addSubview:_contentView];
}

#pragma mark - Public properties

- (void)setMaximumContentHeight:(CGFloat)maximumContentHeight {
    if (maximumContentHeight == _maximumContentHeight) {
        return;
    }

    _maximumContentHeight = maximumContentHeight;
    if (self.scrollView) {
        [self setupScrollViewInsets];
        [self updateOriginForContentOffset:self.scrollView.contentOffset];
    }
}

- (void)setContentInset:(UIEdgeInsets)contentInset {
    _contentInset = contentInset;
    [self setupScrollViewInsets];
}

#pragma mark - Public methods

- (void)setMaximumContentHeight:(CGFloat)maximumContentHeight
                  resetAnimated:(BOOL)animated {
    self.maximumContentHeight = maximumContentHeight;
    [UIView animateWithDuration:animated ? 0.3 : 0 animations:^{
        self.scrollView.contentOffset = CGPointMake(0, -(self.maximumContentHeight + self.contentInset.top));
    }];
}

#pragma mark - Overriden methods

- (void)awakeFromNib {
    [super awakeFromNib];
    if (self.maximumContentHeight == 0) {
        NSLog(@"'maximumContentHeight' not defined for %@, setting default (%@)",
              NSStringFromClass(self.class),
              @(kNibDefaultMaximumContentHeight));
        self.maximumContentHeight = kNibDefaultMaximumContentHeight;
    }
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    
    if (self.superview != self.scrollView) {
        [self.KVOController unobserveAll];
        self.scrollView = nil;
    }
    
    if (![self.superview isKindOfClass:[UIScrollView class]]) {
        return;
    }
    
    self.scrollView = (UIScrollView *)self.superview;
    
    [self.KVOController observe:self.scrollView
                        keyPath:NSStringFromSelector(@selector(contentOffset))
                        options:NSKeyValueObservingOptionNew
                          block:^(id observer, id object, NSDictionary<NSString *,id> *change) {
                              NSValue *newValue = change[NSKeyValueChangeNewKey];
                              CGPoint contentOffset = newValue.CGPointValue;
                              [self updateOriginForContentOffset:contentOffset];
    }];
    
    [self.KVOController observe:self.scrollView.layer
                        keyPath:NSStringFromSelector(@selector(sublayers))
                        options:NSKeyValueObservingOptionNew
                          block:^(id observer, id object, NSDictionary<NSString *,id> *change) {
                              [self.scrollView bringSubviewToFront:self];
    }];
    
    [self setupScrollViewInsets];
}

#pragma mark - Private properties and methods

- (void)setupScrollViewInsets {
    UIEdgeInsets scrollViewContentInset = self.scrollView.contentInset;
    scrollViewContentInset.top = self.maximumContentHeight + self.contentInset.top + self.contentInset.bottom;
    self.scrollView.contentInset = scrollViewContentInset;
}

- (void)updateOriginForContentOffset:(CGPoint)contentOffset {
    const CGFloat verticalInset = self.contentInset.top + self.contentInset.bottom;
    const CGFloat contentHeightDif = (self.maximumContentHeight - self.minimumContentHeight);
    const CGFloat maximumHeight = self.maximumContentHeight + verticalInset;
    const CGFloat minimumHeight = self.minimumContentHeight + verticalInset;

    CGRect frame = self.frame;
    BOOL forceStretchFactorUpdate = NO;

    if (frame.size.width != self.scrollView.frame.size.width) {
        frame.size.width = self.scrollView.frame.size.width;
        forceStretchFactorUpdate = YES;
    }
    frame.origin.y = contentOffset.y;

    if (contentOffset.y + maximumHeight < 0) { // bigger than default
        frame.size.height = -contentOffset.y;
    } else if (-contentOffset.y <= minimumHeight) { // less than minimum height
        frame.size.height = self.minimumContentHeight + verticalInset;
    } else { // between minimum and maximum
        frame.size.height = -contentOffset.y;
    }
    self.frame = frame;

    const CGFloat visibleContentViewHeight = frame.size.height - verticalInset;
    CGFloat contentViewHeight = visibleContentViewHeight;
    if (!self.contentBounces) {
        contentViewHeight = MIN(contentViewHeight, self.maximumContentHeight);
    }
    if (!self.contentStretches) {
        contentViewHeight = MAX(contentViewHeight, self.maximumContentHeight);
    }

    CGFloat contentViewTop;
    switch (self.contentAnchor) {
        case GSKStretchyHeaderViewContentAnchorTop: {
            contentViewTop = self.contentInset.top;
            break;
        }
        case GSKStretchyHeaderViewContentAnchorBottom: {
            contentViewTop = frame.size.height - contentViewHeight;
            if (!self.contentBounces) {
                contentViewTop = MIN(0, contentViewTop);
            }
            break;
        }
    }
    self.contentView.frame = CGRectMake(self.contentInset.left,
                                        contentViewTop,
                                        frame.size.width - self.contentInset.left - self.contentInset.right,
                                        contentViewHeight);

    CGFloat newStretchFactor = (visibleContentViewHeight - self.minimumContentHeight) / contentHeightDif;
    if (newStretchFactor != self.stretchFactor ||
        forceStretchFactorUpdate) {
        self.stretchFactor = newStretchFactor;
        [self didChangeStretchFactor:newStretchFactor];
        [self.stretchDelegate stretchyHeaderView:self didChangeStretchFactor:newStretchFactor];
    }
}

#pragma mark - Stretch factor

- (void)didChangeStretchFactor:(CGFloat)stretchFactor {
    // to be implemented in subclasses
}

#pragma mark - Layout

- (void)contentViewDidLayoutSubviews {
    // default implementation does not do anything
}

@end

@implementation GSKStretchyHeaderContentView

- (void)layoutSubviews {
    [super layoutSubviews];
    if ([self.superview isKindOfClass:[GSKStretchyHeaderView class]]) {
        [(GSKStretchyHeaderView *)self.superview contentViewDidLayoutSubviews];
    }
}

@end

NS_ASSUME_NONNULL_END
