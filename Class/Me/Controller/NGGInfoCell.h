//
//  NGGInfoCell.h
//  NGG-NongGuoGuo
//
//  Created by mac on 16/10/11.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NGGInfoCell : UITableViewCell
@property (strong,nonatomic) UILabel *offeruserName;
@property (strong,nonatomic) UILabel *offerPriceTime;
-(id)initWithReuseIdentifier:(NSString*)reuseIdentifier;
@end
