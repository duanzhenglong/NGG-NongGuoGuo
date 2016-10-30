//
//  NSCalendar+NGGCalendar.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/10/12.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NSCalendar+NGGCalendar.h"

@implementation NSCalendar (NGGCalendar)
+ (instancetype)calendar
{
    if ([NSCalendar respondsToSelector:@selector(calendarWithIdentifier:)]) {
        return [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    } else {
        return [NSCalendar currentCalendar];
    }
}
@end
