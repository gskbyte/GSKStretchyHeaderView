#import "GSKExampleCollectionViewController.h"
#import "GSKStretchyHeaderView.h"
#import "UINavigationController+Transparency.h"
#import "GSKExampleDataSource.h"

NS_ASSUME_NONNULL_BEGIN

static const NSUInteger kNumberOfRows = 100;

@interface GSKExampleCollectionViewController () <UICollectionViewDelegateFlowLayout>
@property (nonatomic) GSKExampleData *data;
@property (nonatomic) GSKStretchyHeaderView *stretchyHeaderView;
@property (nonatomic) GSKExampleDataSource *dataSource;
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

    self.collectionView.backgroundColor = [UIColor whiteColor];

    if (self.data.headerViewClass) {
        self.stretchyHeaderView = [[self.data.headerViewClass alloc] initWithFrame:CGRectMake(0, 0, self.collectionView.frame.size.width, self.data.headerViewInitialHeight)];
    } else {
        NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:self.data.nibName
                                                          owner:self
                                                        options:nil];
        self.stretchyHeaderView = nibViews.firstObject;
    }
    [self.collectionView addSubview:self.stretchyHeaderView];

    self.dataSource = [[GSKExampleDataSource alloc] initWithNumberOfRows:kNumberOfRows];
    [self.dataSource registerForCollectionView:self.collectionView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!self.data.navigationBarVisible) {
        [self.navigationController gsk_setNavigationBarTransparent:YES animated:NO];
        self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.collectionView.frame.size.width,
                      [self.dataSource heightForItemAtIndexPath:indexPath]);
}

@end

NS_ASSUME_NONNULL_END
