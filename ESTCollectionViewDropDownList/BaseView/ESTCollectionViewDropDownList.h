//
//  ESTCollectionViewDropDownList.h
//  ESTCollectionViewDropDownList
//
//  Created by Aufree on 12/3/15.
//  Copyright © 2015 The EST Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "DidSelectedTagsCollectionView.h"

typedef NS_ENUM(NSInteger, RadioDataType) {
    RadioDataTypeRecommended = 0,
    RadioDataTypeNewest = 1,
    RadioDataTypeHots = 2,
};

@protocol ESTCollectionViewDropDownListDelegate <NSObject>
- (void)touchFilterButtonWithOpenState:(BOOL)isOpen;
- (void)refreshRadioWithRadioDataType:(RadioDataType)radioDataType;
- (void)loadRadioByDidSelectedTagsId:(NSMutableArray *)tagsId;
@end

@interface ESTCollectionViewDropDownList : UIView
@property (nonatomic, weak) id<ESTCollectionViewDropDownListDelegate> delegate;
@property (nonatomic, copy) NSArray *tagsEntities;
@property (nonatomic, strong) MASConstraint *tagsContainerHeight;
@property (nonatomic, strong) DidSelectedTagsCollectionView *didSelectedTagsView;
- (void)didTouchFilterButton:(UIButton *)sender;
@end
