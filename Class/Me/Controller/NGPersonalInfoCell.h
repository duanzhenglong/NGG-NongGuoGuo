//
//  NGPersonalInfoCell.h
//  NGG-NongGuoGuo
//
//  Created by mac on 16/10/13.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NGPersonalInfoCell : UITableViewCell

//描述
@property(nonatomic,retain) UILabel *descLable;
//信息
@property(nonatomic,retain) UILabel *infoLable;
//初始化cell类
-(id)initWithReuseIdentifier:(NSString*)reuseIdentifier;
@end
