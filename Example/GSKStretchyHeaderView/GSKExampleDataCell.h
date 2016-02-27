#import <UIKit/UIKit.h>
#import "GSKExampleData.h"

@protocol GSKExampleDataCellDelegate;

@interface GSKExampleDataCell : UITableViewCell

+ (NSString *)reuseIdentifier;
+ (void)registerIn:(UITableView *)tableView;
+ (CGFloat)height;

@property (nonatomic, weak) id<GSKExampleDataCellDelegate> delegate;
@property (nonatomic, weak) GSKExampleData *data;

@end

@protocol GSKExampleDataCellDelegate
- (void)exampleDataCellDidTapTitleButton:(GSKExampleDataCell *)cell;
- (void)exampleDataCellDidTapCollectionViewButton:(GSKExampleDataCell *)cell;
- (void)exampleDataCellDidTapTableViewButton:(GSKExampleDataCell *)cell;
@end
