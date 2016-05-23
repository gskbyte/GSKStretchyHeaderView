@import UIKit;
@import GSKStretchyHeaderView;

#import "GSKExampleDataSource.h"

NS_ASSUME_NONNULL_BEGIN

@interface GSKExampleBaseTableViewController : UITableViewController

@property (nonatomic, readonly) GSKStretchyHeaderView *stretchyHeaderView;
@property (nonatomic, readonly) GSKExampleDataSource *dataSource;

- (GSKExampleDataSource *)loadDataSource;
- (GSKStretchyHeaderView *)loadStretchyHeaderView;

@end

NS_ASSUME_NONNULL_END
