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
    self.expandOnBounce = YES;
    self.stretchContentView = YES;
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
    if (self.scrollView) {
        [self updateOriginForContentOffset:self.scrollView.contentOffset];
    }
}

#pragma mark - Public methods

- (void)setMaximumContentHeight:(CGFloat)maximumContentHeight
                  resetAnimated:(BOOL)animated {
    if (maximumContentHeight == _maximumContentHeight) {
        return;
    }
    
    self.maximumContentHeight = maximumContentHeight;
    [UIView animateWithDuration:animated ? 0.3 : 0 animations:^{
        self.scrollView.contentOffset = CGPointMake(0, -self.maximumContentHeight);
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

    UIEdgeInsets collectionViewContentInset = scrollView.contentInset;
    collectionViewContentInset.top = self.frame.size.height;
    scrollView.contentInset = collectionViewContentInset;

    [scrollView addObserver:self
                 forKeyPath:@"contentOffset"
                    options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew
                    context:GSKStretchyHeaderViewObserverContext];
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
    CGRect frame = self.frame;
    frame.size.width = self.scrollView.frame.size.width;
    CGFloat verticalInset = self.contentInset.top + self.contentInset.top;
    if (self.maximumContentHeight + contentOffset.y < 0) {
        if (self.expandOnBounce) {
            frame.size.height = -contentOffset.y + verticalInset;
        }
        frame.origin.y = contentOffset.y - self.contentInset.top;
    } else if (-contentOffset.y <= self.minimumContentHeight) {
        frame.size.height = self.minimumContentHeight + verticalInset;
        frame.origin.y = contentOffset.y - self.contentInset.top;
    } else {
        frame.size.height = MIN(-contentOffset.y, self.maximumContentHeight + verticalInset);
        frame.origin.y = - (frame.size.height + self.contentInset.top);
    }

    self.frame = frame;

    CGFloat contentViewHeight = self.stretchContentView ? frame.size.height : self.maximumContentHeight;
    self.contentView.frame = CGRectMake(self.contentInset.top, self.contentInset.left,
                                        frame.size.width - self.contentInset.left - self.contentInset.right,
                                        contentViewHeight);

    CGFloat newStretchFactor = (self.contentView.frame.size.height - self.minimumContentHeight) / (self.maximumContentHeight - self.minimumContentHeight);
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
