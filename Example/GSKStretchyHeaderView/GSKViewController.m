//
//  GSKViewController.m
//  GSKStretchyHeaderView
//
//  Created by Jose Alcalá Correa on 02/27/2016.
//  Copyright (c) 2016 Jose Alcalá Correa. All rights reserved.
//

#import "GSKViewController.h"
#import "GSKTestStretchyHeaderView.h"

@interface GSKViewController ()

@property (nonatomic) GSKTestStretchyHeaderView *stretchyHeader;

@end

@interface GSKViewControllerCell : UICollectionViewCell
+ (NSString *)reuseIdentifier;
+ (void)registerIn:(UICollectionView *)collectionView;
@end

@implementation GSKViewController

- (instancetype)init {
    UICollectionViewFlowLayout *collectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
    collectionViewLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    return [super initWithCollectionViewLayout:collectionViewLayout];
}

- (void)viewDidLoad {
    [super viewDidLoad];


    [GSKViewControllerCell registerIn:self.collectionView];

    self.stretchyHeader = [[GSKTestStretchyHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.collectionView.frame.size.width, 200)];
    [self.collectionView addSubview:self.stretchyHeader];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GSKViewControllerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[GSKViewControllerCell reuseIdentifier]
                                                                            forIndexPath:indexPath];
    cell.backgroundColor = indexPath.item % 2 ? [UIColor redColor] : [UIColor orangeColor];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.frame.size.width, 44);
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
