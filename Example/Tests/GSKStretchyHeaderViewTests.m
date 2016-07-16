#import <XCTest/XCTest.h>

#import <GSKStretchyHeaderView/GSKStretchyHeaderView.h>
#import "UIView+GSKLayoutHelper.h"
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>

#import "GSKTestHeaderView.h"

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
    
    expect(self.headerView.maximumContentHeight).to.equal(kInitialHeaderViewHeight);
    expect(self.headerView.minimumContentHeight).to.equal(0);
    expect(self.headerView.frame.size.height).to.equal(kInitialHeaderViewHeight);
    expect(self.scrollView.contentInset.top).to.equal(kInitialHeaderViewHeight);
}

- (void)testScrollWithoutInsetsNoMinimumContentHeight {
    GSKStretchyHeaderView *headerView = [self headerView];
    [self.scrollView addSubview:headerView];
    
    self.scrollView.contentSize = CGSizeMake(320, 2000);
    
    // initial scroll
    expect(headerView.frame).to.equal(CGRectMake(0, -kInitialHeaderViewHeight, 320, kInitialHeaderViewHeight));
    expect(headerView.contentView.frame).to.equal(CGRectMake(0, 0, 320, kInitialHeaderViewHeight));
    expect(headerView.stretchFactor).to.equal(1);
    
    self.scrollView.contentOffset = CGPointMake(0, -100);
    
    // scroll a bit to the top
    expect(headerView.frame).to.equal(CGRectMake(0, -100, 320, 100));
    expect(headerView.contentView.frame).to.equal(CGRectMake(0, 0, 320, 100));
    expect(headerView.stretchFactor).to.beInTheRangeOf(0, 1);

    // scroll a lot to the top
    self.scrollView.contentOffset = CGPointMake(0, 100);
    
    expect(headerView.frame).to.equal(CGRectMake(0, 100, 320, 0));
    expect(headerView.contentView.frame).to.equal(CGRectMake(0, 0, 320, 0));
    expect(headerView.stretchFactor).to.equal(0);
    
    // try to bounce the header view
    self.scrollView.contentOffset = CGPointMake(0, -400);
    
    expect(headerView.frame).to.equal(CGRectMake(0, -400, 320, 400));
    expect(headerView.contentView.top).to.equal(headerView.contentInset.top);
    expect(headerView.contentView.height).to.equal(400);
    expect(headerView.stretchFactor).to.beGreaterThan(1);
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
    expect(headerView.frame).to.equal(CGRectMake(0, -(kInitialHeaderViewHeight + headerView.contentInset.top),
                                                 320, kInitialHeaderViewHeight + headerView.contentInset.top));
    expect(headerView.contentView.top).to.equal(headerView.contentInset.top);
    expect(headerView.contentView.height).to.equal(kInitialHeaderViewHeight);

    expect(headerView.stretchFactor).to.equal(1);
    
    // scroll a bit to the top
    self.scrollView.contentOffset = CGPointMake(0, -250);
    
    expect(headerView.frame).to.equal(CGRectMake(0, -250, 320, 250));
    expect(headerView.contentView.top).to.equal(headerView.contentInset.top);
    expect(headerView.contentView.height).to.beInTheRangeOf(headerView.minimumContentHeight, headerView.maximumContentHeight);
    expect(headerView.stretchFactor).to.beInTheRangeOf(0, 1);
    
    // scroll a lot to the top
    self.scrollView.contentOffset = CGPointMake(0, 100);
    
    expect(headerView.frame).to.equal(CGRectMake(0, 100, 320, headerView.minimumContentHeight + headerView.contentInset.top));
    expect(headerView.contentView.top).to.equal(headerView.contentInset.top);
    expect(headerView.contentView.height).to.equal(headerView.maximumContentHeight);
    expect(headerView.stretchFactor).to.equal(0);

    // try to bounce the header view
    self.scrollView.contentOffset = CGPointMake(0, -400);
    
    expect(headerView.frame).to.equal(CGRectMake(0, -400, 320, 400));
    expect(headerView.contentView.top).to.equal(headerView.contentInset.top);
    expect(headerView.contentView.height).to.equal(headerView.maximumContentHeight);
    expect(headerView.stretchFactor).to.beGreaterThan(1);
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
    expect(headerView.frame).to.equal(CGRectMake(0, -(kInitialHeaderViewHeight + headerView.contentInset.top),
                                                 320, kInitialHeaderViewHeight + headerView.contentInset.top));
    expect(headerView.contentView.top).to.equal(headerView.contentInset.top);
    expect(headerView.contentView.height).to.equal(kInitialHeaderViewHeight);
    
    expect(headerView.stretchFactor).to.equal(1);
    
    // scroll a bit to the top
    self.scrollView.contentOffset = CGPointMake(0, -250);
    
    expect(headerView.frame).to.equal(CGRectMake(0, -250, 320, 250));
    expect(headerView.contentView.top).to.equal(250 - kInitialHeaderViewHeight);
    expect(headerView.contentView.height).to.beInTheRangeOf(headerView.minimumContentHeight, headerView.maximumContentHeight);
    expect(headerView.stretchFactor).to.beInTheRangeOf(0, 1);
    
    // scroll a lot to the top
    self.scrollView.contentOffset = CGPointMake(0, 100);
    
    expect(headerView.frame).to.equal(CGRectMake(0, 100, 320, headerView.minimumContentHeight + headerView.contentInset.top));
    expect(headerView.contentView.top).to.equal(-96);
    expect(headerView.contentView.height).to.equal(headerView.maximumContentHeight);
    expect(headerView.stretchFactor).to.equal(0);
    
    // try to bounce the header view
    self.scrollView.contentOffset = CGPointMake(0, -400);
    
    expect(headerView.frame).to.equal(CGRectMake(0, -400, 320, 400));
    expect(headerView.contentView.top).to.equal(headerView.contentInset.top);
    expect(headerView.contentView.height).to.beGreaterThan(headerView.maximumContentHeight);
    expect(headerView.stretchFactor).to.beGreaterThan(1);
}

- (void)testExpansionModeImmediate {
    GSKStretchyHeaderView *headerView = [self headerView];
    headerView.minimumContentHeight = 120;
    headerView.expansionMode = GSKStretchyHeaderViewExpansionModeImmediate;
    headerView.contentExpands = NO;
    [self.scrollView addSubview:headerView];
    
    expect(headerView.frame).to.equal(CGRectMake(0, -kInitialHeaderViewHeight, 320, kInitialHeaderViewHeight));

    // Scroll to a point between maximumContentHeight and minimumContentHeight
    self.scrollView.contentOffset = CGPointMake(0, -200);
    expect(headerView.frame).to.equal(CGRectMake(0, -200, 320, 200));
    expect(headerView.contentView.frame).to.equal(CGRectMake(0, 0, 320, 200));
    
    // Scroll down more than the maximumContentHeight
    self.scrollView.contentOffset = CGPointMake(0, -400);
    expect(headerView.frame).to.equal(CGRectMake(0, -400, 320, 400));
    expect(headerView.contentView.frame).to.equal(CGRectMake(0, 0, 320, kInitialHeaderViewHeight)); // beacuse contentExpands = NO

    // Scroll up more than the minimumContentHeight
    self.scrollView.contentOffset = CGPointMake(0, 500);
    expect(headerView.frame).to.equal(CGRectMake(0, 500, 320, 120));
    expect(headerView.contentView.frame).to.equal(CGRectMake(0, 0, 320, 120));

    // As soon as we scroll down a little bit, the height of the header view increases
    self.scrollView.contentOffset = CGPointMake(0, 400);
    expect(headerView.frame).to.equal(CGRectMake(0, 400, 320, 220)); // because we scroll down 100 points, height increases 100 points
    expect(headerView.contentView.frame).to.equal(CGRectMake(0, 0, 320, 220));
}

- (void)testLoadFromXib {
    NSArray* nibViews = [[NSBundle bundleForClass:self.class] loadNibNamed:@"GSKTestHeaderView"
                                                      owner:self
                                                    options:nil];
    GSKTestHeaderView *headerView = nibViews.firstObject;
    [self.scrollView addSubview:headerView];
    
    self.scrollView.contentSize = CGSizeMake(320, 2000);
    
    expect(headerView.maximumContentHeight).to.equal(250);
    expect(headerView.minimumContentHeight).to.equal(64);
    expect(headerView.contentAnchor).to.equal(GSKStretchyHeaderViewContentAnchorBottom);
    expect(headerView.contentShrinks).to.beFalsy();
    expect(headerView.contentExpands).to.beFalsy();
    
    [headerView.contentView layoutSubviews];
    
    UILabel *centeredLabel = headerView.contentView.subviews.firstObject;
    expect(centeredLabel).notTo.beNil();
    
    // TODO: test that the constraints have been correctly transplanted
}

#pragma mark - Helper methods

- (GSKStretchyHeaderView *)headerView {
    return [[GSKStretchyHeaderView alloc] initWithFrame:CGRectMake(0, 0, 120, kInitialHeaderViewHeight)];
}

@end
