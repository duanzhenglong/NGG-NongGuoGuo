//
//  NGGSellerHomeHeaderView.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/10/11.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGSellerHomeHeaderView.h"
#import "XRCarouselView.h"//轮播头文件
@interface NGGSellerHomeHeaderView()

@property (strong, nonatomic) XRCarouselView* carouselView;
@end

@implementation NGGSellerHomeHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
         /*创建控件*/
        [self CreatCustomizeControls];
        [_carouselView startTimer];
    }
    return self;
}

#pragma mark-创建控件
-(void)CreatCustomizeControls{
    NSArray *arr = @[
                     [UIImage imageNamed:@"dazhaxie"],//本地图片，传image，不能传名称
                     [UIImage imageNamed:@"shucai"],
                     [UIImage imageNamed:@"shuidao"],
                     [UIImage imageNamed:@"shuiguo"],
                     [UIImage imageNamed:@"zoudiji"],
                     ];
    self.carouselView =[[XRCarouselView alloc]initWithFrame:CGRectMake(0, 0, self.ngg_width, self.ngg_height)];
    //设置图片数组及图片描述文字
    _carouselView.imageArray = arr;
    //设置每张图片的停留时间，默认值为5s，最少为2s
    _carouselView.time = 3;
    
    [self addSubview:_carouselView];
}
@end
