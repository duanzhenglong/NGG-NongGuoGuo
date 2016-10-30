//
//  NGGGoodsProperty.h
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/10/13.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NGGGoodsProperty : NSObject

 /***供应表id***/
@property int  supplylist_id;
 /*** 产品供应时间***/
@property(nonatomic,strong) NSString *supplylist_time;
 /***产品名称***/
@property (strong, nonatomic) NSString *supplylist_goodsname;
 /***价格***/
@property (strong, nonatomic) NSString* supplylist_price;
 /***产品最小供应数量***/
@property(nonatomic,strong) NSString *supplylist_minnumber;
 /***产品描述***/
@property (strong, nonatomic) NSString *supplylist_desc;
 /***产品图片***/
@property (strong, nonatomic) NSString *supplylist_image;
 /***货品分类***/
@property int  goodsclassify_id;
 /***用户id***/
@property int user_id;
 /***地址id***/
@property int  address_id;
 /***货品id***/
@property int  goods_id;


/***额外属性***/
/**
 *  卖家昵称
 */
@property (strong, nonatomic) NSString *user_nick;
/**
 *  地址
 */
@property (strong, nonatomic) NSString *address_name;
 /***详情内容文字高度***/
@property (nonatomic,assign) CGFloat desHegiht;

@end
