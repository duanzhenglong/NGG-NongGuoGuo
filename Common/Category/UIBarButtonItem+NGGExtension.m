//
//  UIBarButtonItem+NGGExtension.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/9/30.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "UIBarButtonItem+NGGExtension.h"

@implementation UIBarButtonItem (NGGExtension)

/**
 *  扩展NavigationController 上面的按钮
 *
 *  @param image     正常显示的图片
 *  @param highImage 高亮时显示的图片
 *  @param target    目标者
 *  @param action    触发的方法
 *
 *  @return UIBarButtonItem
 */
+(UIBarButtonItem*)itemWithIamge:(NSString*)image highImage:(NSString*)highImage target:(id)target action:(SEL)action{
    
    UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    return [[UIBarButtonItem alloc]initWithCustomView:button];
    
}
@end
