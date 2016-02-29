#import "GSKExampleBaseTableViewController.h"
#import "UINavigationController+Transparency.h"

static const NSUInteger kNumberOfRows = 100;

@interface GSKExampleBaseTableViewController ()

@end

@implementation GSKExampleBaseTableViewController

- (instancetype)initWithData:(GSKExampleData *)data {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        _data = data;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _stretchyHeaderView = [self loadStretchyHeaderView];
    [self.tableView addSubview:self.stretchyHeaderView];

    _dataSource = [[GSKExampleDataSource alloc] initWithNumberOfRows:kNumberOfRows];
    [self.dataSource registerForTableView:self.tableView];
}


- (GSKStretchyHeaderView *)loadStretchyHeaderView {
    NSAssert(NO, @"please override %@", NSStringFromSelector(_cmd));
    return nil;
}

@end
