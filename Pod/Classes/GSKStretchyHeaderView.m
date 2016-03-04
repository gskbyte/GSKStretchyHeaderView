#import "GSKStretchyHeaderView.h"
#import "GSKGeometry.h"
#import "UIView+GSKTransplantSubviews.h"

NS_ASSUME_NONNULL_BEGIN

static const CGFloat kNibDefaultMaximumContentHeight = 240;

@interface GSKStretchyHeaderView ()
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic) BOOL observingScrollView;
@property (nonatomic, weak) id<GSKStretchyHeaderViewStretchDelegate> stretchDelegate;
@property (nonatomic) CGFloat stretchFactor;
@end

@interface GSKStretchyHeaderContentView : UIView
@end

static void *GSKStretchyHeaderViewObserverContext = &GSKStretchyHeaderViewObserverContext;

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

- (void)willMoveToWindow:(nullable UIWindow *)newWindow {
    [super willMoveToWindow:newWindow];
    if (!newWindow) {
        [self stopObservingScrollView];
    } else {
        [self observeScrollView];
        [self setupScrollViewInsets];
    }
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];

    if (self.superview != self.scrollView) {
        [self stopObservingScrollView];
        self.scrollView = nil;
    }
}

#pragma mark - Private properties and methods

- (void)observeScrollView {
    if (!self.observingScrollView && self.scrollView) {
        [self.scrollView addObserver:self
                          forKeyPath:@"contentOffset"
                             options:NSKeyValueObservingOptionNew
                             context:GSKStretchyHeaderViewObserverContext];
        self.observingScrollView = YES;
    }
}

- (void)stopObservingScrollView {
    if (self.observingScrollView && self.scrollView) {
        [self.scrollView removeObserver:self
                             forKeyPath:@"contentOffset"
                                context:GSKStretchyHeaderViewObserverContext];
        self.observingScrollView = NO;
    }
}

- (void)setupScrollViewInsets {
    UIEdgeInsets scrollViewContentInset = self.scrollView.contentInset;
    scrollViewContentInset.top = self.maximumContentHeight + self.contentInset.top + self.contentInset.bottom;
    self.scrollView.contentInset = scrollViewContentInset;
}

- (void)observeValueForKeyPath:(nullable NSString *)keyPath
                      ofObject:(nullable id)object
                        change:(nullable NSDictionary<NSString *,id> *)change
                       context:(nullable void *)context {
    if (object == self.scrollView &&
        [keyPath isEqualToString:@"contentOffset"]) {
        NSValue *newValue = change[NSKeyValueChangeNewKey];
        CGPoint contentOffset = newValue.CGPointValue;
        [self updateOriginForContentOffset:contentOffset];
    }
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

- (CGFloat)minStretchFactor {
    return self.minimumContentHeight / self.maximumContentHeight;
}

- (CGFloat)normalizedStretchFactor {
    return CGFloatTranslateRange(self.stretchFactor, self.minStretchFactor, 1, 0, 1);
}

- (void)didChangeStretchFactor:(CGFloat)stretchFactor {
    // to be implemented in subclasses
}

@end

@implementation GSKStretchyHeaderContentView

@end

NS_ASSUME_NONNULL_END
