#import <UIKit/UIKit.h>

@interface GSKTableViewCell : UITableViewCell
+ (NSString *)reuseIdentifier;
+ (void)registerIn:(UITableView *)tableView;
@end
