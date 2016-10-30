//
//  NGGEditTextField.m
//  test2
//
//  Created by administrator on 16/9/23.
//  Copyright © 2016年 duanzhenglong. All rights reserved.
//

#import "NGGEditTextField.h"
#import "UITextField+NGGExtension.h"


@interface NGGEditTextField ()

@end
@implementation NGGEditTextField

- (void)awakeFromNib
{
    // 设置光标颜色
    self.tintColor = [UIColor whiteColor];
    // 设置默认的占位文字颜色
    self.placeholderColor = [UIColor grayColor];

}
/**
 *  调用时刻 : 成为第一响应者(开始编辑\弹出键盘\获得焦点)
 */
- (BOOL)becomeFirstResponder
{
    self.placeholderColor = [UIColor darkGrayColor];
    return [super becomeFirstResponder];
}

/**
 *  调用时刻 : 不做第一响应者(结束编辑\退出键盘\失去焦点)
 */
- (BOOL)resignFirstResponder
{
    self.placeholderColor = [UIColor grayColor];
    return [super resignFirstResponder];
}

@end
