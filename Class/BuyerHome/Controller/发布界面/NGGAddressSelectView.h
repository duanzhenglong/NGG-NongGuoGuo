//
//  NGGAddressSelectView.h
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/10/30.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NGGAddressSelectView : UIView
@property (strong, nonatomic) NSArray* addressArray;
@property (copy, nonatomic) void (^addressBlock)(NSInteger,NSString*);
@end
