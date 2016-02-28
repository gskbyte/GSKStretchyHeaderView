#import "GSKTableViewCell.h"

@implementation GSKTableViewCell

+ (NSString *)reuseIdentifier {
    return NSStringFromClass(self.class);
}

+ (void)registerIn:(UITableView *)tableView {
    [tableView registerClass:self.class
      forCellReuseIdentifier:[self reuseIdentifier]];
}

@end
