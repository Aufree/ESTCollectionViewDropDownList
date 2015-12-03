//
//  RadioEntity.h
//  ESTCollectionViewDropDownList
//
//  Created by Aufree on 12/3/15.
//  Copyright © 2015 The EST Group. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "BaseEntity.h"

@interface RadioEntity : BaseEntity
@property (nonatomic, copy) NSNumber *radioId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *cover;
@end
