//
//  NGGRefreshHeader.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/11/2.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGRefreshHeader.h"

@implementation NGGRefreshHeader

/**
 *  初始化
 */
- (void)prepare
{
    [super prepare];
    self.automaticallyChangeAlpha = YES;
    self.lastUpdatedTimeLabel.textColor = NGGTheMeColor;
    self.stateLabel.textColor = NGGTheMeColor;
    [self setTitle:@"下拉加载数据" forState:MJRefreshStateIdle];
    [self setTitle:@"松开加载数据" forState:MJRefreshStatePulling];
    [self setTitle:@"正在加载数据..." forState:MJRefreshStateRefreshing];
}


@end
