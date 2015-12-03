//
//  TagListCollectionView.m
//  ESTCollectionViewDropDownList
//
//  Created by Aufree on 12/3/15.
//  Copyright © 2015 The EST Group. All rights reserved.
//

#import "TagListCollectionView.h"
#import "TagListCollectionViewCell.h"

#import "TagEntity.h"

static NSString *radioHeaderViewCellReuseId = @"radioHeaderViewCellReuseId";

@interface TagListCollectionView () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) NSArray *tags;
@property (nonatomic, assign) BOOL isFirstLoad;
@end

@implementation TagListCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setTagList:(TagListEntity *)tagList {
    _tagList = tagList;
    _tags = [self loadTags];
    [self reloadData];
}

- (NSMutableArray *)loadTags {
    NSMutableArray *tags = @[].mutableCopy;
    TagEntity *newTag = [TagEntity new];
    newTag.tagId = @0;
    newTag.tagName = @"全部";
    newTag.didSelected = YES;
    [tags addObject:newTag];
    [tags addObjectsFromArray:_tagList.tags];
    return tags;
}

- (void)setup {
    self.delegate = self;
    self.dataSource = self;
    [self registerClass:[TagListCollectionViewCell class] forCellWithReuseIdentifier:radioHeaderViewCellReuseId];
    self.backgroundColor = [UIColor clearColor];
    self.showsHorizontalScrollIndicator = NO;
    _isFirstLoad = YES;
}

# pragma mark - Collection View data source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _tags.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    TagEntity *tagEntity = _tags[indexPath.row];
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:ESTDropDownListTagFontSize], NSFontAttributeName, nil];
    CGFloat tagWidth = [[[NSAttributedString alloc] initWithString:tagEntity.tagName attributes:attributes] size].width;
    return CGSizeMake(tagWidth, ESTDropDownListTagHeight);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TagListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:radioHeaderViewCellReuseId forIndexPath:indexPath];
    TagEntity *tagEntity = _tags[indexPath.row];
    cell.tagEntity = tagEntity;
    if (indexPath.row == 0 && _isFirstLoad) {
        _isFirstLoad = NO;
        [self selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    }
    return cell;
}

# pragma mark - Collection View delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self updateCellWithIndexPath:indexPath didSelected:YES];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [self updateCellWithIndexPath:indexPath didSelected:NO];
}

- (void)updateCellWithIndexPath:(NSIndexPath *)indexPath didSelected:(BOOL)didSelected {
    TagListCollectionViewCell *cell = (TagListCollectionViewCell *)[self cellForItemAtIndexPath:indexPath];
    TagEntity *tagEntity = _tags[indexPath.row];
    tagEntity.didSelected = didSelected;
    cell.tagEntity = tagEntity;
    if (_collectionViewDelegate && [_collectionViewDelegate respondsToSelector:@selector(didTouchTagInCollectionIndex:cellIndex:)]) {
        [_collectionViewDelegate didTouchTagInCollectionIndex:_index cellIndex:indexPath.row];
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 15, 0, 10);
}


@end
