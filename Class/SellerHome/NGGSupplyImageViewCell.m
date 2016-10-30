//
//  NGGSupplyImageViewCell.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/10/14.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGSupplyImageViewCell.h"
@interface  NGGSupplyImageViewCell()
@property (strong, nonatomic) UIImageView* imageview;
@end
@implementation NGGSupplyImageViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setFrame:(CGRect)frame{
    frame.origin.y+=5;
    frame.size.height-=3;
    [super setFrame:frame];
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
    /***物品图片***/
    self.imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
    self.imageview.backgroundColor=NGGRandomColor;
    [self addSubview:self.imageview];
}
#pragma mark-下载物品图片
-(void)setimageviewfrom:(NSString*)sting{
    NSString*StringImageUrl=[NSString stringWithFormat:@"%@%@.png",GoodsimagesPrefix,sting];
    NSURL *UrlImageUrl=[NSURL URLWithString:StringImageUrl];
    [self.imageview sd_setImageWithURL:UrlImageUrl];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
