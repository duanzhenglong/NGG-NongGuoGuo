//
//  NGGRefreshFooter.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/11/2.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGRefreshFooter.h"

@implementation NGGRefreshFooter

- (void)prepare
{
    [super prepare];
    
    self.stateLabel.textColor = NGGTheMeColor;
    [self addSubview:[UIButton buttonWithType:UIButtonTypeContactAdd]];
    [self setTitle:@"没有数据啦,不要再上拉了" forState:MJRefreshStateNoMoreData];
    


}

@end
