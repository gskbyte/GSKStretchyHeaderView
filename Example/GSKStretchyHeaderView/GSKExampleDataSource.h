#import <Foundation/Foundation.h>

static const NSUInteger kDefaultNumberOfRows = 100;

@interface GSKExampleDataSource : NSObject<UITableViewDataSource,
                                           UICollectionViewDataSource>

// set to true to display basic titles: "Section #X"
@property (nonatomic) BOOL displaysSectionHeaders; // default value: false
@property (nonatomic) NSUInteger numberOfSections; // default value: 1
@property (nonatomic) NSUInteger numberOfRowsInEverySection;
@property (nonatomic) NSArray<UIColor *> *cellColors;

- (instancetype)init;
- (void)registerForTableView:(UITableView *)tableView;
- (void)registerForCollectionView:(UICollectionView *)collectionView;
- (CGFloat)heightForItemAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)titleForSection:(NSInteger)section;

@end
