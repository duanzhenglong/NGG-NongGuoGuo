//
//  NGGAbrufbilViewCell.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/10/13.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGAbrufbilViewCell.h"
@interface NGGAbrufbilViewCell()
@property (strong, nonatomic) UILabel* nameLabel;
@property (strong, nonatomic) UIImageView* imageview;
@property (strong, nonatomic) UILabel* conentLabel;
@property (strong, nonatomic) UIButton* chatButton;
@end
@implementation NGGAbrufbilViewCell

- (void)awakeFromNib {
    // Initialization code
}

/** 在这里可以重写cell的frame */
- (void)setFrame:(CGRect)frame
{
    frame.origin.y+=3;
    frame.size.height -= 1;
    [super setFrame:frame];
}

/** 初始化方法,自定义 cell时,不清楚高度,可以在这里添加子空间 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor=NGGColor(255, 255, 255);
        /*创建控件*/
        [self CreatCustomizeControls];
    }
    return self;
}

#pragma mark-给Cell自定义控件
-(void)CreatCustomizeControls{
    /***物品名称***/
    UILabel*Alabel=[[UILabel alloc]initWithFrame:CGRectMake(12, 15, SCREEN_WIDTH/3, 20)];
    Alabel.textColor=[UIColor blackColor];
    [Alabel setFont:[UIFont systemFontOfSize:15 weight:1]];
    Alabel.backgroundColor=[UIColor blueColor];
    Alabel.textAlignment=NSTextAlignmentCenter;
    [self addSubview:Alabel];
    self.nameLabel=Alabel;
    /*聊一聊*/
    UIButton*ChatBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 20, 50, 25)];
    ChatBtn.ngg_x=SCREEN_WIDTH-64;
    ChatBtn.layer.cornerRadius=5;
    ChatBtn.layer.masksToBounds=YES;
    [ChatBtn setBackgroundColor:NGGTheMeColor];
    [ChatBtn setTitle:@"聊一聊" forState:UIControlStateNormal];
    [ChatBtn.titleLabel setFont:[UIFont systemFontOfSize:13 weight:1]];
    [ChatBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [ChatBtn addTarget:self action:@selector(ChatBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:ChatBtn];
    self.chatButton=ChatBtn;
    
    /***图片***/
    UIImageView*imageview=[[UIImageView alloc]initWithFrame:CGRectMake(12, Alabel.ngg_bottom+10, 50, 50)];
    imageview.backgroundColor=NGGRandomColor;
    [self addSubview:imageview];
    self.imageview=imageview;
    /***内容提示***/
    UILabel*Alabel1=[[UILabel alloc]initWithFrame:CGRectMake(imageview.ngg_right+5, imageview.ngg_y+14, SCREEN_WIDTH-65, 25)];
    Alabel1.textColor=[UIColor orangeColor];
    [Alabel1 setFont:[UIFont systemFontOfSize:13 weight:1]];
    Alabel1.backgroundColor=[UIColor blueColor];
    Alabel1.textAlignment=NSTextAlignmentCenter;
    Alabel1.text=@"买家已经同意你的报价啦！赶快聊一聊吧";
    [self addSubview:Alabel1];
    self.conentLabel=Alabel1;
    
}

#pragma mark-进行赋值
-(void)setValue:(NSDictionary*)dic andflg:(int)flg{
    if (flg==0) {
        self.imageview.image=[UIImage imageNamed:@""];//找一张失望的图片
        self.conentLabel.text=@"你来晚了，物品已经没有了";
        [self.chatButton removeFromSuperview];
    }
    self.imageview.image=[UIImage imageNamed:@""];//一张开心的图片
    self.conentLabel.text=@"买家已经同意你的报价啦！赶快聊一聊吧";
    self.nameLabel=dic[@"goodsname"];
}

#pragma mark-聊一聊按钮事件
-(void)ChatBtnClick:(UIButton*)sender{
    NGGLogFunc
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
