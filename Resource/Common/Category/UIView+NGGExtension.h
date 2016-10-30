//
//  UIView+NGGExtension.h
//  test2
//
//  Created by administrator on 16/9/23.
//  Copyright © 2016年 duanzhenglong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (NGGExtension)
/**
 *继承uiview改变
 */
@property (nonatomic, assign) CGSize ngg_size;
@property (nonatomic, assign) CGFloat ngg_width;
@property (nonatomic, assign) CGFloat ngg_height;
@property (nonatomic, assign) CGFloat ngg_x;
@property (nonatomic, assign) CGFloat ngg_y;
@property (nonatomic, assign) CGFloat ngg_centerX;
@property (nonatomic, assign) CGFloat ngg_centerY;

@property (nonatomic, assign) CGFloat ngg_right;
@property (nonatomic, assign) CGFloat ngg_bottom;

+ (instancetype)viewFromXib;

- (BOOL)intersectWithView:(UIView *)view;
@end
