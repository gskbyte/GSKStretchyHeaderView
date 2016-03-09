#import "GSKExampleListViewController.h"
#import "GSKExampleDataCell.h"

#import "UINavigationController+Transparency.h"
#import "GSKExampleTableViewController.h"
#import "GSKExampleCollectionViewController.h"

#import "GSKTestStretchyHeaderView.h"
#import "GSKSpotyLikeHeaderView.h"

#import "GSKExampleTabsViewController.h"
#import "GSKExampleNavigationBarViewController.h"
#import "GSKAirbnbExampleViewController.h"
#import "GSKVisibleSectionHeadersViewController.h"

@interface GSKExampleListViewController () <GSKExampleDataCellDelegate>
@property (nonatomic) NSArray *exampleDatas;
@end

@implementation GSKExampleListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"GSKStretchyHeaderView examples";
    [GSKExampleDataCell registerIn:self.tableView];

    GSKExampleData *airbnb = [GSKExampleData dataWithTitle:@"airbnb-like header view"
                                       viewControllerClass:[GSKAirbnbExampleViewController class]];

    GSKExampleData *firstExample = [GSKExampleData dataWithTitle:@"First example (classical Frame Layout)"
                                         headerViewClass:[GSKTestStretchyHeaderView class]];
    firstExample.headerViewInitialHeight = 200;

    GSKExampleData *spoty = [GSKExampleData dataWithTitle:@"Spotify-like header view (Auto Layout)"
                                          headerViewClass:[GSKSpotyLikeHeaderView class]];

    GSKExampleData *nib = [GSKExampleData dataWithTitle:@"From an interface builder file"
                                      headerViewNibName:@"GSKNibStretchyHeaderView"];

    GSKExampleData *tabs = [GSKExampleData dataWithTitle:@"With tabs"
                                     viewControllerClass:[GSKExampleTabsViewController class]];

    GSKExampleData *navBar = [GSKExampleData dataWithTitle:@"Under navigation bar"
                                       viewControllerClass:[GSKExampleNavigationBarViewController class]];

    GSKExampleData *visibleHeaders = [GSKExampleData dataWithTitle:@"Visible section headers"
                                               viewControllerClass:[GSKVisibleSectionHeadersViewController class]];

    self.exampleDatas = @[airbnb, spoty, firstExample, nib, tabs, navBar, visibleHeaders];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController gsk_setNavigationBarTransparent:NO animated:YES];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.exampleDatas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [GSKExampleDataCell height];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GSKExampleDataCell *cell = [tableView dequeueReusableCellWithIdentifier:[GSKExampleDataCell reuseIdentifier]];
    cell.data = self.exampleDatas[indexPath.row];
    cell.delegate = self;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

#pragma mark - GSKExampleDataCellDelegate

- (void)exampleDataCellDidTapTitleButton:(GSKExampleDataCell *)cell {
    UIViewController *viewController = [[cell.data.viewControllerClass alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)exampleDataCellDidTapCollectionViewButton:(GSKExampleDataCell *)cell {
    GSKExampleCollectionViewController *viewController = [[GSKExampleCollectionViewController alloc] initWithData:cell.data];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)exampleDataCellDidTapTableViewButton:(GSKExampleDataCell *)cell {
    GSKExampleTableViewController *viewController = [[GSKExampleTableViewController alloc] initWithData:cell.data];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
