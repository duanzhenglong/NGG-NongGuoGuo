//
//  NGGOrder.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/10/31.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGOrder.h"
#import "NSDate+NGGNSDate.h"
#import "NSCalendar+NGGCalendar.h"
@implementation NGGOrder
static NSDateFormatter *fmt_;
static NSCalendar *calendar_;
/**
 *  在第一次使用类时调用1次
 */
+ (void)initialize
{
    fmt_ = [[NSDateFormatter alloc] init];
    calendar_=[NSCalendar alloc];
    
}

-(NSString*)order_time{
    NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
    NSCalendar* calendar=[NSCalendar calendar];
    
    // 获得发帖日期
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *createdAtDate = [fmt dateFromString:_order_time];
    
    // 手机当前时间
    NSDate *nowDate = [NSDate date];
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *cmps = [calendar components:unit fromDate:createdAtDate toDate:nowDate options:0];
    NSInteger day=cmps.day;
    return [NSString stringWithFormat:@"剩余时间%ld天",day];
}


@end
