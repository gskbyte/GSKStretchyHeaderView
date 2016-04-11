#import <XCTest/XCTest.h>
#import <GSKStretchyHeaderView/GSKStretchyHeaderView.h>
#import <Expecta/Expecta.h>

@interface GSKStretchyHeaderViewTests : XCTestCase
@property (nonatomic) GSKStretchyHeaderView *headerView;
@end

@implementation GSKStretchyHeaderViewTests

- (void)setUp {
    [super setUp];
    self.headerView = [[GSKStretchyHeaderView alloc] init];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testDefaultValues {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 640)];
    [scrollView addSubview:self.headerView];
    
    expect(self.headerView.maximumContentHeight).to.equal(320);
    expect(self.headerView.minimumContentHeight).to.equal(0);
    expect(self.headerView.frame.size.height).to.equal(320);
    expect(scrollView.contentInset.top).to.equal(320);
}

- (void)testTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 640) style:UITableViewStylePlain];
    [tableView addSubview:self.headerView];
    
    
    
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

@end
