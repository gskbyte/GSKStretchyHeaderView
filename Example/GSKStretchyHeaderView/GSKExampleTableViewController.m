#import "GSKExampleTableViewController.h"
#import "GSKStretchyHeaderView.h"
#import "UINavigationController+Transparency.h"
#import "GSKExampleDataSource.h"

static const NSUInteger kNumberOfRows = 100;

@interface GSKExampleTableViewController ()
@property (nonatomic) GSKExampleData *data;
@property (nonatomic) GSKStretchyHeaderView *stretchyHeaderView;
@property (nonatomic) GSKExampleDataSource *dataSource;
@end

@implementation GSKExampleTableViewController

- (instancetype)initWithData:(GSKExampleData *)data {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        self.data = data;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    if (self.data.headerViewClass) {
        self.stretchyHeaderView = [[self.data.headerViewClass alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, self.data.headerViewInitialHeight)];
    } else {
        NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:self.data.nibName
                                                          owner:self
                                                        options:nil];
        self.stretchyHeaderView = nibViews.firstObject;
    }
    [self.tableView addSubview:self.stretchyHeaderView];

    self.dataSource = [[GSKExampleDataSource alloc] initWithNumberOfRows:kNumberOfRows];
    [self.dataSource registerForTableView:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!self.data.navigationBarVisible) {
        [self.navigationController gsk_setNavigationBarTransparent:YES animated:NO];
        self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    }
}


@end
