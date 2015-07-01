//
//  TRSorts.h
//  TRDeals
//
//  Created by tarena on 15/6/25.
//  Copyright (c) 2015年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRSorts : NSObject
@property (nonatomic,strong) NSString *label;
@property (nonatomic,strong) NSNumber *value;
+(id)parseSortsWithSortsDictionary:(NSDictionary *)sortsDictionary;
@end
