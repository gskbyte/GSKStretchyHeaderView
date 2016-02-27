#import "GSKExampleListController.h"
#import "GSKExampleDataCell.h"

#import "UINavigationController+Transparency.h"
#import "GSKExampleTableViewController.h"
#import "GSKExampleCollectionViewController.h"

#import "GSKTestStretchyHeaderView.h"

@interface GSKExampleListController () <GSKExampleDataCellDelegate>
@property (nonatomic) NSArray *exampleDatas;
@end

@implementation GSKExampleListController

- (void)viewDidLoad {
    [super viewDidLoad];
    [GSKExampleDataCell registerIn:self.tableView];

    GSKExampleData *data = [GSKExampleData dataWithTitle:@"First example"
                                         headerViewClass:[GSKTestStretchyHeaderView class]];

    self.exampleDatas = @[data

                          ];
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
    GSKExampleCollectionViewController *viewController = [[GSKExampleCollectionViewController alloc] initWithStretchyHeaderViewClass:cell.data.headerViewClass];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)exampleDataCellDidTapTableViewButton:(GSKExampleDataCell *)cell {
    GSKExampleTableViewController *viewController = [[GSKExampleTableViewController alloc] initWithStretchyHeaderViewClass:cell.data.headerViewClass];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
