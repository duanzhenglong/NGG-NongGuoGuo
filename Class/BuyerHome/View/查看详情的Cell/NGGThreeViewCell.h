//
//  NGGThreeViewCell.h
//  NGG-NongGuoGuo
//
//  Created by Agan on 16/10/11.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NGGThreeViewCell : UITableViewCell

/*产品描述*/
@property(nonatomic, strong) UILabel *DescLab;

- (void)initWithForm:(NGGGoodsAttribute *)Attribute;

@end
