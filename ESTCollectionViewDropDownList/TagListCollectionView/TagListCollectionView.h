//
//  TagListCollectionView.h
//  ESTCollectionViewDropDownList
//
//  Created by Aufree on 12/3/15.
//  Copyright © 2015 The EST Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagListEntity.h"

@protocol TagListCollectionViewDelegate <NSObject>
- (void)didTouchTagInCollectionIndex:(NSInteger)collectionViewIndex cellIndex:(NSInteger)index;
@end

@interface TagListCollectionView : UICollectionView
@property (nonatomic, strong) TagListEntity *tagList;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, weak) id<TagListCollectionViewDelegate> collectionViewDelegate;
@end
