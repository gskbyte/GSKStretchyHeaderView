#import <UIKit/UIKit.h>

@interface GSKCollectionViewCell : UICollectionViewCell
+ (NSString *)reuseIdentifier;
+ (void)registerIn:(UICollectionView *)collectionView;
@end
