//
//  NGGDetailTableViewController.h
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/10/8.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NGGGoodsAttribute.h"
@interface NGGDetailTableViewController : UITableViewController

 /***物品模型属性***/
@property (strong, nonatomic) NGGGoodsAttribute* attribute;

@end
