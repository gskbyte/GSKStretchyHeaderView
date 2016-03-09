#import "GSKExampleTableViewController.h"
#import "UINavigationController+Transparency.h"

@implementation GSKExampleTableViewController

- (instancetype)initWithData:(GSKExampleData *)data {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        _data = data;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!self.data.navigationBarVisible) {
        [self.navigationController gsk_setNavigationBarTransparent:YES animated:NO];
        self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    }
}

- (GSKStretchyHeaderView *)loadStretchyHeaderView {
    GSKStretchyHeaderView *headerView;

    if (self.data.headerViewClass) {
        headerView = [[self.data.headerViewClass alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, self.data.headerViewInitialHeight)];
    } else {
        NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:self.data.nibName
                                                          owner:self
                                                        options:nil];
        headerView = nibViews.firstObject;
    }

    return headerView;
}

@end
