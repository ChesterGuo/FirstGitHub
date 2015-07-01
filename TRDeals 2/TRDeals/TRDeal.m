//
//  TRDeal.m
//  TRDeals
//
//  Created by tarena on 15/6/25.
//  Copyright (c) 2015年 Tarena. All rights reserved.
//

#import "TRDeal.h"

@implementation TRDeal
+ (id)parseDealWithDictionary:(NSDictionary *)dealDic {
    
    return [[self alloc] initWithDealDic:dealDic];
    
}

//解析deals数组
- (id)initWithDealDic:(NSDictionary *)dealDic {
    
    if (self = [super init]) {
        //解析相关参数
        
        //订单id
        self.deal_id = dealDic[@"deal_id"];
        self.title = dealDic[@"title"];
        //描述
        self.desc = dealDic[@"description"];
        //原价
        self.list_price = dealDic[@"list_price"];
        //优惠价格
        self.current_price = dealDic[@"current_price"];
        //发布时间
        self.publish_date = dealDic[@"publish_date"];
        //购买数量
        self.purchase_count = [dealDic[@"purchase_count"] intValue];
        //订单大图片
        self.image_url = dealDic[@"image_url"];
        //订单小图片
        self.s_image_url = dealDic[@"s_image_url"];
        self.deadline = dealDic[@"purchase_deadline"];
        self.deal_h5_url = dealDic[@"deal_h5_url"];
    }
    
    return self;
    
}


@end
