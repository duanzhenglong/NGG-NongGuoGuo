//
//  NGGOrder.h
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/10/31.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NGGOrder : NSObject

 /***订单id***/
@property int order_id;
 /***订单号***/
@property (strong, nonatomic) NSString* order_num;
 /***商品名称***/
@property (strong, nonatomic) NSString* order_goodsname;
 /***商品价格***/
@property (strong, nonatomic) NSString* order_goodsprice;
 /***商品图片***/
@property (strong, nonatomic) NSString* order_goodsimage;
 /***商品描述***/
@property (strong, nonatomic) NSString* order_goodsdesc;
 /***联系人***/
@property (strong, nonatomic) NSString* order_linkman;
 /***地址***/
@property (strong, nonatomic) NSString* order_address;
 /***购买数量***/
@property (strong, nonatomic) NSString* order_goodsnum;
 /***总价格***/
@property (strong, nonatomic) NSString* order_allprice;
 /***补充说明***/
@property (strong, nonatomic) NSString* order_complement;
 /***时间***/
@property (strong, nonatomic) NSString* order_time;
 /*** 买家 id***/
@property int order_buyid;
 /***卖家id***/
@property int order_sellerid;


 /***额外属性***/


@end
