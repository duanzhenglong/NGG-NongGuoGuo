//
//  NGGdate.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/10/13.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGdate.h"
#import "NSCalendar+NGGCalendar.h"
@implementation NGGdate

+(NSString*)stratime:(NSString*)time andTimeinterval:(int)timeinterval{
    NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
    NSCalendar* calendar=[NSCalendar calendar];
    
    // 获得发帖日期
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *createdAtDate = [fmt dateFromString:time];
    
    // 手机当前时间
    NSDate *nowDate = [NSDate date];
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *cmps = [calendar components:unit fromDate:createdAtDate toDate:nowDate options:0];
    NSUInteger day=timeinterval -cmps.day-1;
    NSUInteger hour=24-cmps.hour;
    NSUInteger minute=59-cmps.minute;
    NSUInteger second=59-cmps.second;
    if (day>0.0) {
        return [NSString stringWithFormat:@"还剩下%ld天%ld小时%ld分%ld秒",day,hour,minute,second];
    }else{
        return [NSString stringWithFormat:@"还剩下%ld小时%ld分%ld秒",hour,minute,second];
    }
}

+(BOOL)Stratime:(NSString*)time andTimeinterval:(int)timeinterval{
    NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
    NSCalendar* calendar=[NSCalendar calendar];
    // 获得发帖日期
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *createdAtDate = [fmt dateFromString:time];
    // 手机当前时间
    NSDate *nowDate = [NSDate date];
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *cmps = [calendar components:unit fromDate:createdAtDate toDate:nowDate options:0];
    NSUInteger day=timeinterval -cmps.day-1;
    NSUInteger hour=24-cmps.hour;
    NSUInteger minute=59-cmps.minute;
    NSUInteger second=59-cmps.second;
    NSUInteger sum=day+hour+minute+second;
    if (sum==0) {
        return NO;
    }else{
        return YES;
    }
}

@end
