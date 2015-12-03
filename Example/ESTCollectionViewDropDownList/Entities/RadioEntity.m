//
//  RadioEntity.m
//  ESTCollectionViewDropDownList
//
//  Created by Aufree on 12/3/15.
//  Copyright © 2015 The EST Group. All rights reserved.
//

#import "RadioEntity.h"

@implementation RadioEntity

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"radioId" : @"id",
             @"name" : @"name",
             @"cover" : @"cover",
             };
}

@end
