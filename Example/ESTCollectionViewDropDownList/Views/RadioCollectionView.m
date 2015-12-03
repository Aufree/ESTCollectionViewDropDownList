//
//  RadioCollectionView.m
//  ESTCollectionViewDropDownList
//
//  Created by Aufree on 12/3/15.
//  Copyright © 2015 The EST Group. All rights reserved.
//

#import "RadioCollectionView.h"
#import "RadioCollectionViewCell.h"

static NSString *radioCollectionViewCell = @"radioCollectionViewCell";
static NSString *radioHeaderViewReuseId = @"radioHeaderViewReuseId";

@interface RadioCollectionView () <UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation RadioCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    [self setupCollectionView];
}

- (void)setupCollectionView {
    self.delegate = self;
    self.dataSource = self;
    self.backgroundColor = [UIColor colorWithWhite:0.941 alpha:1.000];
    [self registerClass:[RadioCollectionViewCell class] forCellWithReuseIdentifier:radioCollectionViewCell];
}

# pragma mark - Collection view data source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _radioEntities.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RadioCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:radioCollectionViewCell forIndexPath:indexPath];
    cell.radioEntity = _radioEntities[indexPath.row];
    return cell;
}

# pragma mark - Scroll view delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y > 10) {
        if (_radioCollectionDelegate && [_radioCollectionDelegate respondsToSelector:@selector(hideFileterViewIfNeeded)]) {
            [_radioCollectionDelegate hideFileterViewIfNeeded];
        }
    }
    
}

@end
