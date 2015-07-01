//
//  TRCityGroups.m
//  TRDeals
//
//  Created by tarena on 15/6/25.
//  Copyright (c) 2015年 Tarena. All rights reserved.
//

#import "TRCityGroups.h"

@implementation TRCityGroups
+ (id)parseCityGroupsWithcityGroupsDictionary:(NSDictionary *)cityGroupsDic
{
    return [[self alloc]initWithcityGroupsDictionary:(NSDictionary *)cityGroupsDic];
}
- (id)initWithcityGroupsDictionary:(NSDictionary *)cityGroupsDic
{
    if (self = [super init])
    {
        self.cities = cityGroupsDic[@"cities"];
        self.title = cityGroupsDic[@"title"];
    }
    return self;
}
@end
