//
//  TRCityGroups.h
//  TRDeals
//
//  Created by tarena on 15/6/25.
//  Copyright (c) 2015年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRCityGroups : NSObject
@property (nonatomic,strong) NSArray *cities;
@property (nonatomic,strong) NSString *title;
+ (id)parseCityGroupsWithcityGroupsDictionary:(NSDictionary *)cityGroupsDic;
@end
