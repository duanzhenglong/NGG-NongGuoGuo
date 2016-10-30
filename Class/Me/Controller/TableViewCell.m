//
//  TableViewCell.m
//  NGG-NongGuoGuo
//
//  Created by mac on 16/10/9.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
       //初始化控件
        _descLable = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, self.frame.size.width/4, 44)];
        [self addSubview:_descLable];
        _infoLable = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/4+40, 0, 3*self.frame.size.width/4+40, 44)];
        [self addSubview:_infoLable];
    }
    return self;
}



    
    
    

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
