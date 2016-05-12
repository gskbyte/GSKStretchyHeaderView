#import <XCTest/XCTest.h>

#import <GSKStretchyHeaderView/GSKStretchyHeaderView.h>
#import <Expecta/Expecta.h>
#import <OCMock/OCMock.h>

static const CGFloat kInitialHeaderViewHeight = 280;

@interface GSKStretchyHeaderViewTests : XCTestCase
@end

@implementation GSKStretchyHeaderViewTests

- (void)testThrowExceptionIfHeightIsZero {
    
}

- (void)testDefaultValues {
    UIWindow *mockWindow = [self mockWindow];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 640)];
    [mockWindow addSubview:scrollView];
    
    [scrollView addSubview:[self headerView]];
    
    expect(self.headerView.maximumContentHeight).to.equal(kInitialHeaderViewHeight);
    expect(self.headerView.minimumContentHeight).to.equal(0);
    expect(self.headerView.frame.size.height).to.equal(kInitialHeaderViewHeight);
    expect(scrollView.contentInset.top).to.equal(kInitialHeaderViewHeight);
}

- (void)testTableView {
    UIWindow *mockWindow = [self mockWindow];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 640) style:UITableViewStylePlain];
    [mockWindow addSubview:tableView];
    
    [tableView addSubview:[self headerView]];
    
    
    
}

#pragma mark - Helper methods

- (UIWindow *)mockWindow {
    return [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
}

- (GSKStretchyHeaderView *)headerView {
    return [[GSKStretchyHeaderView alloc] initWithFrame:CGRectMake(0, 0, 120, kInitialHeaderViewHeight)];
}


@end
