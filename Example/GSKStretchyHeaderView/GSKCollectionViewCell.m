#import "GSKCollectionViewCell.h"

@implementation GSKCollectionViewCell

+ (NSString *)reuseIdentifier {
    return NSStringFromClass(self.class);
}

+ (void)registerIn:(UICollectionView *)collectionView {
    [collectionView registerClass:self.class
       forCellWithReuseIdentifier:[self reuseIdentifier]];
}

@end
