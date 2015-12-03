//
//  TagEntity.h
//  ESTCollectionViewDropDownList
//
//  Created by Aufree on 12/3/15.
//  Copyright © 2015 The EST Group. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "BaseEntity.h"

@interface TagEntity : BaseEntity

@property (nonatomic, copy) NSNumber *tagId;
@property (nonatomic, copy) NSString *tagName;
@property (nonatomic, assign) BOOL didSelected;

@end
