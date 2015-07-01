//
//  ViewController.m
//  TRDeals
//
//  Created by tarena on 15/6/25.
//  Copyright (c) 2015年 Tarena. All rights reserved.
//

#import "ViewController.h"
#import "DPAPI.h"
#import "TRDeal.h"
#import "TRMeataDataTool.h"
#import "TRCategory.h"
#import "TRCities.h"
#import "TRCityGroups.h"
#import "TRSorts.h"
@interface ViewController ()<DPRequestDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    DPAPI *api = [[DPAPI alloc]init];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"city"] = @"郑州";
    params[@"region"] = @"二七区";
    params[@"category"] = @"火锅";
    params[@"sort"] = @2;
    params[@"limit"] = @10;
    [api requestWithURL:@"v1/deal/find_deals" params:params delegate:self];
//    NSArray *categoryArray = [TRMeataDataTool categories];
   
    NSArray *cities = [TRMeataDataTool cities];
    for (TRCities *ci in cities) {
        NSLog(@"%@有%ld县",ci.name,ci.regions.count);
    }
}
- (void)request:(DPRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"发送失败,%@",error);
}
- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    
    NSArray *dealsArray = [self parseDealsWithArray:result];
    
    NSLog(@"发送成功%ld",[dealsArray count]);
    
    
    
    
}

- (NSArray *)parseDealsWithArray:(id)result
{
    NSArray *dealsArray = result[@"deals"];
    NSMutableArray *mutDeals = [NSMutableArray array];
    for (NSDictionary *dealDic in dealsArray) {
        TRDeal *deal = [TRDeal parseDealWithDictionary:dealDic];
        [mutDeals addObject:deal];
    }
    NSArray *deals = [mutDeals copy];
    return deals;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
