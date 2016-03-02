#import "GSKAirbnbExampleViewController.h"
#import "GSKAirbnbStretchyHeaderView.h"

@interface GSKAirbnbExampleViewController () <GSKAirbnbStretchyHeaderViewDelegate>
@end

@implementation GSKAirbnbExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(beginRefreshing:) forControlEvents:UIControlEventValueChanged];

    [self.tableView addSubview:self.refreshControl];
    self.dataSource.cellColors = @[[UIColor whiteColor], [UIColor lightGrayColor]];
}

- (GSKStretchyHeaderView *)loadStretchyHeaderView {
    CGRect frame = CGRectMake(0, 0, self.tableView.frame.size.width, 250);
    GSKAirbnbStretchyHeaderView *headerView = [[GSKAirbnbStretchyHeaderView alloc] initWithFrame:frame];
    headerView.maximumContentHeight = 300;
    headerView.minimumContentHeight = 84;
    headerView.contentBounces = NO;
    headerView.delegate = self;
    return headerView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)airbnbStretchyHeaderView:(GSKAirbnbStretchyHeaderView *)headerView
                didTapBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)airbnbStretchyHeaderView:(GSKAirbnbStretchyHeaderView *)headerView
              didTapSearchButton:(id)sender {
    CGPoint contentOffset = self.tableView.contentOffset;
    if (contentOffset.y < -self.stretchyHeaderView.minimumContentHeight) {
        contentOffset.y = -self.stretchyHeaderView.minimumContentHeight;
        [self.tableView setContentOffset:contentOffset animated:YES];
    }

    // show a child search view controller

}

- (void)beginRefreshing:(id)sender {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.refreshControl endRefreshing];
    });
}

@end
