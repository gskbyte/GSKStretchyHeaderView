#import "GSKExampleTableViewController.h"
#import "GSKStretchyHeaderView.h"
#import "UINavigationController+Transparency.h"

static const NSUInteger kNumberOfRows = 100;

@interface GSKExampleTableViewController ()
@property (nonatomic) Class stretchyHeaderViewClass;
@property (nonatomic) GSKStretchyHeaderView *stretchyHeaderView;
@property (nonatomic) NSMutableArray<NSNumber *> *rowHeights;
@end


@interface GSKViewControllerTableCell : UITableViewCell
+ (NSString *)reuseIdentifier;
+ (void)registerIn:(UITableView *)tableView;
@end


@implementation GSKExampleTableViewController

- (instancetype)initWithStretchyHeaderViewClass:(Class)stretchyHeaderViewClass {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        self.stretchyHeaderViewClass = stretchyHeaderViewClass;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [GSKViewControllerTableCell registerIn:self.tableView];

    self.stretchyHeaderView = [[self.stretchyHeaderViewClass alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 200)];
    [self.tableView addSubview:self.stretchyHeaderView];

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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return kNumberOfRows;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.rowHeights[indexPath.row] floatValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GSKViewControllerTableCell *cell = [tableView dequeueReusableCellWithIdentifier:[GSKViewControllerTableCell reuseIdentifier]];
    cell.backgroundColor = indexPath.item % 2 ? [UIColor grayColor] : [UIColor lightGrayColor];
    return cell;
}

@end

@implementation GSKViewControllerTableCell

+ (NSString *)reuseIdentifier {
    return NSStringFromClass(self.class);
}

+ (void)registerIn:(UITableView *)tableView {
    [tableView registerClass:self.class
      forCellReuseIdentifier:[self reuseIdentifier]];
}

@end