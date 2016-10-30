//
//  NGGTabBar.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/10/17.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGTabBar.h"

@implementation NGGTabBar

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
       
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [self setHidden:NO];
}
-(void)viewWillDisappear:(BOOL)animated{
    [self setHidden:YES];
}

-(void)viewDidDisappear:(BOOL)animated{
     [self setHidden:YES];
}
@end
