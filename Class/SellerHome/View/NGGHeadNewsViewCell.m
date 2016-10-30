//
//  NGGHeadNewsViewCell.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/10/8.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGHeadNewsViewCell.h"

@implementation NGGHeadNewsViewCell


- (void)awakeFromNib {
 
}

/** 初始化方法,自定义 cell时,不清楚高度,可以在这里添加子空间 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor=NGGColor(255, 255, 255);
        /**
         *  创建控件
         */
        [self CreatCustomizeControls];
    }
    return self;
}

#pragma mark-创建控件
-(void)CreatCustomizeControls{
    /***上面的分割线***/
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    view.backgroundColor=NGGCutLineColor;
    [self.contentView addSubview:view];
     /*头条Label*/
    UILabel*Label1=[[UILabel alloc]initWithFrame:CGRectMake(12, 0, 70, 30)];
    Label1.ngg_centerY=self.ngg_centerY;
    [self addSubview:Label1];
    [Label1 setTextColor:NGGColorFromRGB(0x30c2bd)];
    [Label1 setFont:[UIFont systemFontOfSize:17 weight:4]];
    [Label1 setText:@"生意头条"];
     /*text Label*/
    UILabel*Label2=[[UILabel alloc]initWithFrame:CGRectMake(Label1.ngg_right+10, 0, SCREEN_WIDTH-Label1.ngg_width-42, 30)];
    Label2.ngg_centerY=self.ngg_centerY;
    [self addSubview:Label2];
    [Label2 setTextColor:[UIColor blackColor]];
    [Label2 setFont:[UIFont systemFontOfSize:14]];
    [Label2 setTextAlignment:NSTextAlignmentCenter];
    [Label2 setText:@"生意头条生意头条生意头条生意"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
