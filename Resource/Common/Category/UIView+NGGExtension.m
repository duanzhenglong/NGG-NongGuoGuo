//
//  UIView+NGGExtension.m
//  test2
//
//  Created by administrator on 16/9/23.
//  Copyright © 2016年 duanzhenglong. All rights reserved.
//

#import "UIView+NGGExtension.h"

@implementation UIView (NGGExtension)

- (CGSize)ngg_size
{
    return self.frame.size;
}

- (void)setNgg_size:(CGSize)ngg_size
{
    CGRect frame = self.frame;
    frame.size = ngg_size;
    self.frame = frame;
}

- (CGFloat)ngg_width
{
    return self.frame.size.width;
}

- (CGFloat)ngg_height
{
    return self.frame.size.height;
}

- (void)setNgg_width:(CGFloat)ngg_width
{
    CGRect frame = self.frame;
    frame.size.width = ngg_width;
    self.frame = frame;
}

- (void)setNgg_height:(CGFloat)ngg_height
{
    CGRect frame = self.frame;
    frame.size.height = ngg_height;
    self.frame = frame;
}

- (CGFloat)ngg_x
{
    return self.frame.origin.x;
}

- (void)setNgg_x:(CGFloat)ngg_x
{
    CGRect frame = self.frame;
    frame.origin.x = ngg_x;
    self.frame = frame;
}

- (CGFloat)ngg_y
{
    return self.frame.origin.y;
}

- (void)setNgg_y:(CGFloat)ngg_y
{
    CGRect frame = self.frame;
    frame.origin.y = ngg_y;
    self.frame = frame;
}

- (CGFloat)ngg_centerX
{
    return self.center.x;
}

- (void)setNgg_centerX:(CGFloat)ngg_centerX
{
    CGPoint center = self.center;
    center.x = ngg_centerX;
    self.center = center;
}

- (CGFloat)ngg_centerY
{
    return self.center.y;
}

- (void)setNgg_centerY:(CGFloat)ngg_centerY
{
    CGPoint center = self.center;
    center.y = ngg_centerY;
    self.center = center;
}

- (CGFloat)ngg_right
{
    //    return self.xmg_x + self.xmg_width;
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)ngg_bottom
{
    //    return self.xmg_y + self.xmg_height;
    return CGRectGetMaxY(self.frame);
}

- (void)setNgg_right:(CGFloat)ngg_right
{
    self.ngg_x = ngg_right - self.ngg_width;
}

- (void)setNgg_bottom:(CGFloat)ngg_bottom
{
    self.ngg_y = ngg_bottom - self.ngg_height;
}

+ (instancetype)viewFromXib
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

- (BOOL)intersectWithView:(UIView *)view
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGRect selfRect = [self convertRect:self.bounds toView:window];
    CGRect viewRect = [view convertRect:view.bounds toView:window];
    return CGRectIntersectsRect(selfRect, viewRect);
}

@end
