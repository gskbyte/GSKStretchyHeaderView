#import "GSKExampleBaseTableViewController.h"
#import "UINavigationController+Transparency.h"

static const NSUInteger kNumberOfRows = 100;

@interface GSKExampleBaseTableViewController ()

@end

@implementation GSKExampleBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _stretchyHeaderView = [self loadStretchyHeaderView];
    [self.tableView addSubview:self.stretchyHeaderView];

    _dataSource = [self loadDataSource];
    [self.dataSource registerForTableView:self.tableView];
}


- (GSKStretchyHeaderView *)loadStretchyHeaderView {
    NSAssert(NO, @"please override %@", NSStringFromSelector(_cmd));
    return nil;
}

- (GSKExampleDataSource *)loadDataSource {
    return [[GSKExampleDataSource alloc] initWithNumberOfRows:kNumberOfRows];
}

@end
