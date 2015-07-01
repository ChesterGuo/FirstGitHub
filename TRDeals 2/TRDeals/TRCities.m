//
//  TRCities.m
//  TRDeals
//
//  Created by tarena on 15/6/25.
//  Copyright (c) 2015年 Tarena. All rights reserved.
//

#import "TRCities.h"
#import "TRRegion.h"
@implementation TRCities
+ (id)parseCitiesWithData:(NSDictionary *)catiesDic
{
    return [[self alloc]initWithCatiesDic:(NSDictionary *)catiesDic];
}
- (id)initWithCatiesDic:(NSDictionary *)catiesDic
{
    if (self = [super init])
    {
        self.name = catiesDic[@"name"];
        self.pinYin = catiesDic[@"pinYin"];
        self.pinYinHead = catiesDic[@"pinYinHead"];
        NSMutableArray *mutArray = [NSMutableArray array];
        for (NSDictionary *regionsDic in catiesDic[@"regions"])
        {
            TRRegion *region = [[TRRegion alloc]init];
            region.name = regionsDic[@"name"];
            region.subregions = regionsDic[@"subregions"];
            [mutArray addObject:region];
        }
        
        self.regions = [mutArray copy];
    }
    return self;
}



@end
