#import "GSKStretchyHeaderView.h"
#import "GSKGeometry.h"

static const CGFloat kNibDefaultMaximumContentHeight = 240;

@interface GSKStretchyHeaderView ()
@property (nonatomic, weak) UIScrollView *scrollView;
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

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupView];

        NSArray<UIView *> *oldSubviews = self.subviews;
        [self setupContentView];
        for (UIView *view in oldSubviews) {
            [self.contentView addSubview:view];
        }
    }
    return self;
}

- (void)setupView {
    self.clipsToBounds = YES;
    self.minimumContentHeight = 0;
    self.contentViewMode = GSKStretchyHeaderContentViewModeStretchHeight;
}

- (void)setupContentView {
    _contentView = [[GSKStretchyHeaderContentView alloc] initWithFrame:self.frame];
    [self addSubview:_contentView];
}

#pragma mark - Public properties

- (void)setMaximumContentHeight:(CGFloat)maximumContentHeight {
    if (maximumContentHeight == _maximumContentHeight) {
        return;
    }

    _maximumContentHeight = maximumContentHeight;
    CGRect frame = self.frame;
    frame.size.height = maximumContentHeight;
    self.frame = frame;

    [self setupScrollViewInsets];
    [self updateOriginForContentOffset:self.scrollView.contentOffset];
}

- (void)setContentInset:(UIEdgeInsets)contentInset {
    _contentInset = contentInset;
    [self setupScrollViewInsets];
}

- (void)setContentViewMode:(GSKStretchyHeaderContentViewMode)contentViewMode {
    _contentViewMode = contentViewMode;
    [self updateOriginForContentOffset:self.scrollView.contentOffset];
}

#pragma mark - Public methods

- (void)setMaximumContentHeight:(CGFloat)maximumContentHeight
                  resetAnimated:(BOOL)animated {
    if (maximumContentHeight == _maximumContentHeight) {
        return;
    }
    
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

- (void)willMoveToWindow:(UIWindow *)newWindow {
    [super willMoveToWindow:newWindow];
    if (!newWindow) {
        [self stopObservingScrollView];
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    [self stopObservingScrollView];
}

- (void)stopObservingScrollView {
    [_scrollView removeObserver:self forKeyPath:@"contentOffset" context:GSKStretchyHeaderViewObserverContext];
    _scrollView = nil;
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    if ([self.superview isKindOfClass:[UIScrollView class]]) {
        self.scrollView = (UIScrollView *)self.superview;
    }
}

#pragma mark - Private properties and methods

- (void)setScrollView:(UIScrollView *)scrollView {
    _scrollView = scrollView;

    [scrollView addSubview:self];
    [self setupScrollViewInsets];

    [scrollView addObserver:self
                 forKeyPath:@"contentOffset"
                    options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew
                    context:GSKStretchyHeaderViewObserverContext];
}

- (void)setupScrollViewInsets {
    UIEdgeInsets scrollViewContentInset = self.scrollView.contentInset;
    scrollViewContentInset.top = self.maximumContentHeight + self.contentInset.top + self.contentInset.bottom;
    self.scrollView.contentInset = scrollViewContentInset;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context {
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

    frame.size.width = self.scrollView.frame.size.width;
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
    CGFloat contentViewHeight;
    CGFloat contentViewTop;
    switch (self.contentViewMode) {
        case GSKStretchyHeaderContentViewModeStretchHeight:
            contentViewHeight = visibleContentViewHeight;
            contentViewTop = self.contentInset.top;
            break;
        case GSKStretchyHeaderContentViewModeFixedHeightAnchorTop:
            contentViewHeight = self.maximumContentHeight;
            contentViewTop = self.contentInset.top;
            break;
        case GSKStretchyHeaderContentViewModeFixedHeightAnchorBottom:
            contentViewHeight = self.maximumContentHeight;
            contentViewTop = MIN(self.contentInset.top,
                                 frame.size.height - verticalInset - self.maximumContentHeight);
            break;
    }

    self.contentView.frame = CGRectMake(self.contentInset.left,
                                        contentViewTop,
                                        frame.size.width - self.contentInset.left - self.contentInset.right,
                                        contentViewHeight);

    CGFloat newStretchFactor = (visibleContentViewHeight - self.minimumContentHeight) / contentHeightDif;
    if (newStretchFactor != self.stretchFactor) {
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
