//
//  NGGNewsViewCell.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/10/9.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGNewsViewCell.h"

@implementation NGGNewsViewCell

- (void)awakeFromNib {
    
}

/** 在这里可以重写cell的frame */
- (void)setFrame:(CGRect)frame
{
    frame.origin.x = 3;
    frame.origin.y+=2;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 1;
    [super setFrame:frame];
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

#pragma mark-给Cell自定义控件
-(void)CreatCustomizeControls{
    /*创建标题Label*/
    self.TitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(12, 20, SCREEN_WIDTH*2/3-20, 35)];
    [self.TitleLabel setFont:[UIFont systemFontOfSize:15 weight:1]];
    [self.TitleLabel setTextColor:NGGColorFromRGB(0x333333)];
    [self addSubview:self.TitleLabel];
    
     /*创建imageview*/
    self.Imageview=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*2/3, 10, SCREEN_WIDTH/3-10, 100-20)];
    self.Imageview.backgroundColor=NGGRandomColor;
    [self addSubview:self.Imageview];

    /*创建时间Label*/
    self.TimeLabel=[[UILabel alloc]initWithFrame:CGRectMake(11, self.Imageview.ngg_bottom-15, 130, 15)];
    [self.TimeLabel setFont:[UIFont systemFontOfSize:13]];
    [self.TimeLabel setTextColor:[UIColor lightGrayColor]];
    [self addSubview:self.TimeLabel];
 
}

#pragma mark-给每个控件进行赋值
-(void)initWithForm:(NSDictionary*)dic{
    
    NSString*StringImageUrl=[NSString stringWithFormat:@"%@%@",NewsPrefix,dic[@"news_image"]];
    NSURL *UrlImageUrl=[NSURL URLWithString:StringImageUrl];
    
    self.TitleLabel.text=dic[@"news_title"];
    self.TitleLabel.numberOfLines=0;
    [self.TitleLabel sizeToFit];
    
    self.ConentURL=dic[@"news_desc"];
    self.TimeLabel.text=@"2016-9-11";
     /*下载图片*/
   [self.Imageview sd_setImageWithURL:UrlImageUrl];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
