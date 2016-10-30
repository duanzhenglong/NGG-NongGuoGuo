//
//  NGGGoodsAttribute.h
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/9/30.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NGGGoodsAttribute : NSObject

 /***需求表id***/
@property int needlist_id;
 /***物品名称***/
@property (strong, nonatomic) NSString* needlist_goodsname;
 /***采购数量***/
@property (strong, nonatomic) NSString* needlist_number;
 /***发布采购时间***/
@property (strong, nonatomic) NSString* needlist_time;
 /***发布信息时间***/
@property (strong, nonatomic) NSString* needlist_surplustime;
 /***联系人***/
@property (strong, nonatomic) NSString* needlist_linkman;
 /***联系人电话***/
@property (strong, nonatomic) NSString* needlist_linkmanphone;
 /***详情描述***/
@property (strong, nonatomic) NSString* needlist_desc;
 /***采购时长***/
@property  (strong, nonatomic) NSString* needlist_timeinterval;
 /***发布买家的id***/
@property int user_id;
 /***地址id***/
@property int address_id;
 /***物品类别id***/
@property int goodsclassify_id;


/***额外属性***/

/**
 *  品种
 */
@property(strong, nonatomic) NSString *goodsclassify_name;
/**
 *  地址
 */
@property(strong, nonatomic) NSString *address_name;
@end
