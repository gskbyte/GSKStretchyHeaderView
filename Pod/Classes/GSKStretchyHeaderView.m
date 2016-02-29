#import "GSKStretchyHeaderView.h"
#import "GSKGeometry.h"


static const CGFloat kNibDefaultHeight = 240;

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
        self.initialHeight = self.frame.size.height;
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
    self.minimumHeight = 0;
    self.expandOnBounce = YES;
    self.stretchContentView = YES;
}

- (void)setupContentView {
    _contentView = [[GSKStretchyHeaderContentView alloc] initWithFrame:self.frame];
    [self addSubview:_contentView];
}

#pragma mark - Overriden methods

- (void)awakeFromNib {
    [super awakeFromNib];
    if (self.initialHeight == 0) {
        NSLog(@"'initialHeight' not defined for %@, setting default (%@)",
              NSStringFromClass(self.class),
              @(kNibDefaultHeight));
        [self setInitialHeight:kNibDefaultHeight];
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

- (void)setInitialHeight:(CGFloat)initialHeight {
    _initialHeight = initialHeight;
    CGRect frame = self.frame;
    frame.size.height = initialHeight;
    self.frame = frame;
}

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

    CGFloat newStretchFactor = self.frame.size.height / self.initialHeight;
    if (newStretchFactor != self.stretchFactor) {
        self.stretchFactor = newStretchFactor;
        [self didChangeStretchFactor:newStretchFactor];
        if ([self.delegate respondsToSelector:@selector(stretchyHeaderView:didChangeStretchFactor:)]) {
            [self.delegate stretchyHeaderView:self didChangeStretchFactor:newStretchFactor];
        }
    }
}

#pragma mark - Stretch factor

- (CGFloat)minStretchFactor {
    return self.minimumHeight / self.initialHeight;
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
