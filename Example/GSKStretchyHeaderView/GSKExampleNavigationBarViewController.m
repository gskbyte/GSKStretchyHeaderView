#import "GSKExampleNavigationBarViewController.h"
#import "GSKTestStretchyHeaderView.h"

@interface GSKExampleNavigationBarViewController ()

@end

@implementation GSKExampleNavigationBarViewController

- (GSKStretchyHeaderView *)loadStretchyHeaderView {
    GSKTestStretchyHeaderView *headerView = [[GSKTestStretchyHeaderView alloc] initWithFrame:CGRectMake(0, 64, self.tableView.frame.size.width, 200)];
    headerView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);

    return headerView;
}

@end
