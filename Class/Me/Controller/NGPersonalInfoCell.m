//
//  NGPersonalInfoCell.m
//  NGG-NongGuoGuo
//
//  Created by mac on 16/10/13.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGPersonalInfoCell.h"
#import "UIView+NGGExtension.h"
@implementation NGPersonalInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        //初始化控件
        _descLable = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH/4, self.frame.size.height)];
        [self addSubview:_descLable];
        _infoLable = [[UILabel alloc]initWithFrame:CGRectMake(_descLable.ngg_x+_descLable.ngg_width+10, 0, SCREEN_WIDTH-(_descLable.ngg_x+_descLable.ngg_width+10), self.frame.size.height)];
        [self addSubview:_infoLable];
    }
   
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
