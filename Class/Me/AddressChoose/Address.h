//
//  Address.h
//  addressChoose
//
//  Created by mac on 16/10/10.
//  Copyright © 2016年 xll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChinaArea.h"
@protocol AddressDelegate<NSObject>
@optional

- (void)AddressDelegateChinaModel:(ChinaArea *)chinaModel;



@end
@interface Address : UIView
@property (nonatomic,assign) id<AddressDelegate>delegate;
+(Address *)customChinaPicker:(id)delegate superView:(UIView*)views;
@end
