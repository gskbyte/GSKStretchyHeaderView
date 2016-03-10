@import UIKit;
@import GSKStretchyHeaderView;

#import "GSKExampleDataSource.h"

@interface GSKExampleBaseTableViewController : UITableViewController

@property (nonatomic, readonly) GSKStretchyHeaderView *stretchyHeaderView;
@property (nonatomic, readonly) GSKExampleDataSource *dataSource;

- (GSKExampleDataSource *)loadDataSource;
- (GSKStretchyHeaderView *)loadStretchyHeaderView;

@end
