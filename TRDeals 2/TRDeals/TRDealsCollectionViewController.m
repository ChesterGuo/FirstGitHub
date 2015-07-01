//
//  TRDealsCollectionViewController.m
//  TRDeals
//
//  Created by tarena on 15/6/25.
//  Copyright (c) 2015年 Tarena. All rights reserved.
//

#import "TRDealsCollectionViewController.h"
#import "TRNavLeftView.h"
#import "TRCategoryViewController.h"
#import "TRMeataDataTool.h"
#import "TRCategory.h"
#import "TRCitiesViewController.h"
#import "TRSortsViewController.h"
#import "TRDealsCell.h"
#import "DPAPI.h"
#import "TRSorts.h"
#import "TRRegion.h"
#import "UIScrollView+BottomRefreshControl.h"
#import "TRDetailViewController.h"
@import CoreLocation;



@interface TRDealsCollectionViewController ()<DPRequestDelegate,CLLocationManagerDelegate>
@property (nonatomic,strong)UIPopoverController *categoryPopController;
@property (nonatomic,strong)TRNavLeftView *categoryView;
@property (nonatomic,strong)TRNavLeftView *regionView;
@property (nonatomic,strong)TRNavLeftView *sortView;
@property (nonatomic,strong)UIPopoverController *citiesPopController;
@property (nonatomic,strong)UIPopoverController *sortsPopController;
@property (nonatomic,strong) NSMutableArray *dealsArray;
@property (nonatomic,strong) DPAPI *api;
@property (nonatomic,strong) DPRequest *request;
@property (nonatomic,strong) NSNumber *selectedSortValue;
@property (nonatomic,strong) NSString *selectedCategoryName;
@property (nonatomic,strong) NSString *selectedCityName;
@property (nonatomic,strong) NSString *selectedSubregionName;
@property (nonatomic,strong) NSString *selectedRegionName;
@property (nonatomic,strong) NSString *selectedSubCategoryName;
@property (nonatomic,strong) CLLocationManager *locationManager;
@property (nonatomic,assign) int currentPage;
@end

@implementation TRDealsCollectionViewController
- (NSMutableArray *)dealsArray
{
    if (!_dealsArray) {
        _dealsArray = [NSMutableArray array];
    }
    return _dealsArray;
}
- (CLLocationManager *)locationManager
{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc]init];
    }
    return _locationManager;
}
static NSString * const reuseIdentifier = @"Cell";

- (UIPopoverController *)sortsPopController
{
    if (_sortsPopController == nil)
    {
        TRSortsViewController *sortsViewController = [TRSortsViewController new];
        _sortsPopController = [[UIPopoverController alloc]initWithContentViewController:sortsViewController];
    }
    return _sortsPopController;
}
- (DPAPI *)api
{
    if (!_api) {
        self.api = [[DPAPI alloc] init];
    }
    return _api;
}
- (UIPopoverController *)citiesPopController
{
    if (_citiesPopController == nil) {
        TRCitiesViewController *citiesViewController = [[TRCitiesViewController alloc]init];
        _citiesPopController = [[UIPopoverController alloc]initWithContentViewController:citiesViewController];
    }
    return _citiesPopController;
    
}
- (UIPopoverController *)categoryPopController
{
    
    if (_categoryPopController == nil) {
        TRCategoryViewController *categoryViewController = [[TRCategoryViewController alloc] init];
        
        
        _categoryPopController = [[UIPopoverController alloc]initWithContentViewController:categoryViewController];
    }
    return _categoryPopController;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self setUpRightItems];
    [self setUpLeftItems];
    [self setUpLIstenEvent];
    [self setupFreshControl];
    
    // Do any additional setup after loading the view.
}
#pragma mark ---创建右边按钮

- (void)setUpRightItems
{
    UIButton *mapButton = [[UIButton alloc]init];
    [mapButton setImage:[UIImage imageNamed:@"icon_map"] forState:UIControlStateNormal];
    [mapButton setImage:[UIImage imageNamed:@"icon_map_highlighted"] forState:UIControlStateHighlighted];
    [mapButton addTarget:self action:@selector(clickMap) forControlEvents:UIControlEventTouchUpInside];
    [mapButton setFrame:CGRectMake(0, 0, 50, 40)];
    //    mapButton.backgroundColor = [UIColor lightGrayColor];
    UIBarButtonItem *mapItem = [[UIBarButtonItem alloc]initWithCustomView:mapButton];
    
    UIButton *searchButton = [[UIButton alloc]init];
    [searchButton setImage:[UIImage imageNamed:@"icon_search"] forState:UIControlStateNormal];
    [searchButton setImage:[UIImage imageNamed:@"icon_search_highlighted"] forState:UIControlStateHighlighted];
    [searchButton addTarget:self action:@selector(clickSearch) forControlEvents:UIControlEventTouchUpInside];
    [searchButton setFrame:CGRectMake(0, 0, 50, 40)];
    //    searchButton.backgroundColor = [UIColor lightGrayColor];
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc]initWithCustomView:searchButton];
    
    
    self.navigationItem.rightBarButtonItems = @[mapItem,searchItem];
    
}
#pragma mark --- 右边按钮响应事件
- (void)clickMap
{
#warning TODO_Map
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"定位服务没有开启,请设置打开");
        return;
    }
    //如果用户还没有决定是否使用定位服务
    if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined){
        //向用户请求授权
        [self.locationManager requestWhenInUseAuthorization];
    }
    //设置委托对象,当定位服务发生事件时通知委托
    self.locationManager.delegate = self;
    
    //定位的精度:定位的误差在多少M的范围之内
    self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    
    //定位的频率:位置超出多少米定位一次
    self.locationManager.distanceFilter = 10.0;
    
    //开始定位
    [self.locationManager startUpdatingLocation];
}
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:locations.lastObject completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark = placemarks.lastObject;
        NSDictionary *address =placemark.addressDictionary;
        NSLog(@"%@",address);
    }];
}
- (void)clickSearch
{
#warning TODO_Search
}

#pragma mark ---配置左侧按钮
- (void)setUpLeftItems
{
    
    UIBarButtonItem *logoItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_meituan_logo"] style:UIBarButtonItemStyleDone target:nil action:nil];
    logoItem.enabled = NO;
    self.categoryView = [TRNavLeftView view];
    
    [self.categoryView addTarget:self action:@selector(clickCategoryView)];
    
    UIBarButtonItem *categoryItem = [[UIBarButtonItem alloc]initWithCustomView:self.categoryView];
    
    self.regionView = [TRNavLeftView view];
    self.regionView.titleLabel.text = @"全部区域";
    self.regionView.subTitleLabel.text = @"热门城市";
    [self.regionView.navButton setImage:[UIImage imageNamed:@"icon_map"] forState:UIControlStateNormal];
    [self.regionView.navButton setImage:[UIImage imageNamed:@"icon_map_highlighted"] forState:UIControlStateHighlighted];
    [self.regionView addTarget:self action:@selector(clickRegionView)];
    UIBarButtonItem *regionItem = [[UIBarButtonItem alloc]initWithCustomView:self.regionView];
    self.sortView = [TRNavLeftView view];
    self.sortView.titleLabel.text = @"排序方式";
    self.sortView.subTitleLabel.text = @"默认排序";
    [self.sortView.navButton setImage:[UIImage imageNamed:@"icon_sort"] forState:UIControlStateNormal];
    [self.sortView.navButton setImage:[UIImage imageNamed:@"icon_sort_highlighted"] forState:UIControlStateHighlighted];
    [self.sortView addTarget:self action:@selector(clickCityView)];
    UIBarButtonItem *cityItem = [[UIBarButtonItem alloc]initWithCustomView:self.sortView];
    self.categoryView.backgroundColor = [UIColor clearColor];
    self.regionView.backgroundColor = [UIColor clearColor];
    self.sortView.backgroundColor = [UIColor clearColor];
    self.navigationItem.leftBarButtonItems = @[logoItem,categoryItem,regionItem,cityItem];
}
- (void)clickRegionView
{
    [self.citiesPopController presentPopoverFromRect:self.regionView.bounds inView:self.regionView permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
}


- (void)clickCityView
{
    [self.sortsPopController presentPopoverFromRect:self.sortView.bounds inView:self.sortView permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}
- (void)clickCategoryView
{
    [self.categoryPopController presentPopoverFromRect:self.categoryView.bounds inView:self.categoryView permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
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
#pragma mark - 监听事件

- (void)setUpLIstenEvent
{
    //监听分类
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(CategoryDidChange:) name:@"TRCategoryDidChange" object:nil];
    //监听城市
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(CityDidChange:) name:@"TRCityDidChange" object:nil];
    //监听区域
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RegionDidChange:) name:@"TRRegionDidChange" object:nil];
    //监听排序
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(SortDidChange:) name:@"TRSortDidChange" object:nil];
}
#pragma mark - 监听事件响应方法

- (void)RegionDidChange:(NSNotification *)notification {
    TRRegion *selectedRegion = notification.userInfo[@"TRSelectedRegion"];
    
    self.selectedRegionName = selectedRegion.name;
    self.regionView.titleLabel.text = selectedRegion.name;
    self.selectedSubregionName = notification.userInfo[@"TRSelectedSubregionName"];
    [self.citiesPopController dismissPopoverAnimated:YES];
    [self reloadNewDeals];
    
}
- (void)CityDidChange: (NSNotification *)notification {
    
    self.selectedCityName = notification.userInfo[@"TRSelectedCityName"];
    
    
    [self reloadNewDeals];
}
- (void)CategoryDidChange:(NSNotification *)notification
{
    TRCategory *selectedCategory = notification.userInfo[@"TRSelectedCategory"];
    self.selectedCategoryName = selectedCategory.name;
    self.selectedSubCategoryName = notification.userInfo[@"TRSelectedSubCategoryName"];
    self.categoryView.titleLabel.text = self.selectedCategoryName;
    self.categoryView.subTitleLabel.text = self.selectedSubCategoryName;
    [self.categoryPopController dismissPopoverAnimated:YES];
    [self reloadNewDeals];
}
- (void)SortDidChange:(NSNotification *)notification
{
    TRSorts *selectedSort = notification.userInfo[@"TRSelectedSort"];
    
    self.selectedSortValue = selectedSort.value;
    self.sortView.subTitleLabel.text = selectedSort.label;
    [self.sortsPopController dismissPopoverAnimated:YES];
    [self reloadNewDeals];
}


#pragma mark -  DPRequestDelegate 点评协议方法

- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    //    NSLog(@"发送成功%@", result);
    
    //解析result成模型对象，并添加到TRDealsManager中的数组中
    if (self.currentPage == 1)
    {
        [self.dealsArray removeAllObjects];
    }
        [self.dealsArray addObjectsFromArray:[self parseDealWithArray:result]];
    ////////3. 刷新新的数据
    [self.collectionView reloadData];
    [self.collectionView.bottomRefreshControl endRefreshing];
}
- (void)request:(DPRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"请求失败:%@",error);
    [self.collectionView.bottomRefreshControl endRefreshing];

}
#pragma mark -- 解析返回的result

- (NSArray *)parseDealWithArray:(id)result {
    
    NSMutableArray *dealsMutalArray = [NSMutableArray new];
    
    NSArray *dealsArray = result[@"deals"];
    //解析dealsArray中的数据(NSDictionary)； NSDictionary(对象) ===> TRDeal(模型)
    for (NSDictionary *dealDic in dealsArray) {
        TRDeal *deal = [TRDeal parseDealWithDictionary:dealDic];
        
        //将解析后的TRWeather模型对象添加到TRDealsManager中的数组中; TRWeather(对象)添加到NSArray数组中
        [dealsMutalArray addObject:deal];
    }
    
    return [dealsMutalArray copy];
}
#pragma mark <UICollectionViewDataSource>

//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//#warning Incomplete method implementation -- Return the number of sections
//    return 0;
//}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dealsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TRDealsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"deal" forIndexPath:indexPath];
    if (!cell) {
        cell = [[TRDealsCell alloc]init];
    }
    cell.deal = self.dealsArray[indexPath.row];
    // Configure the cell
    
    return cell;
}
#pragma mark --- 下拉加载
- (void)setupFreshControl
{
    UIRefreshControl *refreshControl = [UIRefreshControl new];
    refreshControl.triggerVerticalOffset = 100;
    refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"拉你麻痹"];
    [refreshControl addTarget:self action:@selector(loadMoreDeals) forControlEvents:UIControlEventValueChanged];
    self.collectionView.bottomRefreshControl = refreshControl;
    
    
}

- (void)loadMoreDeals
{
    self.currentPage++;
    [self sendDealsRequest];
}
- (void)reloadNewDeals
{
    self.currentPage = 1;
    [self sendDealsRequest];
    
}
- (void)sendDealsRequest
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (self.selectedCityName) {
        dic[@"city"] = self.selectedCityName;
        self.regionView.subTitleLabel.text = self.selectedCityName;
    }
    else
    {
        dic[@"city"] = @"成都";
        self.regionView.subTitleLabel.text = @"成都";
    }
    if (self.selectedCategoryName&&![self.selectedCategoryName isEqualToString:@"全部分类"])
    {
        if (self.selectedSubCategoryName &&![self.selectedSubCategoryName isEqualToString:@"全部"]) {
            dic[@"category"] = self.selectedSubCategoryName;
        }
        else
        {
            dic[@"category"] = self.selectedCategoryName;
        }
        
    }
    if (self.selectedSortValue) {
        dic[@"sort"] = self.selectedSortValue;
    }
    if (self.selectedRegionName&&![self.selectedRegionName isEqualToString:@"全部"])
    {
        if (self.selectedSubregionName&&![self.selectedSubregionName isEqualToString:@"全部"])
        {
            dic[@"region"] =  self.selectedSubregionName;
            
        }
        else
        {
            dic[@"region"] =  self.selectedRegionName;
            
        }
    }
    
    NSLog(@"request:%@",dic.allValues);
    dic[@"page"] = @(self.currentPage);
    [self.api requestWithURL:@"v1/deal/find_deals" params:dic delegate:self];
}

#pragma mark --点击进入内容界面
#pragma mark <UICollectionViewDelegate>
 - (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TRDetailViewController *detailViewController = [[TRDetailViewController alloc]init];
    detailViewController.deal = self.dealsArray[indexPath.row];
    [self presentViewController:detailViewController animated:YES completion:nil];
}
/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
 }
 */

/*
 // Uncomment this method to specify if the specified item should be selected
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
 }
 
 - (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
 }
 
 - (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
 }
 */

@end
