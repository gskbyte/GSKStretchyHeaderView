#import "GSKExampleBaseTableViewController.h"
#import "GSKExampleData.h"

@interface GSKExampleTableViewController : GSKExampleBaseTableViewController

@property (nonatomic, readonly) GSKExampleData *data;

- (instancetype)initWithData:(GSKExampleData *)data;

@end
