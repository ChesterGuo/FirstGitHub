//
//  TRCategory.m
//  TRDeals
//
//  Created by tarena on 15/6/25.
//  Copyright (c) 2015年 Tarena. All rights reserved.
//

#import "TRCategory.h"

@implementation TRCategory
+ (id)parseCategoryData:(NSDictionary *)categoryDic
{
    return [[self alloc] initWithcategoryDic:(NSDictionary *)categoryDic];
}
- (id)initWithcategoryDic:(NSDictionary *)categoryDic
{
    if (self = [super init])
    {
        self.icon = categoryDic[@"icon"];
        self.highlighted_icon =categoryDic[@"highlighted_icon"];
        self.small_icon = categoryDic[@"small_icon"];
        self.small_highlighted_icon = categoryDic[@"small_highlighted_icon"];
        self.name = categoryDic[@"name"];
        self.subcategories = categoryDic[@"subcategories"];
        self.map_icon = categoryDic[@"map_icon"];
    }
    return self;
    
}
@end
