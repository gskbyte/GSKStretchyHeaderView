#import "GSKExampleCollectionViewController.h"
#import "GSKStretchyHeaderView.h"
#import "UINavigationController+Transparency.h"

static const NSUInteger kNumberOfRows = 100;

@interface GSKExampleCollectionViewController () <UICollectionViewDelegateFlowLayout>
@property (nonatomic) GSKExampleData *data;
@property (nonatomic) GSKStretchyHeaderView *stretchyHeaderView;
@property (nonatomic) NSMutableArray<NSNumber *> *rowHeights;
@end

@interface GSKViewControllerCell : UICollectionViewCell
+ (NSString *)reuseIdentifier;
+ (void)registerIn:(UICollectionView *)collectionView;
@end

@implementation GSKExampleCollectionViewController

- (instancetype)initWithData:(GSKExampleData *)data {
    UICollectionViewFlowLayout *collectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
    collectionViewLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    collectionViewLayout.minimumLineSpacing = 0;
    collectionViewLayout.minimumInteritemSpacing = 0;

    self = [super initWithCollectionViewLayout:collectionViewLayout];
    if (self) {
        self.data = data;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [GSKViewControllerCell registerIn:self.collectionView];

    if (self.data.headerViewClass) {
        self.stretchyHeaderView = [[self.data.headerViewClass alloc] initWithFrame:CGRectMake(0, 0, self.collectionView.frame.size.width, self.data.headerViewInitialHeight)];
    } else {
        NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:self.data.nibName
                                                          owner:self
                                                        options:nil];
        self.stretchyHeaderView = nibViews.firstObject;
    }

    [self.collectionView addSubview:self.stretchyHeaderView];

    self.rowHeights = [NSMutableArray arrayWithCapacity:kNumberOfRows];
    for (NSUInteger i = 0; i < kNumberOfRows; ++i) {
        CGFloat height = 40 + arc4random_uniform(160);
        [self.rowHeights addObject:@(height)];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!self.data.navigationBarVisible) {
        [self.navigationController gsk_setNavigationBarTransparent:YES animated:NO];
        self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
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