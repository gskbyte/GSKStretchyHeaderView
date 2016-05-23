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
        self.cellColors = @[[UIColor grayColor], [UIColor lightGrayColor]];
    }
    return self;
}

- (void)registerForTableView:(UITableView *)tableView {
    _scrollView = tableView;
    
    tableView.dataSource = self;
    [GSKTableViewCell registerIn:tableView];
}

- (void)registerForCollectionView:(UICollectionView *)collectionView {
    collectionView.dataSource = self;
    [GSKCollectionViewCell registerIn:collectionView];
}

#pragma mark - table view

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.numberOfRows;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GSKTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[GSKTableViewCell reuseIdentifier]];
    cell.contentView.backgroundColor = self.cellColors[indexPath.row % self.cellColors.count];
    return cell;
}

#pragma mark - collectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.rowHeights.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GSKCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[GSKCollectionViewCell reuseIdentifier]
                                                                            forIndexPath:indexPath];
    cell.contentView.backgroundColor = self.cellColors[indexPath.item % self.cellColors.count];
    return cell;
}

- (CGFloat)heightForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self.rowHeights[indexPath.item] floatValue];
}

@end
