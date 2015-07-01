//
//  TRCategoryViewController.m
//  TRDeals
//
//  Created by tarena on 15/6/26.
//  Copyright (c) 2015年 Tarena. All rights reserved.
//

#import "TRCategoryViewController.h"
#import "TRCategoryView.h"
@interface TRCategoryViewController ()

@end

@implementation TRCategoryViewController

- (void)loadView
{
    self.view = [TRCategoryView view];
}
//- (instancetype)initWithCoder:(NSCoder *)aDecoder
//{
//    if (self=[super initWithCoder:aDecoder])
//    {
//        
//    }
//    return self;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.preferredContentSize = CGSizeMake(400, 480);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
