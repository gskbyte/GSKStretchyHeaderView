#import "GSKStretchyHeaderView.h"
#import "GSKGeometry.h"

@interface GSKStretchyHeaderView ()
@property (nonatomic) CGFloat initialHeight;
@property (nonatomic, weak) UIScrollView *scrollView;
@end

static void *GSKStretchyHeaderViewObserverContext = &GSKStretchyHeaderViewObserverContext;

@implementation GSKStretchyHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    NSAssert(frame.size.height > 0, @"Initial height MUST be greater than 0");
    self = [super initWithFrame:frame];
    if (self) {
        _initialHeight = frame.size.height;
        _expandOnBounce = YES;
        _stretchContentView = NO;
        self.clipsToBounds = YES;
        [self setupContentView];
    }
    return self;
}

- (void)setupContentView {
    _contentView = [[UIView alloc] initWithFrame:self.frame];
    [self addSubview:_contentView];
}

#pragma mark - Overriden methods

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
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset" context:GSKStretchyHeaderViewObserverContext];
    [self.scrollView.layer removeObserver:self forKeyPath:@"sublayers" context:GSKStretchyHeaderViewObserverContext];
    self.scrollView = nil;
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
    [scrollView.layer addObserver:self
                       forKeyPath:@"sublayers"
                          options:NSKeyValueObservingOptionNew
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

    if (object == self.scrollView.layer &&
        [keyPath isEqualToString:@"sublayers"]) {
        [self.scrollView bringSubviewToFront:self];
    }
}

- (void)updateOriginForContentOffset:(CGPoint)contentOffset {
    CGRect frame = self.frame;
    if (self.initialHeight + contentOffset.y < 0) {
        frame.origin.y = contentOffset.y;
        if (self.expandOnBounce) {
            frame.size.height = -contentOffset.y;
        }
    } else if (-contentOffset.y <= self.minimumHeight) {
        frame.origin.y = contentOffset.y;
        frame.size.height = self.minimumHeight;
    } else {
        frame.size.height = MIN(-contentOffset.y, self.initialHeight);
        frame.origin.y = -frame.size.height;
    }

    self.frame = frame;

    CGFloat contentViewHeight = self.stretchContentView ? frame.size.height : self.initialHeight;
    self.contentView.frame = CGRectMake(0, 0, frame.size.width, contentViewHeight);
}

#pragma mark - Stretch factor readonly properties

- (CGFloat)stretchFactor {
    return self.frame.size.height / self.initialHeight;
}

- (CGFloat)minStretchFactor {
    return self.minimumHeight / self.initialHeight;
}

- (CGFloat)normalizedStretchFactor {
    return CGFloatTranslateRange(self.stretchFactor, self.minStretchFactor, 1, 0, 1);
}

@end
