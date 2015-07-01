//
//  TRChangeCityViewController.m
//  TRDeals
//
//  Created by tarena on 15/6/27.
//  Copyright (c) 2015年 Tarena. All rights reserved.
//

#import "TRChangeCityViewController.h"
#import "TRMeataDataTool.h"
#import "TRCityGroups.h"
@interface TRChangeCityViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic) NSArray *cityGroups;
@end

@implementation TRChangeCityViewController
- (IBAction)cancelView:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (NSArray *)cityGroups
{
    if (!_cityGroups) {
        _cityGroups = [TRMeataDataTool cityGroups];
    }
    return _cityGroups;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.cityGroups.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    TRCityGroups *cityGroup =  self.cityGroups[section];
    return cityGroup.cities.count;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    TRCityGroups *cityGroup =  self.cityGroups[section];
    return cityGroup.title;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
     TRCityGroups *cityGroup =  self.cityGroups[indexPath.section];
    
    cell.textLabel.text = cityGroup.cities[indexPath.row];
    return cell;
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    // 将cityGroups数组中所有元素的title属性值取出来，放到一个新的数组
    NSArray *sectionTitle = [self.cityGroups valueForKeyPath:@"title"];
    return sectionTitle;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TRCityGroups *cityGroup =  self.cityGroups[indexPath.section];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TRCityDidChange" object:nil userInfo:@{@"TRSelectedCityName" : cityGroup.cities[indexPath.row]}];
    
    //弹回城市视图控制器
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
