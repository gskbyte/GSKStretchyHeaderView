#import "GSKVisibleSectionHeadersViewController.h"
#import "GSKSpotyLikeHeaderView.h"
#import "UINavigationController+Transparency.h"
#import "UIView+GSKLayoutHelper.h"

@interface GSKVisibleSectionHeadersDataSource : GSKExampleDataSource

@end

@implementation GSKVisibleSectionHeadersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // by setting contentInset.top, we set where the section headers will be fixed
    self.tableView.contentInset = UIEdgeInsetsMake(self.stretchyHeaderView.minimumContentHeight, 0, 0, 0);
    // we add an empty header view at the top of the table view to increase the initial offset before the first section header
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                              0,
                                                                              self.tableView.width,
                                                                              self.stretchyHeaderView.maximumContentHeight - self.stretchyHeaderView.minimumContentHeight)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController gsk_setNavigationBarTransparent:YES animated:NO];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (GSKStretchyHeaderView *)loadStretchyHeaderView {
    GSKSpotyLikeHeaderView *headerView = [[GSKSpotyLikeHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 280)];
    
    // we have to set this flag before we add the header to the table view, otherwise it will change its insets immediately
    headerView.manageScrollViewInsets = NO;
    
    return headerView;
}

- (GSKExampleDataSource *)loadDataSource {
    return [[GSKVisibleSectionHeadersDataSource alloc] init];
}

@end

@implementation GSKVisibleSectionHeadersDataSource

- (instancetype)init {
    return [self initWithNumberOfRows:7];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"Section #%@", @(section)];
}

@end
