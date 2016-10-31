//
//  NGGOrderTableViewCell.h
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/10/31.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NGGOrder.h"
@interface NGGOrderTableViewCell : UITableViewCell
+(instancetype)cellWithTable:(UITableView*)tableView;
@property (strong, nonatomic) NGGOrder* Order;
@end
