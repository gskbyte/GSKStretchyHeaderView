#import <Foundation/Foundation.h>

@interface GSKExampleDataSource : NSObject<UITableViewDataSource,
                                           UICollectionViewDataSource>

@property (nonatomic, readonly) NSUInteger numberOfRows;
@property (nonatomic) NSArray<UIColor *> *cellColors;

- (instancetype)initWithNumberOfRows:(NSUInteger)numberOfRows;
- (void)registerForTableView:(UITableView *)tableView;
- (void)registerForCollectionView:(UICollectionView *)collectionView;
- (CGFloat)heightForItemAtIndexPath:(NSIndexPath *)indexPath;

@end
