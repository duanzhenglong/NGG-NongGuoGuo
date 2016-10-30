//
//  NGGdate.h
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/10/13.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NGGdate : NSObject
 /***计算与当前时间比较还剩多长时间***/
+(NSString*)stratime:(NSString*)time andTimeinterval:(int)timeinterval;
 /***计算在单位时间内还剩多长时间(返回BOOL值)***/
+(BOOL)Stratime:(NSString*)time andTimeinterval:(int)timeinterval;
@end
