//
//  AreaModel.h
//  addressChoose
//
//  Created by mac on 16/10/10.
//  Copyright © 2016年 xll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AreaModel : NSObject
//GRADE
@property (nonatomic,copy)NSString *GRADE;
//区域ID
@property (nonatomic,copy)NSString *ID;
//区域名
@property (nonatomic,copy)NSString *NAME;
//区域的上一级ID
@property (nonatomic,copy)NSString *PARENT_AREA_ID;
@end
