//
//  NGGSupplydesViewCell.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/10/14.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGSupplydesViewCell.h"
@interface NGGSupplydesViewCell()
 /***内容Label***/
@property (strong, nonatomic) UILabel* contentLabel;
@end
@implementation NGGSupplydesViewCell

- (void)awakeFromNib {
    // Initialization code
}

#pragma mark -- 初始化方法,自定义 cell时,不清楚高度,可以在这里添加子空间
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    
        self.backgroundColor=[UIColor whiteColor];
        /**
         *  创建控件
         */
        [self CreatCustomizeControls];
    }
    return self;
}

#pragma mark-给Cell自定义控件
-(void)CreatCustomizeControls{
    /***详情信息***/
    UILabel*Alabel=[[UILabel alloc]initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH-24, 0)];
    Alabel.textColor=[UIColor blackColor];
    [Alabel setFont:[UIFont systemFontOfSize:16 weight:0.5]];
    [self addSubview:Alabel];
    self.contentLabel=Alabel;
}

-(void)setLabelContent:(NSString*)string{
    self.contentLabel.text=string;
    self.contentLabel.numberOfLines=0;
    [self.contentLabel sizeToFit];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
