//
//  NGGUpdateCell.m
//  NGG-NongGuoGuo
//
//  Created by mac on 16/10/11.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGUpdateCell.h"
#import "UIView+NGGExtension.h"
@implementation NGGUpdateCell

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
-(void)addControls{
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3, 0, 2*SCREEN_WIDTH/3, self.ngg_height)];
    [self addSubview:_textField];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
