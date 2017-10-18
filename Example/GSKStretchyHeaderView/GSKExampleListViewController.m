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
#import "GSKTwitterExampleViewController.h"

#import "Example-Swift.h"

@interface GSKExampleListViewController () <GSKExampleDataCellDelegate>
@property (nonatomic) NSArray *exampleDatas;
@end

@implementation GSKExampleListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"GSKStretchyHeaderView";
    self.tableView.rowHeight = [GSKExampleDataCell height];
    
    [GSKExampleDataCell registerIn:self.tableView];

    GSKExampleData *airbnb = [GSKExampleData dataWithTitle:@"airbnb-like header view"
                                       viewControllerClass:[GSKAirbnbExampleViewController class]];

    GSKExampleData *twitter = [GSKExampleData dataWithTitle:@"Twitter-like header view"
                                        viewControllerClass:[GSKTwitterExampleViewController class]];

    GSKExampleData *spoty = [GSKExampleData dataWithTitle:@"Spotify-like header view (Auto Layout)"
                                          headerViewClass:[GSKSpotyLikeHeaderView class]];
    
    GSKExampleData *scalableLabel = [GSKExampleData dataWithTitle:@"Scalable text (+ expansion modes)"
                                              viewControllerClass:[ScalableLabelViewController class]];
    
    GSKExampleData *firstExample = [GSKExampleData dataWithTitle:@"First example (classical Frame Layout)"
                                                 headerViewClass:[GSKTestStretchyHeaderView class]];
    firstExample.headerViewInitialHeight = 200;

    GSKExampleData *nib = [GSKExampleData dataWithTitle:@"From a XIB file (+ expansion modes)"
                                      headerViewNibName:@"GSKNibStretchyHeaderView"];

    GSKExampleData *tabs = [GSKExampleData dataWithTitle:@"With tabs on top"
                                     viewControllerClass:[GSKExampleTabsViewController class]];
    
    GSKExampleData *navBar = [GSKExampleData dataWithTitle:@"Below the navigation bar"
                                       viewControllerClass:[GSKExampleNavigationBarViewController class]];
    
    GSKExampleData *tabBarViewController = [GSKExampleData dataWithTitle:@"Tab bar view controller"
                                                     viewControllerClass:[TabBarViewController class]];

    GSKExampleData *visibleHeaders = [GSKExampleData dataWithTitle:@"Visible section headers"
                                               viewControllerClass:[GSKVisibleSectionHeadersViewController class]];

    self.exampleDatas = @[airbnb, twitter, spoty, scalableLabel, firstExample, nib, tabs, navBar, tabBarViewController, visibleHeaders];
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
