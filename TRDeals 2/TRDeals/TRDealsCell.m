//
//  TRDealsCell.m
//  TRDeals
//
//  Created by tarena on 15/6/29.
//  Copyright (c) 2015年 Tarena. All rights reserved.
//

#import "TRDealsCell.h"
#import "UIImageView+AFNetworking.h"

@interface TRDealsCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *listPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *purchaseCountLabel;

@end
@implementation TRDealsCell
- (void)setDeal:(TRDeal *)deal
{
    _deal = deal;
    
    [self.imageView setImageWithURL:[NSURL URLWithString:deal.image_url] placeholderImage:[UIImage imageNamed:@"placeholder_deal"]];
    
    self.titleLabel.text = deal.title;
    self.descriptionLabel.text = deal.desc;
    self.currentPriceLabel.text = [NSString stringWithFormat:@"¥ %.1f", [deal.current_price floatValue]];;
    self.listPriceLabel.text = [NSString stringWithFormat:@"¥ %.1f", [deal.list_price floatValue]];
    if(deal.purchase_count!=0)
    {
        self.purchaseCountLabel.text = [NSString stringWithFormat:@"已售: %.0d", deal.purchase_count];
    }
    else
    {
        self.purchaseCountLabel.text = @"销售量:0";
    }
    
}

- (void)awakeFromNib {
    // Initialization code
}

@end
