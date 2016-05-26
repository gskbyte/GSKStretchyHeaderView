#import "GSKExampleDataCell.h"
#import "UIView+GSKLayoutHelper.h"

@interface GSKExampleDataCell ()
@property (nonatomic) UIButton *titleButton;
@property (nonatomic) UIButton *collectionViewControllerButton;
@property (nonatomic) UIButton *tableViewControllerButton;
@end

@implementation GSKExampleDataCell

+ (NSString *)reuseIdentifier {
    return NSStringFromClass(self);
}

+ (void)registerIn:(UITableView *)tableView {
    [tableView registerClass:self
      forCellReuseIdentifier:[self reuseIdentifier]];
}

+ (CGFloat)height {
    return 60;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    self.titleButton = [[UIButton alloc] init];
    [self configureButton:self.titleButton];

    self.collectionViewControllerButton = [[UIButton alloc] init];
    [self.collectionViewControllerButton setTitle:@"Collection view"
                                         forState:UIControlStateNormal];
    [self configureButton:self.collectionViewControllerButton];

    self.tableViewControllerButton = [[UIButton alloc] init];
    [self.tableViewControllerButton setTitle:@"Table view"
                                    forState:UIControlStateNormal];
    [self configureButton:self.tableViewControllerButton];
}

- (void)configureButton:(UIButton *)button {
    [button setTitleColor:[UIColor blueColor]
                 forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor]
                 forState:UIControlStateDisabled];
    [button addTarget:self
               action:@selector(didTapButton:)
     forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:button];
}

- (void)setData:(GSKExampleData *)data {
    _data = data;
    [self.titleButton setTitle:data.title forState:UIControlStateNormal];

    if (data.viewControllerClass) {
        self.titleButton.enabled = YES;
        self.collectionViewControllerButton.hidden = YES;
        self.tableViewControllerButton.hidden = YES;
    } else {
        self.titleButton.enabled = NO;
        self.collectionViewControllerButton.hidden = NO;
        self.tableViewControllerButton.hidden = NO;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.data.viewControllerClass) {
        self.titleButton.frame = self.bounds;
    } else {
        CGFloat buttonHeight = self.height / 2;

        self.titleButton.width = self.width;
        self.titleButton.height = buttonHeight;

        self.collectionViewControllerButton.top = buttonHeight;
        self.collectionViewControllerButton.width = self.width / 2;
        self.collectionViewControllerButton.height = buttonHeight;

        self.tableViewControllerButton.top = buttonHeight;
        self.tableViewControllerButton.left = self.collectionViewControllerButton.right;
        self.tableViewControllerButton.width = self.width / 2;
        self.tableViewControllerButton.height = buttonHeight;
    }
}

- (void)didTapButton:(id)sender {
    if (sender == self.titleButton) {
        [self.delegate exampleDataCellDidTapTitleButton:self];
    } else if (sender == self.collectionViewControllerButton) {
        [self.delegate exampleDataCellDidTapCollectionViewButton:self];
    } else if (sender == self.tableViewControllerButton) {
        [self.delegate exampleDataCellDidTapTableViewButton:self];
    }
}

@end
