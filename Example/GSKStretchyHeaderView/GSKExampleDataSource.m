#import "GSKExampleDataSource.h"
#import "GSKTableViewCell.h"
#import "GSKCollectionViewCell.h"

@interface GSKExampleDataSource ()
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic) NSMutableArray<NSNumber *> *rowHeights;
@end

@interface GSKAirbnbSectionTitleView: UICollectionReusableView
@property (nonatomic) UILabel *label;
@end

@implementation GSKExampleDataSource

- (instancetype)init {
    self = [super init];
    if (self) {
        _displaysSectionHeaders = false;
        _numberOfSections = 1;
        _numberOfRowsInEverySection = kDefaultNumberOfRows;
        [self updateRowHeights];
        self.cellColors = @[[UIColor grayColor], [UIColor lightGrayColor]];
    }
    return self;
}

- (void)setNumberOfRowsInEverySection:(NSUInteger)numberOfRowsInEverySection {
    _numberOfRowsInEverySection = numberOfRowsInEverySection;
    [self updateRowHeights];
}

- (void)registerForTableView:(UITableView *)tableView {
    _scrollView = tableView;
    
    tableView.dataSource = self;
    [GSKTableViewCell registerIn:tableView];
}

- (void)registerForCollectionView:(UICollectionView *)collectionView {
    collectionView.dataSource = self;
    [GSKCollectionViewCell registerIn:collectionView];
    [collectionView registerClass:[GSKAirbnbSectionTitleView class]
       forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
              withReuseIdentifier:NSStringFromClass([GSKAirbnbSectionTitleView class])];
}

- (void)updateRowHeights {
    self.rowHeights = [NSMutableArray arrayWithCapacity:self.numberOfRowsInEverySection];
    for (NSUInteger i = 0; i < self.numberOfRowsInEverySection; ++i) {
        CGFloat height = 40 + arc4random_uniform(160);
        [self.rowHeights addObject:@(height)];
    }
}

#pragma mark - table view

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self titleForSection:section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.numberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.numberOfRowsInEverySection;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GSKTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[GSKTableViewCell reuseIdentifier]];
    cell.contentView.backgroundColor = self.cellColors[indexPath.row % self.cellColors.count];
    return cell;
}

#pragma mark - collectionView

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.numberOfSections;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.rowHeights.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GSKCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[GSKCollectionViewCell reuseIdentifier]
                                                                            forIndexPath:indexPath];
    cell.contentView.backgroundColor = self.cellColors[indexPath.item % self.cellColors.count];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (!self.displaysSectionHeaders) {
        return nil;
    }
    
    GSKAirbnbSectionTitleView *titleView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                              withReuseIdentifier:NSStringFromClass([GSKAirbnbSectionTitleView class])
                                                                                     forIndexPath:indexPath];
    titleView.label.text = [self titleForSection:indexPath.section];
    return titleView;
}

#pragma mark - generic

- (CGFloat)heightForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self.rowHeights[indexPath.item] floatValue];
}

- (NSString *)titleForSection:(NSInteger)section {
    return self.displaysSectionHeaders ? [NSString stringWithFormat:@"Section #%@", @(section)] : nil;
}

@end


@implementation GSKAirbnbSectionTitleView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.label = [[UILabel alloc] initWithFrame:self.bounds];
        self.label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:self.label];
        
        self.backgroundColor = [UIColor grayColor];
    }
    return self;
}

@end
