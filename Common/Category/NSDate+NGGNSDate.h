//
//  NSDate+NGGNSDate.h
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/10/12.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (NGGNSDate)
/**
 *  是否为今年
 */
- (BOOL)isThisYear;

/**
 *  是否为今天
 */
- (BOOL)isToday;

/**
 *  是否为昨天
 */
- (BOOL)isYesterday;
@end
