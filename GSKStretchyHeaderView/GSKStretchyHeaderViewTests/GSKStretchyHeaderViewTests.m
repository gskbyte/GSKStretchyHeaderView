#import <XCTest/XCTest.h>

#import <GSKStretchyHeaderView/GSKStretchyHeaderView.h>
#import "UIView+GSKLayoutHelper.h"

#import "GSKTestHeaderView.h"
#import "HelperMacros.h"

static const CGFloat kInitialHeaderViewHeight = 280;

@interface GSKStretchyHeaderViewTests : XCTestCase
@property (nonatomic) UIWindow *window;
@property (nonatomic) UIScrollView *scrollView;
@end

@implementation GSKStretchyHeaderViewTests

- (void)setUp {
    [super setUp];
    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, 320, 640)];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 640)];
    [self.window addSubview:self.scrollView];
}

- (void)testDefaultValues {
    [self.scrollView addSubview:[self headerView]];
    
    XCTAssertEqual(self.headerView.maximumContentHeight, kInitialHeaderViewHeight);
    XCTAssertEqual(self.headerView.minimumContentHeight, 0);
    XCTAssertEqual(self.headerView.frame.size.height, kInitialHeaderViewHeight);
    XCTAssertEqual(self.scrollView.contentInset.top, kInitialHeaderViewHeight);
}

- (void)testScrollWithoutInsetsNoMinimumContentHeight {
    GSKStretchyHeaderView *headerView = [self headerView];
    [self.scrollView addSubview:headerView];
    
    self.scrollView.contentSize = CGSizeMake(320, 2000);
    
    // initial scroll
    XCTAssertEqualFrame(headerView.frame, CGRectMake(0, -kInitialHeaderViewHeight, 320, kInitialHeaderViewHeight));
    XCTAssertEqualFrame(headerView.contentView.frame, CGRectMake(0, 0, 320, kInitialHeaderViewHeight));
    XCTAssertEqual(headerView.stretchFactor, 1);
    
    self.scrollView.contentOffset = CGPointMake(0, -100);
    
    // scroll a bit to the top
    XCTAssertEqualFrame(headerView.frame, CGRectMake(0, -100, 320, 100));
    XCTAssertEqualFrame(headerView.contentView.frame, CGRectMake(0, 0, 320, 100));
    XCTAssertInRange(headerView.stretchFactor, 0, 1);

    // scroll a lot to the top
    self.scrollView.contentOffset = CGPointMake(0, 100);
    
    XCTAssertEqualFrame(headerView.frame, CGRectMake(0, 100, 320, 0));
    XCTAssertEqualFrame(headerView.contentView.frame, CGRectMake(0, 0, 320, 0));
    XCTAssertEqual(headerView.stretchFactor, 0);
    
    // try to bounce the header view
    self.scrollView.contentOffset = CGPointMake(0, -400);
    
    XCTAssertEqualFrame(headerView.frame, CGRectMake(0, -400, 320, 400));
    XCTAssertEqual(headerView.contentView.top, headerView.contentInset.top);
    XCTAssertEqual(headerView.contentView.height, 400);
    XCTAssertGreaterThan(headerView.stretchFactor, 1);
}

- (void)testScrollViewWithMinimumContentHeight {
    GSKStretchyHeaderView *headerView = [self headerView];
    headerView.minimumContentHeight = 120;
    headerView.contentExpands = NO;
    headerView.contentShrinks = NO;
    headerView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    [self.scrollView addSubview:headerView];
    
    self.scrollView.contentSize = CGSizeMake(320, 2000);

    // initial state
    XCTAssertEqualFrame(headerView.frame, CGRectMake(0, -(kInitialHeaderViewHeight + headerView.contentInset.top),
                                                 320, kInitialHeaderViewHeight + headerView.contentInset.top));
    XCTAssertEqual(headerView.contentView.top, headerView.contentInset.top);
    XCTAssertEqual(headerView.contentView.height, kInitialHeaderViewHeight);

    XCTAssertEqual(headerView.stretchFactor, 1);
    
    // scroll a bit to the top
    self.scrollView.contentOffset = CGPointMake(0, -250);
    
    XCTAssertEqualFrame(headerView.frame, CGRectMake(0, -250, 320, 250));
    XCTAssertEqual(headerView.contentView.top, headerView.contentInset.top);
    XCTAssertGreaterThan(headerView.contentView.height, headerView.minimumContentHeight);
    XCTAssertEqual(headerView.contentView.height, headerView.maximumContentHeight);
    XCTAssertGreaterThan(headerView.stretchFactor, 0);
    XCTAssertLessThan(headerView.stretchFactor, 1);
    
    // scroll a lot to the top
    self.scrollView.contentOffset = CGPointMake(0, 100);
    
    XCTAssertEqualFrame(headerView.frame, CGRectMake(0, 100, 320, headerView.minimumContentHeight + headerView.contentInset.top));
    XCTAssertEqual(headerView.contentView.top, headerView.contentInset.top);
    XCTAssertEqual(headerView.contentView.height, headerView.maximumContentHeight);
    XCTAssertEqual(headerView.stretchFactor, 0);

    // try to bounce the header view
    self.scrollView.contentOffset = CGPointMake(0, -400);
    
    XCTAssertEqualFrame(headerView.frame, CGRectMake(0, -400, 320, 400));
    XCTAssertEqual(headerView.contentView.top, headerView.contentInset.top);
    XCTAssertEqual(headerView.contentView.height, headerView.maximumContentHeight);
    XCTAssertGreaterThan(headerView.stretchFactor, 1);
}

- (void)testScrollViewWithAnchorBottomAndMinimumSize {
    GSKStretchyHeaderView *headerView = [self headerView];
    headerView.minimumContentHeight = 120;
    headerView.contentShrinks = NO;
    headerView.contentAnchor = GSKStretchyHeaderViewContentAnchorBottom;
    headerView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    [self.scrollView addSubview:headerView];
    
    self.scrollView.contentSize = CGSizeMake(320, 2000);
    
    // initial state
    XCTAssertEqualFrame(headerView.frame, CGRectMake(0, -(kInitialHeaderViewHeight + headerView.contentInset.top),
                                                 320, kInitialHeaderViewHeight + headerView.contentInset.top));
    XCTAssertEqual(headerView.contentView.top, headerView.contentInset.top);
    XCTAssertEqual(headerView.contentView.height, kInitialHeaderViewHeight);
    
    XCTAssertEqual(headerView.stretchFactor, 1);
    
    // scroll a bit to the top
    self.scrollView.contentOffset = CGPointMake(0, -250);
    
    XCTAssertEqualFrame(headerView.frame, CGRectMake(0, -250, 320, 250));
    XCTAssertEqual(headerView.contentView.top, 250 - kInitialHeaderViewHeight);
    XCTAssertInClosedRange(headerView.contentView.height, headerView.minimumContentHeight, headerView.maximumContentHeight);
    XCTAssertInRange(headerView.stretchFactor, 0, 1);
    
    // scroll a lot to the top
    self.scrollView.contentOffset = CGPointMake(0, 100);
    
    XCTAssertEqualFrame(headerView.frame, CGRectMake(0, 100, 320, headerView.minimumContentHeight + headerView.contentInset.top));
    XCTAssertEqual(headerView.contentView.top, -96);
    XCTAssertEqual(headerView.contentView.height, headerView.maximumContentHeight);
    XCTAssertEqual(headerView.stretchFactor, 0);
    
    // try to bounce the header view
    self.scrollView.contentOffset = CGPointMake(0, -400);
    
    XCTAssertEqualFrame(headerView.frame, CGRectMake(0, -400, 320, 400));
    XCTAssertEqual(headerView.contentView.top, headerView.contentInset.top);
    XCTAssertGreaterThan(headerView.contentView.height, headerView.maximumContentHeight);
    XCTAssertGreaterThan(headerView.stretchFactor, 1);
}

- (void)testExpansionModeImmediate {
    GSKStretchyHeaderView *headerView = [self headerView];
    headerView.minimumContentHeight = 120;
    headerView.expansionMode = GSKStretchyHeaderViewExpansionModeImmediate;
    headerView.contentExpands = NO;
    [self.scrollView addSubview:headerView];
    
    XCTAssertEqualFrame(headerView.frame, CGRectMake(0, -kInitialHeaderViewHeight, 320, kInitialHeaderViewHeight));

    // Scroll to a point between maximumContentHeight and minimumContentHeight
    self.scrollView.contentOffset = CGPointMake(0, -200);
    XCTAssertEqualFrame(headerView.frame, CGRectMake(0, -200, 320, 200));
    XCTAssertEqualFrame(headerView.contentView.frame, CGRectMake(0, 0, 320, 200));
    
    // Scroll down more than the maximumContentHeight
    self.scrollView.contentOffset = CGPointMake(0, -400);
    XCTAssertEqualFrame(headerView.frame, CGRectMake(0, -400, 320, 400));
    XCTAssertEqualFrame(headerView.contentView.frame, CGRectMake(0, 0, 320, kInitialHeaderViewHeight)); // beacuse contentExpands = NO

    // Scroll up more than the minimumContentHeight
    self.scrollView.contentOffset = CGPointMake(0, 500);
    XCTAssertEqualFrame(headerView.frame, CGRectMake(0, 500, 320, 120));
    XCTAssertEqualFrame(headerView.contentView.frame, CGRectMake(0, 0, 320, 120));

    // As soon as we scroll down a little bit, the height of the header view increases
    self.scrollView.contentOffset = CGPointMake(0, 400);
    XCTAssertEqualFrame(headerView.frame, CGRectMake(0, 400, 320, 220)); // because we scroll down 100 points, height increases 100 points
    XCTAssertEqualFrame(headerView.contentView.frame, CGRectMake(0, 0, 320, 220));
}

- (void)testLoadFromXib {
    NSArray* nibViews = [[NSBundle bundleForClass:self.class] loadNibNamed:@"GSKTestHeaderView"
                                                      owner:self
                                                    options:nil];
    GSKTestHeaderView *headerView = nibViews.firstObject;
    [self.scrollView addSubview:headerView];
    
    self.scrollView.contentSize = CGSizeMake(320, 2000);
    
    XCTAssertEqual(headerView.maximumContentHeight, 250);
    XCTAssertEqual(headerView.minimumContentHeight, 64);
    XCTAssertEqual(headerView.contentAnchor, GSKStretchyHeaderViewContentAnchorBottom);
    XCTAssertFalse(headerView.contentShrinks);
    XCTAssertFalse(headerView.contentExpands);
    
    [headerView.contentView layoutSubviews];
    
    UILabel *centeredLabel = headerView.contentView.subviews.firstObject;
    XCTAssertNotNil(centeredLabel);
    
    // TODO: test that the constraints have been correctly transplanted
}

#pragma mark - Helper methods

- (GSKStretchyHeaderView *)headerView {
    return [[GSKStretchyHeaderView alloc] initWithFrame:CGRectMake(0, 0, 120, kInitialHeaderViewHeight)];
}

@end
