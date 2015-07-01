//
//  TRSortsViewController.m
//  TRDeals
//
//  Created by tarena on 15/6/26.
//  Copyright (c) 2015年 Tarena. All rights reserved.
//

#import "TRSortsViewController.h"
#import "TRMeataDataTool.h"
#import "TRSorts.h"
@interface TRSortsViewController ()

@end

@implementation TRSortsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *sortsArray = [TRMeataDataTool sorts];
    NSUInteger count = sortsArray.count;
    CGFloat buttonHeight = 30;
    CGFloat buttonWidth = 100;
    CGFloat buttonX = 15;
    CGFloat buttonY = 15;
    CGFloat buttonMargin = 15;
    CGFloat height = 0;
    for (int i = 0; i<count; i++)
    {
        TRSorts *sort = sortsArray[i];
        UIButton *button = [[UIButton alloc]init];
        [button setTitle:sort.label forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        button.frame = CGRectMake(buttonX, (buttonY+i*(buttonHeight+buttonMargin)), buttonWidth, buttonHeight);
        button.tag = (NSInteger)i;
//        button.backgroundColor = [UIColor lightGrayColor];
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        height = CGRectGetMaxY(button.frame);
    }
    self.preferredContentSize = CGSizeMake((buttonWidth+2*buttonX), height+buttonMargin);
    
    
}
- (void)clickButton:(UIButton *)sender
{
    NSArray *sortsArray = [TRMeataDataTool sorts];
    TRSorts *sort = sortsArray[sender.tag];
//    NSLog(@"%@",sort.label);
    NSDictionary *dic = @{@"TRSelectedSort":sort};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TRSortDidChange" object:nil userInfo:dic];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
