//
//  ProvinceModel.h
//  addressChoose
//
//  Created by mac on 16/10/10.
//  Copyright © 2016年 xll. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface ProvinceModel : NSObject
// GRADE
@property (nonatomic,copy)NSString *GRADE;
//省份ID
@property (nonatomic,copy)NSString *ID;
//省份名
@property (nonatomic,copy)NSString *NAME;
//省份的上一级ID
@property (nonatomic,copy)NSString *PARENT_AREA_ID;
@end
