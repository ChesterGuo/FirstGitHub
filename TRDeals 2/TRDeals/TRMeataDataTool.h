//
//  TRMeataDataTool.h
//  TRDeals
//
//  Created by tarena on 15/6/25.
//  Copyright (c) 2015年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TRCities;
@class TRRegion;
@interface TRMeataDataTool : NSObject
+ (NSArray *)categories;
+ (NSArray *)sorts;
+ (NSArray *)cityGroups;
+ (NSArray *)cities;
+ (NSArray *)regionsByCityName:(NSString *)cityName;

@end
