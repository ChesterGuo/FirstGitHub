//
//  TRMainNavController.m
//  TRDeals
//
//  Created by tarena on 15/6/25.
//  Copyright (c) 2015年 Tarena. All rights reserved.
//

#import "TRMainNavController.h"

@interface TRMainNavController ()

@end

@implementation TRMainNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setBackgroundImage:[UIImage imageNamed:@"bg_navigationBar_normal"] forBarMetrics:UIBarMetricsDefault];
}

@end
