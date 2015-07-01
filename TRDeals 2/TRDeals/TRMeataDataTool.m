//
//  TRMeataDataTool.m
//  TRDeals
//
//  Created by tarena on 15/6/25.
//  Copyright (c) 2015年 Tarena. All rights reserved.
//

#import "TRMeataDataTool.h"
#import "TRCategory.h"
#import "TRCities.h"
#import "TRCityGroups.h"
#import "TRSorts.h"
#import "TRRegion.h"
@implementation TRMeataDataTool
#pragma categorise
static NSArray *_categories = nil;
+ (NSArray *)categories
{
    if (_categories == nil)
    {
        _categories = [[self alloc]getAndParseCategoryFile:@"categories.plist"];
    }
    return _categories;
}

- (NSArray *)getAndParseCategoryFile:(NSString *)plistName
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:plistName ofType:nil];
    NSArray *dataArray = [NSArray arrayWithContentsOfFile:plistPath];
    NSMutableArray *mutArray = [NSMutableArray array];
    for (NSDictionary *dic in dataArray) {
        TRCategory *category = [TRCategory parseCategoryData:dic];
        [mutArray addObject:category];
    }
    NSArray *categoties = [mutArray copy];
    
    return categoties;
}
#pragma cities
static NSArray *_cities = nil;
+ (NSArray *)cities
{
    if (_cities == nil)
    {
        _cities = [[self alloc]getAndParseCitiesFile:@"cities.plist"];
    }
    return _cities;
}
- (NSArray *)getAndParseCitiesFile:(NSString *)citiesFilename
{
    NSString *filename = [[NSBundle mainBundle] pathForResource:citiesFilename ofType:nil];
     NSArray *dataArray = [NSArray arrayWithContentsOfFile:filename];
    NSMutableArray *mutArray = [NSMutableArray array];
    for (NSDictionary *dic in dataArray)
    {
        TRCities *cities = [TRCities parseCitiesWithData:dic];
        [mutArray addObject:cities];
    }
    NSArray *cities = [mutArray copy];
    return cities;
}
#pragma cityGroups
static NSArray *_cityGroups = nil;
+ (NSArray *)cityGroups
{
    if (_cityGroups == nil)
    {
        _cityGroups = [[self alloc]getAndParseCityGroupsFile:@"cityGroups.plist"];
    }
    return _cityGroups;
}
- (NSArray *)getAndParseCityGroupsFile:(NSString *)cityGroupsFilename
{
    NSString *filename = [[NSBundle mainBundle] pathForResource:cityGroupsFilename ofType:nil];
    NSArray *dataArray = [NSArray arrayWithContentsOfFile:filename];
    NSMutableArray *mutArray = [NSMutableArray array];
    for (NSDictionary *dic in dataArray)
    {
        TRCityGroups *cityGroups = [TRCityGroups parseCityGroupsWithcityGroupsDictionary:dic];
        [mutArray addObject:cityGroups];
    }
    NSArray *cityGroups = [mutArray copy];
    return cityGroups;
}
#pragma sorts
static NSArray *_sorts = nil;
+ (NSArray *)sorts
{
    if (_sorts == nil)
    {
        _sorts = [[self alloc]getAndParseSortsFile:@"sorts.plist"];
    }
    return _sorts;
}
- (NSArray *)getAndParseSortsFile:(NSString *)sortsFilename
{
    NSString *filename = [[NSBundle mainBundle] pathForResource:sortsFilename ofType:nil];
    NSArray *dataArray = [NSArray arrayWithContentsOfFile:filename];
    NSMutableArray *mutArray = [NSMutableArray array];
    for (NSDictionary *dic in dataArray)
    {
        TRSorts *sorts = [TRSorts parseSortsWithSortsDictionary:dic];
        [mutArray addObject:sorts];
    }
    NSArray *sorts = [mutArray copy];
    return sorts;
}
static NSArray *_regions = nil;
+ (NSArray *)regionsByCityName:(NSString *)cityName
{
    if (cityName.length == 0) {
        return nil;
    }
    TRCities *findCity = nil;
    for (TRCities *city in [TRMeataDataTool cities])
    {
        if ([cityName isEqualToString:city.name])
        {
            findCity = city;
        }
    }
    return findCity.regions;
}


@end
