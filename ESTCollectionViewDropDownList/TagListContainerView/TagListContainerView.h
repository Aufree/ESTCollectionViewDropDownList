//
//  TagListContainerView.h
//  ESTCollectionViewDropDownList
//
//  Created by Aufree on 12/3/15.
//  Copyright © 2015 The EST Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TagListContainerViewDelegate <NSObject>
- (void)didSelectedTags:(NSMutableArray *)tags;
@end

@interface TagListContainerView : UIView
@property (nonatomic, copy) NSArray *tagsEntities;
@property (nonatomic, weak) id<TagListContainerViewDelegate> delegate;
@end
