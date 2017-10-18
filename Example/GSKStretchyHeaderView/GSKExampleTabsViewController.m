#import "GSKExampleTabsViewController.h"
#import "GSKTabsStretchyHeaderView.h"
#import "GSKExampleDataSource.h"
#import "UINavigationController+Transparency.h"

@interface GSKExampleTabsViewController () <GSKTabsStretchyHeaderViewDelegate>

@property (nonatomic) GSKTabsStretchyHeaderView *stretchyHeaderView;
@property (nonatomic) NSArray<GSKExampleDataSource *> *dataSources;

@end

@implementation GSKExampleTabsViewController

- (instancetype)init {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];

    NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:@"GSKTabsStretchyHeaderView"
                                                      owner:self
                                                    options:nil];
    self.stretchyHeaderView = nibViews.firstObject;
    self.stretchyHeaderView.tabsDelegate = self;
    self.stretchyHeaderView.expansionMode = GSKStretchyHeaderViewExpansionModeImmediate;
    [self.tableView addSubview:self.stretchyHeaderView];

    NSMutableArray *dataSources = [NSMutableArray array];
    for (NSUInteger i = 0; i < self.stretchyHeaderView.tabsCount; ++i) {
        GSKExampleDataSource *dataSource = [[GSKExampleDataSource alloc] init];
        [dataSources addObject:dataSource];
    }
    self.dataSources = [dataSources copy];
    [self.dataSources.firstObject registerForTableView:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController gsk_setNavigationBarTransparent:YES animated:NO];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}

- (void)tabsStretchyHeaderView:(GSKTabsStretchyHeaderView *)headerView
           didSelectTabAtIndex:(NSUInteger)index {
    NSLog(@"didSelectTab %@", @(index));
    [self.dataSources[index] registerForTableView:self.tableView];
    [self.tableView reloadData];
    if (self.tableView.contentOffset.y > -headerView.minimumContentHeight) {
        self.tableView.contentOffset = CGPointMake(0, -headerView.minimumContentHeight);
    }
}

@end

