#import "GSKExampleBaseTableViewController.h"
#import "UINavigationController+Transparency.h"

static const NSUInteger kNumberOfRows = 100;

@interface GSKExampleBaseTableViewController ()

@end

@implementation GSKExampleBaseTableViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = [self defaultTitle];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIEdgeInsets contentInset = self.tableView.contentInset;
    if (self.navigationController) {
        contentInset.top = 64;
    }
    if (self.tabBarController) {
        contentInset.bottom = 44;
    }
    self.tableView.contentInset = contentInset;

    _stretchyHeaderView = [self loadStretchyHeaderView];
    [self.tableView addSubview:self.stretchyHeaderView];

    _dataSource = [self loadDataSource];
    [self.dataSource registerForTableView:self.tableView];
}

- (NSString *)defaultTitle {
    NSString *className = NSStringFromClass(self.class);
    NSString *lastComponent = [className componentsSeparatedByString:@"."].lastObject;
    NSString *title = [lastComponent stringByReplacingOccurrencesOfString:@"ViewController" withString:@""];
    title = [title stringByReplacingOccurrencesOfString:@"Example" withString:@""];
    title = [title stringByReplacingOccurrencesOfString:@"GSK" withString:@""];
    return title;
}

- (GSKStretchyHeaderView *)loadStretchyHeaderView {
    NSAssert(NO, @"please override %@", NSStringFromSelector(_cmd));
    return nil;
}

- (GSKExampleDataSource *)loadDataSource {
    return [[GSKExampleDataSource alloc] initWithNumberOfRows:kNumberOfRows];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.dataSource heightForItemAtIndexPath:indexPath];
}

@end
