#import "GSKVisibleSectionHeadersViewController.h"
#import "GSKSpotyLikeHeaderView.h"
#import "UINavigationController+Transparency.h"
#import "UIView+GSKLayoutHelper.h"

@implementation GSKVisibleSectionHeadersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource.numberOfSections = 10;
    self.dataSource.numberOfRowsInEverySection = 7;
    self.dataSource.displaysSectionHeaders = YES;
    
    // by setting contentInset.top, we set where the section headers will be fixed
    UIEdgeInsets contentInset = self.tableView.contentInset;
    contentInset.top = self.stretchyHeaderView.minimumContentHeight;
    self.tableView.contentInset = contentInset;
    
    // we add an empty header view at the top of the table view to increase the initial offset before the first section header
    // otherwise the header view would cover the first cells
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

@end
