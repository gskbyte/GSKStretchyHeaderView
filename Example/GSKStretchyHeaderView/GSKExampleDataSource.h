#import <Foundation/Foundation.h>

@interface GSKExampleDataSource : NSObject<UITableViewDataSource, UITableViewDelegate,
                                           UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, readonly) NSUInteger numberOfRows;
@property (nonatomic) NSArray<UIColor *> *cellColors;

- (instancetype)initWithNumberOfRows:(NSUInteger)numberOfRows;
- (void)registerForTableView:(UITableView *)tableView;
- (void)registerForCollectionView:(UICollectionView *)collectionView;

@end
