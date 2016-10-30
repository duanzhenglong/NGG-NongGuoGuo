//
//  NGGAddAddressCell.m
//  NGG-NongGuoGuo
//
//  Created by mac on 16/10/11.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGAddAddressCell.h"
#import "UIView+NGGExtension.h"


@implementation NGGAddAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addControls];
        
    }
    return self;
}
#pragma mark-添加控件
-(void)addControls{
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(2*self.ngg_width/5, 0, 3*self.ngg_width/5, self.ngg_height)];
    [self addSubview:_textField];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
