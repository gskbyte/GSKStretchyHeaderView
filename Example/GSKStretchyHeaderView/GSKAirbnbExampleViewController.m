#import "GSKAirbnbExampleViewController.h"
#import "GSKAirbnbStretchyHeaderView.h"
#import "GSKExampleDataSource.h"

@interface GSKAirbnbExampleViewController () <GSKAirbnbStretchyHeaderViewDelegate>
@property (nonatomic, readonly) UICollectionViewFlowLayout *collectionViewFlowLayout;
@property (nonatomic) GSKStretchyHeaderView *stretchyHeaderView;
@property (nonatomic) GSKExampleDataSource *dataSource;
@end

@interface GSKPresentableViewController : UIViewController

@end

@implementation GSKAirbnbExampleViewController

- (instancetype)init {
    UICollectionViewFlowLayout *collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    collectionViewFlowLayout.minimumLineSpacing = 0;
    collectionViewFlowLayout.minimumInteritemSpacing = 0;
    
    return [super initWithCollectionViewLayout:collectionViewFlowLayout];
}

- (UICollectionViewFlowLayout *)collectionViewFlowLayout {
    return (UICollectionViewFlowLayout *)self.collectionViewLayout;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    if (@available(iOS 11.0, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }

    self.stretchyHeaderView = [self loadStretchyHeaderView];
    [self.collectionView addSubview:self.stretchyHeaderView];
    
    self.dataSource = [[GSKExampleDataSource alloc] init];
    [self.dataSource registerForCollectionView:self.collectionView];
    
    self.dataSource.numberOfSections = 10;
    self.dataSource.numberOfRowsInEverySection = 6;
    self.dataSource.displaysSectionHeaders = YES;
    self.dataSource.cellColors = @[[UIColor whiteColor], [UIColor lightGrayColor]];
    
    self.collectionView.refreshControl = [[UIRefreshControl alloc] init];
    [self.collectionView.refreshControl addTarget:self action:@selector(beginRefreshing:) forControlEvents:UIControlEventValueChanged];
}

- (GSKStretchyHeaderView *)loadStretchyHeaderView {
    CGRect frame = CGRectMake(0, 0, self.collectionView.frame.size.width, 250);
    GSKAirbnbStretchyHeaderView *headerView = [[GSKAirbnbStretchyHeaderView alloc] initWithFrame:frame];
    headerView.maximumContentHeight = 300;
    headerView.minimumContentHeight = 84;
    headerView.contentExpands = NO;
    headerView.delegate = self;
    return headerView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)airbnbStretchyHeaderView:(GSKAirbnbStretchyHeaderView *)headerView
                didTapBackButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)airbnbStretchyHeaderView:(GSKAirbnbStretchyHeaderView *)headerView
              didTapSearchButton:(id)sender {
    CGPoint contentOffset = self.collectionView.contentOffset;
    if (contentOffset.y < -self.stretchyHeaderView.minimumContentHeight) {
        contentOffset.y = -self.stretchyHeaderView.minimumContentHeight;
        [self.collectionView setContentOffset:contentOffset animated:YES];
    }
}

- (void)airbnbStretchyHeaderView:(GSKAirbnbStretchyHeaderView *)headerView didTapSearchBar:(id)sender {
    // TODO improve this to make it look better

    UIViewController *viewController = [[GSKPresentableViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
    [self presentViewController:navController animated:YES completion:nil];
}

- (void)beginRefreshing:(id)sender {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.collectionView.refreshControl endRefreshing];
    });
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.frame.size.width,
                      [self.dataSource heightForItemAtIndexPath:indexPath]);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(collectionView.frame.size.width, 20);
}

@end

@implementation GSKPresentableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Dismiss" style:UIBarButtonItemStyleDone target:self action:@selector(dismissSelf:)];
}

- (void)dismissSelf:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
