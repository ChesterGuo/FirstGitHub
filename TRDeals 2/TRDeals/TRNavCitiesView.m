//
//  TRNavCitiesView.m
//  TRDeals
//
//  Created by tarena on 15/6/26.
//  Copyright (c) 2015年 Tarena. All rights reserved.
//

#import "TRNavCitiesView.h"

@implementation TRNavCitiesView
+ (id)view
{
    return [[[NSBundle mainBundle]loadNibNamed:@"TRNavCitiesView" owner:nil options:nil] lastObject];
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self == [super initWithCoder:aDecoder]) {
        self.autoresizingMask = UIViewAutoresizingNone;
    }
    return self;
}
- (void)addTarget:(id)target action:(SEL)action
{
    [self.navButton addTarget:target action:action forControlEvents:UIControlEventTouchDown];
}

@end
