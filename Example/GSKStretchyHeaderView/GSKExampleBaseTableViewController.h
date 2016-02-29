@import UIKit;
@import GSKStretchyHeaderView;

#import "GSKExampleData.h"
#import "GSKExampleDataSource.h"

@interface GSKExampleBaseTableViewController : UITableViewController

@property (nonatomic, readonly) GSKExampleData *data;
@property (nonatomic, readonly) GSKStretchyHeaderView *stretchyHeaderView;
@property (nonatomic, readonly) GSKExampleDataSource *dataSource;

- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithStyle:(UITableViewStyle)style NS_UNAVAILABLE;
- (instancetype)initWithData:(GSKExampleData *)data;
- (GSKStretchyHeaderView *)loadStretchyHeaderView;

@end
