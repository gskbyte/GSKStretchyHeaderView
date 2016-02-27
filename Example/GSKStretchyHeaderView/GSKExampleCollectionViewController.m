#import "GSKExampleCollectionViewController.h"
#import "GSKStretchyHeaderView.h"
#import "UINavigationController+Transparency.h"

static const NSUInteger kNumberOfRows = 100;

@interface GSKExampleCollectionViewController () <UICollectionViewDelegateFlowLayout>
@property (nonatomic) Class stretchyHeaderViewClass;
@property (nonatomic) GSKStretchyHeaderView *stretchyHeaderView;
@property (nonatomic) NSMutableArray<NSNumber *> *rowHeights;
@end

@interface GSKViewControllerCell : UICollectionViewCell
+ (NSString *)reuseIdentifier;
+ (void)registerIn:(UICollectionView *)collectionView;
@end

@implementation GSKExampleCollectionViewController

- (instancetype)initWithStretchyHeaderViewClass:(Class)stretchyHeaderViewClass {
    UICollectionViewFlowLayout *collectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
    collectionViewLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    collectionViewLayout.minimumLineSpacing = 0;
    collectionViewLayout.minimumInteritemSpacing = 0;

    self = [super initWithCollectionViewLayout:collectionViewLayout];
    if (self) {
        self.stretchyHeaderViewClass = stretchyHeaderViewClass;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.collectionView.backgroundColor = [UIColor whiteColor];
    [GSKViewControllerCell registerIn:self.collectionView];

    self.stretchyHeaderView = [[self.stretchyHeaderViewClass alloc] initWithFrame:CGRectMake(0, 0, self.collectionView.frame.size.width, 200)];
    [self.collectionView addSubview:self.stretchyHeaderView];

    self.rowHeights = [NSMutableArray arrayWithCapacity:kNumberOfRows];
    for (NSUInteger i = 0; i < kNumberOfRows; ++i) {
        CGFloat height = 40 + arc4random_uniform(160);
        [self.rowHeights addObject:@(height)];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.stretchyHeaderView.minimumHeight > 0) {
        [self.navigationController gsk_setNavigationBarTransparent:YES animated:NO];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.rowHeights.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GSKViewControllerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[GSKViewControllerCell reuseIdentifier]
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

@implementation GSKViewControllerCell

+ (NSString *)reuseIdentifier {
    return NSStringFromClass(self.class);
}

+ (void)registerIn:(UICollectionView *)collectionView {
    [collectionView registerClass:self.class
       forCellWithReuseIdentifier:[self reuseIdentifier]];
}

@end