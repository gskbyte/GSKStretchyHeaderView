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
#import "GSKStretchyHeaderView+Protected.h"
#import "UIScrollView+GSKStretchyHeaderView.h"

NS_ASSUME_NONNULL_BEGIN

static const CGFloat kNibDefaultMaximumContentHeight = 240;

@interface GSKStretchyHeaderView ()
@property (nonatomic) BOOL needsLayoutContentView;
@property (nonatomic) BOOL arrangingSelfInScrollView;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic) BOOL observingScrollView;
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
    self.contentExpands = YES;
    self.contentShrinks = YES;
    self.manageScrollViewInsets = YES;
}

- (void)setupContentView {
    _contentView = [[GSKStretchyHeaderContentView alloc] initWithFrame:self.bounds];
    [self gsk_transplantSubviewsToView:_contentView];
    [self addSubview:_contentView];
    [self setNeedsLayoutContentView];
}

#pragma mark - Public properties

- (void)setExpansionMode:(GSKStretchyHeaderViewExpansionMode)expansionMode {
    _expansionMode = expansionMode;
    [self.scrollView gsk_layoutStretchyHeaderView:self
                                    contentOffset:self.scrollView.contentOffset
                            previousContentOffset:self.scrollView.contentOffset];
}

- (void)setMaximumContentHeight:(CGFloat)maximumContentHeight {
    if (maximumContentHeight == _maximumContentHeight) {
        return;
    }

    _maximumContentHeight = maximumContentHeight;
    [self setupScrollViewInsetsIfNeeded];
    [self.scrollView gsk_layoutStretchyHeaderView:self
                                    contentOffset:self.scrollView.contentOffset
                            previousContentOffset:self.scrollView.contentOffset];
}

- (void)setContentInset:(UIEdgeInsets)contentInset {
    _contentInset = contentInset;
    [self setupScrollViewInsetsIfNeeded];
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

// we have to stop observing the scroll view before it gets deallocated
// willMoveToSuperview: happens too late
- (void)willMoveToWindow:(nullable UIWindow *)newWindow {
    [super willMoveToWindow:newWindow];
    if (newWindow) {
        [self observeScrollViewIfPossible];
    } else {
        [self stopObservingScrollView];
    }
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    
    if (self.superview != self.scrollView) {
        [self stopObservingScrollView];
        self.scrollView = nil;
    }
    
    if (![self.superview isKindOfClass:[UIScrollView class]]) {
        return;
    }
    
    self.scrollView = (UIScrollView *)self.superview;
    [self observeScrollViewIfPossible];
    
    [self setupScrollViewInsetsIfNeeded];
}

- (void)observeScrollViewIfPossible {
    if (self.scrollView == nil || self.observingScrollView) {
        return;
    }
    
    [self.scrollView addObserver:self
                      forKeyPath:NSStringFromSelector(@selector(contentOffset))
                         options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    [self.scrollView.layer addObserver:self
                            forKeyPath:NSStringFromSelector(@selector(sublayers))
                               options:NSKeyValueObservingOptionNew
                               context:nil];
    self.observingScrollView = YES;
}

- (void)stopObservingScrollView {
    if (!self.observingScrollView) {
        return;
    }
    
    [self.scrollView removeObserver:self forKeyPath:NSStringFromSelector(@selector(contentOffset))];
    [self.scrollView.layer removeObserver:self forKeyPath:NSStringFromSelector(@selector(sublayers))];
    
    self.observingScrollView = NO;
}

- (void)observeValueForKeyPath:(nullable NSString *)keyPath
                      ofObject:(nullable id)object
                        change:(nullable NSDictionary<NSString *, NSValue *> *)change
                       context:(nullable void *)context {
    if (object == self.scrollView &&
        [keyPath isEqualToString:NSStringFromSelector(@selector(contentOffset))]) {
        CGPoint contentOffset = change[NSKeyValueChangeNewKey].CGPointValue;
        CGPoint previousContentOffset = change[NSKeyValueChangeOldKey].CGPointValue;
        [self.scrollView gsk_layoutStretchyHeaderView:self
                                        contentOffset:contentOffset
                                previousContentOffset:previousContentOffset];
    } else if (object == self.scrollView.layer &&
               [keyPath isEqualToString:NSStringFromSelector(@selector(sublayers))]) {
        if (!self.arrangingSelfInScrollView) {
            self.arrangingSelfInScrollView = YES;
            [self.scrollView gsk_arrangeStretchyHeaderView:self];
            self.arrangingSelfInScrollView = NO;
        }
    }
}

#pragma mark - Private properties and methods

- (CGFloat)verticalInset {
    return self.contentInset.top + self.contentInset.bottom;
}

- (CGFloat)horizontalInset {
    return self.contentInset.left + self.contentInset.right;
}

- (CGFloat)maximumHeight {
    return self.maximumContentHeight + self.verticalInset;
}

- (CGFloat)minimumHeight {
    return self.minimumContentHeight + self.verticalInset;
}

- (void)setupScrollViewInsetsIfNeeded {
    if (self.scrollView && self.manageScrollViewInsets) {
        UIEdgeInsets scrollViewContentInset = self.scrollView.contentInset;
        scrollViewContentInset.top = self.maximumContentHeight + self.contentInset.top + self.contentInset.bottom;
        self.scrollView.contentInset = scrollViewContentInset;
    }
}

- (void)setNeedsLayoutContentView {
    self.needsLayoutContentView = YES;
}

- (void)layoutContentViewIfNeeded {
    if (!self.needsLayoutContentView) {
        return;
    }
    
    const CGFloat ownHeight = CGRectGetHeight(self.bounds);
    const CGFloat ownWidth = CGRectGetWidth(self.bounds);
    const CGFloat contentHeightDif = (self.maximumContentHeight - self.minimumContentHeight);
    const CGFloat maxContentViewHeight = ownHeight - self.verticalInset;
    
    CGFloat contentViewHeight = maxContentViewHeight;
    if (!self.contentExpands) {
        contentViewHeight = MIN(contentViewHeight, self.maximumContentHeight);
    }
    if (!self.contentShrinks) {
        contentViewHeight = MAX(contentViewHeight, self.maximumContentHeight);
    }
    
    CGFloat contentViewTop;
    switch (self.contentAnchor) {
        case GSKStretchyHeaderViewContentAnchorTop: {
            contentViewTop = self.contentInset.top;
            break;
        }
        case GSKStretchyHeaderViewContentAnchorBottom: {
            contentViewTop = ownHeight - contentViewHeight;
            if (!self.contentExpands) {
                contentViewTop = MIN(0, contentViewTop);
            }
            break;
        }
    }
    self.contentView.frame = CGRectMake(self.contentInset.left,
                                        contentViewTop,
                                        ownWidth - self.horizontalInset,
                                        contentViewHeight);
    
    CGFloat newStretchFactor = (maxContentViewHeight - self.minimumContentHeight) / contentHeightDif;
    if (newStretchFactor != self.stretchFactor) {
        self.stretchFactor = newStretchFactor;
        [self didChangeStretchFactor:newStretchFactor];
        [self.stretchDelegate stretchyHeaderView:self didChangeStretchFactor:newStretchFactor];
    }
    
    self.needsLayoutContentView = NO;
}

#pragma mark - Stretch factor

- (void)didChangeStretchFactor:(CGFloat)stretchFactor {
    // to be implemented in subclasses
}

#pragma mark - Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    [self layoutContentViewIfNeeded];
}

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
