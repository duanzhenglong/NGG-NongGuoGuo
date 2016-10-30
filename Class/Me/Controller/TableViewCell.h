//
//  TableViewCell.h
//  NGG-NongGuoGuo
//
//  Created by mac on 16/10/9.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
//描述
@property(nonatomic,retain) UILabel *descLable;
//信息
@property(nonatomic,retain) UILabel *infoLable;



//初始化cell类
-(id)initWithReuseIdentifier:(NSString*)reuseIdentifier;




@end
