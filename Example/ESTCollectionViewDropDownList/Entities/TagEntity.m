//
//  TagEntity.m
//  ESTCollectionViewDropDownList
//
//  Created by Aufree on 12/3/15.
//  Copyright © 2015 The EST Group. All rights reserved.
//

#import "TagEntity.h"

@implementation TagEntity

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"tagId" : @"id",
             @"tagName" : @"name"
             };
}

@end
