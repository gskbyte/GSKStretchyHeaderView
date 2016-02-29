#import "GSKExampleDataSource.h"
#import "GSKTableViewCell.h"
#import "GSKCollectionViewCell.h"

@interface GSKExampleDataSource ()
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic) NSMutableArray<NSNumber *> *rowHeights;
@end

@implementation GSKExampleDataSource

- (instancetype)initWithNumberOfRows:(NSUInteger)numberOfRows {
    self = [super init];
    if (self) {
        _numberOfRows = numberOfRows;
        self.rowHeights = [NSMutableArray arrayWithCapacity:numberOfRows];
        for (NSUInteger i = 0; i < numberOfRows; ++i) {
            CGFloat height = 40 + arc4random_uniform(160);
            [self.rowHeights addObject:@(height)];
        }
    }
    return self;
}

- (void)registerForTableView:(UITableView *)tableView {
    _scrollView = tableView;
    
    tableView.dataSource = self;
    tableView.delegate = self;
    [GSKTableViewCell registerIn:tableView];
}

- (void)registerForCollectionView:(UICollectionView *)collectionView {
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [GSKCollectionViewCell registerIn:collectionView];
}

#pragma mark - table view

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.numberOfRows;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.rowHeights[indexPath.row] floatValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GSKTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[GSKTableViewCell reuseIdentifier]];
    cell.backgroundColor = indexPath.item % 2 ? [UIColor grayColor] : [UIColor lightGrayColor];
    return cell;
}

#pragma mark - collectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.rowHeights.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GSKCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[GSKCollectionViewCell reuseIdentifier]
                                                                            forIndexPath:indexPath];
    cell.backgroundColor = indexPath.item % 2 ? [UIColor grayColor] : [UIColor lightGrayColor];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.frame.size.width,
                      [self.rowHeights[indexPath.item] floatValue]);
}

@end
