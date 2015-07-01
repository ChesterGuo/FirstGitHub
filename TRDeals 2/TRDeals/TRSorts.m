//
//  TRSorts.m
//  TRDeals
//
//  Created by tarena on 15/6/25.
//  Copyright (c) 2015年 Tarena. All rights reserved.
//

#import "TRSorts.h"

@implementation TRSorts
+(id)parseSortsWithSortsDictionary:(NSDictionary *)sortsDictionary
{
    return [[self alloc]initWithSortsDictionary:(NSDictionary *)sortsDictionary];
}
-(id)initWithSortsDictionary:(NSDictionary *)sortsDictionary;
{
    if (self = [super init])
    {
        self.label = sortsDictionary[@"label"];
        self.value = sortsDictionary[@"value"];
    }
    return self;
}
@end
