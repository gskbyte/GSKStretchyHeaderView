#import "GSKExampleBaseTableViewController.h"
#import "GSKExampleData.h"

NS_ASSUME_NONNULL_BEGIN

@interface GSKExampleTableViewController : GSKExampleBaseTableViewController

@property (nonatomic, readonly) GSKExampleData *data;

- (instancetype)initWithData:(GSKExampleData *)data;

@end

NS_ASSUME_NONNULL_END
