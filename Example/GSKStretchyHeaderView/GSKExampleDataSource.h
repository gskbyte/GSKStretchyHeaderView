//
//  GSKExampleDataSource.h
//  GSKStretchyHeader
//
//  Created by Jose Alcalá-Correa on 26/02/16.
//  Copyright © 2016 Jose Alcalá Correa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GSKExampleDataSource : NSObject<UITableViewDataSource, UITableViewDelegate,
                                           UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, readonly) NSUInteger numberOfRows;

- (instancetype)initWithNumberOfRows:(NSUInteger)numberOfRows;
- (void)registerForTableView:(UITableView *)tableView;
- (void)registerForCollectionView:(UICollectionView *)collectionView;

@end
