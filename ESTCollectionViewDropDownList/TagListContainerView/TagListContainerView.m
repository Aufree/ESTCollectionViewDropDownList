//
//  TagListContainerView.m
//  ESTCollectionViewDropDownList
//
//  Created by Aufree on 12/3/15.
//  Copyright © 2015 The EST Group. All rights reserved.
//

#import "TagListContainerView.h"
#import "TagListCollectionView.h"
#import "Masonry.h"

#import "TagListEntity.h"
#import "TagEntity.h"

@interface TagListContainerView () <TagListCollectionViewDelegate>
@property (nonatomic, assign) BOOL hasBeenLoad;
@property (nonatomic, strong) NSMutableArray *didSeletedTags;
@end

@implementation TagListContainerView

- (void)setTagsEntities:(NSArray *)tagsEntities {
    _tagsEntities = tagsEntities;
    [self setup];
}

- (void)setup {
    if (_hasBeenLoad) { return; }
    self.backgroundColor = [UIColor whiteColor];
    self.didSeletedTags = [NSMutableArray new];
    self.clipsToBounds = YES;
    
    _tagsEntities = [TagListEntity arrayOfEntitiesFromArray:_tagsEntities];
    
    for (int i = 0; i < _tagsEntities.count; i++) {
        _hasBeenLoad = YES;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        TagListCollectionView *collectionView = [[TagListCollectionView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, ESTDropDownListTagHeight) collectionViewLayout:layout];
        [self addSubview:collectionView];
        [self addAutoLayoutWithCollectionView:collectionView index:i];
        collectionView.index = i;
        collectionView.tagList = _tagsEntities[i];
        collectionView.collectionViewDelegate = self;
        [collectionView reloadData];
    }
}

- (void)addAutoLayoutWithCollectionView:(TagListCollectionView *)collecitonView index:(NSInteger)index {
    [collecitonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(index * ESTDropDownListTagHeight);
        make.left.offset(0);
        make.right.offset(0);
        make.height.offset(ESTDropDownListTagHeight);
    }];
}

- (void)didTouchTagInCollectionIndex:(NSInteger)collectionViewIndex cellIndex:(NSInteger)index {
    TagListEntity *tagList = _tagsEntities[collectionViewIndex];
    
    for (TagEntity *tag in tagList.tags) {
        if ([_didSeletedTags containsObject:tag]) {
            [_didSeletedTags removeObject:tag];
        }
    }
    
    if (index != 0) {
        TagEntity *tag = tagList.tags[index - 1];
        [_didSeletedTags addObject:tag];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectedTags:)]) {
        [_delegate didSelectedTags:_didSeletedTags];
    }
}

@end
