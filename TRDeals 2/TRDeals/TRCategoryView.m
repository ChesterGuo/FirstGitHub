//
//  TRCategoryView.m
//  TRDeals
//
//  Created by tarena on 15/6/26.
//  Copyright (c) 2015年 Tarena. All rights reserved.
//

#import "TRCategoryView.h"
#import "TRMeataDataTool.h"
#import "TRCategory.h"

@interface TRCategoryView()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (weak, nonatomic) IBOutlet UITableView *secondTableView;
@property (strong,nonatomic) NSArray *categoryArray;
@property (strong,nonatomic)TRCategory *selectedCategory;
@end
@implementation TRCategoryView
- (NSArray *)categoryArray
{
    if (!_categoryArray) {
        _categoryArray = [TRMeataDataTool categories];
    }
    return _categoryArray;
}
+ (id)view
{
    return [[[NSBundle mainBundle] loadNibNamed:@"TRCategoryView" owner:nil options:nil] lastObject];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.secondTableView)
    {
        int selectedRow = (int)[self.mainTableView indexPathForSelectedRow].row;
        TRCategory *category = self.categoryArray[selectedRow];
        NSArray *subCategoryArray = category.subcategories;
        return subCategoryArray.count;
    }
    else
    {
        return self.categoryArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.mainTableView)
    {
        static NSString *cellID = @"CategoryCell";
        
        UITableViewCell *leftCell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!leftCell)
        {
            leftCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        }
        //        cell.textLabel.text = @"left";
//        leftCell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:13.0];
        UIImageView *bg = [UIImageView new];
        bg.image = [UIImage imageNamed:@"bg_dropdown_leftpart"];
        leftCell.backgroundView = bg;
        UIImageView *selectedBg = [UIImageView new];
        selectedBg.image = [UIImage imageNamed:@"bg_dropdown_left_selected"];
        leftCell.selectedBackgroundView = selectedBg;
        
        TRCategory *category = self.categoryArray[indexPath.row];
        if (category.small_icon) {
            leftCell.imageView.image = [UIImage imageNamed:category.small_icon];
        }
        if (category.small_highlighted_icon) {
            leftCell.imageView.highlightedImage = [UIImage imageNamed:category.small_highlighted_icon];
        }
        

        self.selectedCategory = category;
        leftCell.textLabel.text = category.name;
        //        NSArray *sub = category.subcategories;
        //当有子类时显示箭头图标
        if (category.subcategories.count>0)
        {
            leftCell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_cell_rightArrow"]];
        }
        return leftCell;
    }
    else
    {
        static NSString *cellID = @"CategoryCell";
        
        UITableViewCell *rightCell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!rightCell)
        {
            rightCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        }
        UIImageView *bg = [UIImageView new];
        bg.image = [UIImage imageNamed:@"bg_dropdown_leftpart"];
        rightCell.backgroundView = bg;
        UIImageView *selectedBg = [UIImageView new];
        selectedBg.image = [UIImage imageNamed:@"bg_dropdown_left_selected"];
        rightCell.selectedBackgroundView = selectedBg;
        
        int selectedRow = (int)[self.mainTableView indexPathForSelectedRow].row;
        TRCategory *category = self.categoryArray[selectedRow];
        NSArray *subCategoryArray = category.subcategories;
        rightCell.textLabel.text = subCategoryArray[indexPath.row];
        return rightCell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.mainTableView) {
        [self.secondTableView reloadData];
         TRCategory *category = self.categoryArray[indexPath.row];
        
        if (category.subcategories.count == 0)
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"TRCategoryDidChange" object:nil userInfo:@{@"TRSelectedCategory":category}];
        }
            }
    else
    {
        int selectedRowAtMain = (int)[self.mainTableView indexPathForSelectedRow].row;
        int selectedRowAtSec =(int)[self.secondTableView indexPathForSelectedRow].row;
        TRCategory *category = self.categoryArray[selectedRowAtMain];
        NSString *subCategoryName =  category.subcategories[selectedRowAtSec];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TRCategoryDidChange" object:nil userInfo:@{@"TRSelectedCategory":category,@"TRSelectedSubCategoryName":subCategoryName}];
    }
}


@end
