//
//  TRCitiesViewController.m
//  TRDeals
//
//  Created by tarena on 15/6/26.
//  Copyright (c) 2015年 Tarena. All rights reserved.
//

#import "TRCitiesViewController.h"
#import "TRMeataDataTool.h"
#import "TRCities.h"
#import "TRRegion.h"
#import "TRChangeCityViewController.h"
@interface TRCitiesViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (weak, nonatomic) IBOutlet UITableView *secondTableView;
@property (strong,nonatomic) NSArray *regionArray;
@property (strong,nonatomic) NSArray *cities;
@end

@implementation TRCitiesViewController
- (NSArray *)cities
{
    if (!_cities)
    {
        _cities = [TRMeataDataTool cities];
    }
    return _cities;
}
- (NSArray *)regionArray
{
    if (!_regionArray) {
        _regionArray = [TRMeataDataTool regionsByCityName:@"成都"];
    }
    return _regionArray;
}
- (IBAction)changeCity:(id)sender
{
    TRChangeCityViewController *changeCityViewController = [[TRChangeCityViewController alloc]init];
    changeCityViewController.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:changeCityViewController animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cityDidChange:) name:@"TRCityDidChange" object:nil];
}
- (void)cityDidChange: (NSNotification *)notification {
    
    //获取通知中的城市名字参数
    NSString *selectedCityName = notification.userInfo[@"TRSelectedCityName"];
    
    // 1. 修改regions数据
    _regionArray = [TRMeataDataTool regionsByCityName:selectedCityName];
    //
    //    // 2.刷新表格数据
    [self.mainTableView reloadData];
    [self.secondTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.mainTableView)
    {
        return self.regionArray.count;
    }
    else
    {
        int selectedRow = (int)[self.mainTableView indexPathForSelectedRow].row;
        TRRegion *region = self.regionArray[selectedRow];
        
    
        return region.subregions.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.mainTableView)
    {
        UITableViewCell *leftCell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (!leftCell) {
            leftCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
            
        }
        UIImageView *bg = [UIImageView new];
        bg.image = [UIImage imageNamed:@"bg_dropdown_leftpart"];
        leftCell.backgroundView = bg;
        UIImageView *selectedBg = [UIImageView new];
        selectedBg.image = [UIImage imageNamed:@"bg_dropdown_left_selected"];
        leftCell.selectedBackgroundView = selectedBg;
       TRRegion *region = self.regionArray[indexPath.row];
        leftCell.textLabel.text = region.name;
        return leftCell;
    }
    else
    {
        UITableViewCell *rightCell = [tableView dequeueReusableCellWithIdentifier:@"BCell"];
        if (!rightCell) {
            rightCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"BCell"];
            
        }
        UIImageView *bg = [UIImageView new];
        bg.image = [UIImage imageNamed:@"bg_dropdown_leftpart"];
        rightCell.backgroundView = bg;
        UIImageView *selectedBg = [UIImageView new];
        selectedBg.image = [UIImage imageNamed:@"bg_dropdown_left_selected"];
        rightCell.selectedBackgroundView = selectedBg;
        int selectedRow = (int)[self.mainTableView indexPathForSelectedRow].row;
        TRRegion *region = self.regionArray[selectedRow];
        if (region.subregions) {
            rightCell.textLabel.text = region.subregions[indexPath.row];
        }
        
        return rightCell;
        
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.mainTableView) {
        [self.secondTableView reloadData];
        TRRegion *region = self.regionArray[indexPath.row];
        if (region.subregions.count == 0&&![region.name isEqualToString:@"全部"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"TRRegionDidChange" object:nil userInfo:@{@"TRSelectedRegion":region}];
        }

    }
    else
    {
        int selectedRowAtMain = (int)[self.mainTableView indexPathForSelectedRow].row;
        int selectedRowAtSec =(int)[self.secondTableView indexPathForSelectedRow].row;
        TRRegion *region= self.regionArray[selectedRowAtMain];
        NSString *subregionName = region.subregions[selectedRowAtSec];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TRRegionDidChange" object:nil userInfo:@{@"TRSelectedRegion":region,@"TRSelectedSubregionName":subregionName}];
    }
}


@end
