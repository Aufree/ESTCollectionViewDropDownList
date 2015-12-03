//
//  DidSelectedTagsCollectionView.m
//  ESTCollectionViewDropDownList
//
//  Created by Aufree on 12/3/15.
//  Copyright © 2015 The EST Group. All rights reserved.
//

#import "DidSelectedTagsCollectionView.h"
#import "DidSelectedTagsCell.h"
#import "SelectedTagReusableView.h"

#import "TagEntity.h"

static NSString *didSelectedTagHeaderReuseId = @"didSelectedTagHeaderReuseId";
static NSString *didSelectedTagCellReuseId = @"didSelectedTagCellReuseId";

@interface DidSelectedTagsCollectionView () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@end

@implementation DidSelectedTagsCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.delegate = self;
    self.dataSource = self;
    [self registerClass:[DidSelectedTagsCell class] forCellWithReuseIdentifier:didSelectedTagCellReuseId];
    [self registerClass:[SelectedTagReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:didSelectedTagCellReuseId];
    self.allowsMultipleSelection = YES;
    self.backgroundColor = [UIColor clearColor];
    self.showsHorizontalScrollIndicator = NO;
}

# pragma mark - Collection View

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _tags.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    TagEntity *tag = _tags[indexPath.row];
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:ESTDropDownListTagFontSize], NSFontAttributeName, nil];
    CGFloat tagWidth = [[[NSAttributedString alloc] initWithString:tag.tagName attributes:attributes] size].width;
    return CGSizeMake(tagWidth, ESTDropDownListTagHeight);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DidSelectedTagsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:didSelectedTagCellReuseId forIndexPath:indexPath];
    TagEntity *tag = _tags[indexPath.row];
    cell.tagString = tag.tagName;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        SelectedTagReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                                 withReuseIdentifier:didSelectedTagCellReuseId
                                                                                        forIndexPath:indexPath];
        headerView.tagsTitle = @"规则:";
        reusableview = headerView;
    }
    
    return reusableview;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 10);
}


@end
