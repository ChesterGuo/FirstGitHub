//
//  TRNavCitiesView.h
//  TRDeals
//
//  Created by tarena on 15/6/26.
//  Copyright (c) 2015年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRNavCitiesView : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *navButton;
+ (id)view;
- (void)addTarget:(id)target action:(SEL)action;
@end
