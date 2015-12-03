//
//  TagListEntity.h
//  ESTCollectionViewDropDownList
//
//  Created by Aufree on 12/3/15.
//  Copyright © 2015 The EST Group. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "BaseEntity.h"

@interface TagListEntity : BaseEntity

@property (nonatomic, copy) NSNumber *tagListId;
@property (nonatomic, copy) NSString *tagListName;
@property (nonatomic, copy) NSArray *tags;

@end
