#import "GSKExampleListController.h"
#import "GSKExampleDataCell.h"

#import "UINavigationController+Transparency.h"
#import "GSKExampleTableViewController.h"
#import "GSKExampleCollectionViewController.h"

#import "GSKTestStretchyHeaderView.h"
#import "GSKSpotyLikeHeaderView.h"

@interface GSKExampleListController () <GSKExampleDataCellDelegate>
@property (nonatomic) NSArray *exampleDatas;
@end

@implementation GSKExampleListController

- (void)viewDidLoad {
    [super viewDidLoad];
    [GSKExampleDataCell registerIn:self.tableView];

    GSKExampleData *data = [GSKExampleData dataWithTitle:@"First example (classical Frame Layout)"
                                         headerViewClass:[GSKTestStretchyHeaderView class]];
    data.headerViewInitialHeight = 200;

    GSKExampleData *spoty = [GSKExampleData dataWithTitle:@"Spoty-Like header view (Auto Layout)"
                                          headerViewClass:[GSKSpotyLikeHeaderView class]];

    GSKExampleData *nib = [GSKExampleData dataWithTitle:@"From an interface builder file"
                                      headerViewNibName:@"GSKNibStretchyHeaderView"];

    self.exampleDatas = @[data, spoty, nib];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController gsk_setNavigationBarTransparent:NO animated:YES];
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
