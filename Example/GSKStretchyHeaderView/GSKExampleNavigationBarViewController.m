#import "GSKExampleNavigationBarViewController.h"
#import "GSKTestStretchyHeaderView.h"

@interface GSKExampleNavigationBarViewController ()

@end

@implementation GSKExampleNavigationBarViewController

- (instancetype)initWithData:(GSKExampleData *)data {
    self = [super initWithData:data];
    if (self) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    return self;
}
- (GSKStretchyHeaderView *)loadStretchyHeaderView {
    GSKTestStretchyHeaderView *headerView = [[GSKTestStretchyHeaderView alloc] initWithFrame:CGRectMake(0, 64, self.tableView.frame.size.width, 200)];
    headerView.contentInset = UIEdgeInsetsMake(self.topLayoutGuide.length, 0, 0, 0);

    return headerView;
}


@end
