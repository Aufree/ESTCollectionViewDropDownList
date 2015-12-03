//
//  TagListEntity.m
//  ESTCollectionViewDropDownList
//
//  Created by Aufree on 12/3/15.
//  Copyright © 2015 The EST Group. All rights reserved.
//

#import "TagListEntity.h"
#import "TagEntity.h"

@implementation TagListEntity

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"tagListId" : @"id",
             @"tagListName" : @"name",
             @"tags" : @"children.data"
             };
}

+ (NSValueTransformer *)tagsJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[TagEntity class]];
}

@end
