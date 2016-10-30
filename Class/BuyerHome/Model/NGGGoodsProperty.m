//
//  NGGGoodsProperty.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/10/13.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGGoodsProperty.h"
#import "NSDate+NGGNSDate.h"
#import "NSCalendar+NGGCalendar.h"
@implementation NGGGoodsProperty

-(CGFloat)desHegiht{
     /***如果cell的高度已经计算过，就直接返回***/
    if (_desHegiht) return _desHegiht;
     /***文字***/
    CGFloat textMaxW=SCREEN_WIDTH-24;
    CGSize textMaxSize=CGSizeMake(textMaxW, MAXFLOAT);
    CGSize textSize=[self.supplylist_desc boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
    _desHegiht=textSize.height;
    return _desHegiht;
}


static NSDateFormatter *fmt_;
static NSCalendar *calendar_;
/**
 *  在第一次使用类时调用1次
 */
+ (void)initialize
{
    fmt_ = [[NSDateFormatter alloc] init];
    calendar_=[NSCalendar calendar];
    
}

-(NSString*)supplylist_time{
    // 获得发帖日期
    fmt_.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *createdAtDate = [fmt_ dateFromString:_supplylist_time];
    
    if (createdAtDate.isToday) { // 今天
        // 手机当前时间
        NSDate *nowDate = [NSDate date];
        NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        NSDateComponents *cmps = [calendar_ components:unit fromDate:createdAtDate toDate:nowDate options:0];
        
        if (cmps.hour >= 1) { // 时间间隔 >= 1小时
            return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
        } else if (cmps.minute >= 1) { // 1小时 > 时间间隔 >= 1分钟
            return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
        } else { // 1分钟 > 分钟
            return @"刚刚";
        }
    } else if (createdAtDate.isYesterday) { // 昨天
        fmt_.dateFormat = @"昨天 HH:mm:ss";
        return [fmt_ stringFromDate:createdAtDate];
    } else { // 其他
        fmt_.dateFormat = @"MM-dd HH:mm:ss";
        return [fmt_ stringFromDate:createdAtDate];
    }
}



@end
