#import "GSKVisibleSectionHeadersViewController.h"
#import "GSKSpotyLikeHeaderView.h"
#import "UINavigationController+Transparency.h"
#import "UIView+GSKLayoutHelper.h"

@interface GSKVisibleSectionHeadersDataSource : GSKExampleDataSource
@property (nonatomic) CGFloat stretchyHeaderViewMaximumContentHeight;
@property (nonatomic) CGFloat stretchyHeaderViewMinimumContentHeight;
@end

@implementation GSKVisibleSectionHeadersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController gsk_setNavigationBarTransparent:YES animated:NO];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (GSKStretchyHeaderView *)loadStretchyHeaderView {
    return [[GSKSpotyLikeHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 280)];
}

- (GSKExampleDataSource *)loadDataSource {
    GSKVisibleSectionHeadersDataSource *dataSource = [[GSKVisibleSectionHeadersDataSource alloc] init];
    dataSource.stretchyHeaderViewMaximumContentHeight = self.stretchyHeaderView.maximumContentHeight;
    dataSource.stretchyHeaderViewMinimumContentHeight = self.stretchyHeaderView.minimumContentHeight;
    return dataSource;
}

@end

@implementation GSKVisibleSectionHeadersDataSource

- (instancetype)init {
    return [self initWithNumberOfRows:10];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"Section #%@", @(section)];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    UIEdgeInsets scrollViewContentInset = scrollView.contentInset;
    if (scrollView.contentOffset.y > -self.stretchyHeaderViewMinimumContentHeight) {
        scrollViewContentInset.top = self.stretchyHeaderViewMinimumContentHeight;
    } else if (scrollView.contentOffset.y < -self.stretchyHeaderViewMaximumContentHeight) {
        scrollViewContentInset.top = self.stretchyHeaderViewMaximumContentHeight;
    } else {
        scrollViewContentInset.top = -scrollView.contentOffset.y;
    }
    scrollView.contentInset = scrollViewContentInset;
}

@end
