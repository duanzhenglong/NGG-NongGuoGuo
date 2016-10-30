//
//  NGGGoodsTableViewCell.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/10/13.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGGoodsTableViewCell.h"
#import "NGGSupplyDescViewController.h"
#import "NGGGoodsProperty.h"
@interface NGGGoodsTableViewCell()
@property (strong, nonatomic) NGGGoodsProperty* attribute;
@end
@implementation NGGGoodsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


#pragma mark -- 在这里可以重写cell的frame
- (void)setFrame:(CGRect)frame
{
    frame.origin.x = 3;
    frame.size.width -= 2 * frame.origin.x;
    [super setFrame:frame];
}

#pragma mark -- 初始化方法,自定义 cell时,不清楚高度,可以在这里添加子空间
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
    /***上面的分割线***/
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    view.backgroundColor=NGGCutLineColor;
    [self.contentView addSubview:view];
//    /***下面的分割线***/
//    UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0, 120, SCREEN_WIDTH, 0.5)];
//    view1.backgroundColor=NGGCutLineColor;
//    [self.contentView addSubview:view1];
    
    /*创建图片*/
    self.ImgView=[[UIImageView alloc] initWithFrame:CGRectMake(5, 0, SCREEN_WIDTH/4,SCREEN_WIDTH/4)];
    self.ImgView.ngg_centerY=55;
    [self addSubview:self.ImgView];
    
    /*创建标题Label*/
    self.TitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.ImgView.ngg_right+5, 10, SCREEN_WIDTH/4, 35)];
    [self.TitleLabel setFont:[UIFont systemFontOfSize:18 weight:1]];
    [self.TitleLabel setTextColor:NGGColorFromRGB(0x333333)];
    [self addSubview:self.TitleLabel];
    
    /*创建采购数量Label*/
    self.NumberLabel=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-90, self.TitleLabel.ngg_y+8, 80, 15)];
    [self.NumberLabel setFont:[UIFont systemFontOfSize:14]];
    self.NumberLabel.textAlignment=NSTextAlignmentRight;
    [self addSubview:self.NumberLabel];
    
    /***价格Label***/
    UILabel*Alabel=[[UILabel alloc]initWithFrame:CGRectMake(self.ImgView.ngg_right+5, self.TitleLabel.ngg_bottom+10, 0, 20)];
    Alabel.textColor=[UIColor orangeColor];
    [Alabel setFont:[UIFont systemFontOfSize:16 weight:1]];
    Alabel.textAlignment=NSTextAlignmentCenter;
    Alabel.text=@"1.2";
    [Alabel sizeToFit];
    [self addSubview:Alabel];
    self.Price=Alabel;
    
    /*创建地址Label*/
    self.AddressLab=[[UILabel alloc]initWithFrame:CGRectMake(self.ImgView.ngg_right+5, Alabel.ngg_bottom+10, 0, 20)];
    [self.AddressLab setFont:[UIFont systemFontOfSize:14]];
    [self.AddressLab setTextColor:[UIColor lightGrayColor]];
    [self addSubview:self.AddressLab];
    
    /*创建时间Label*/
    self.TimeLabel=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-125, self.NumberLabel.ngg_bottom+25, 110, 15)];
    [self.TimeLabel setFont:[UIFont systemFontOfSize:10]];
    [self.TimeLabel setTextColor:[UIColor grayColor]];
    self.TimeLabel.textAlignment=NSTextAlignmentRight;
    [self addSubview:self.TimeLabel];
    
    /*创建查看详情Button*/
    self.DscButton=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-90, self.AddressLab.ngg_y-3, 80, 25)];
    [self.DscButton.titleLabel setFont:[UIFont systemFontOfSize:15 weight:1]];
    [self.DscButton setTitle:@"查看详情" forState:UIControlStateNormal];
    [self.DscButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.DscButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    self.DscButton.layer.cornerRadius=5;
    self.DscButton.layer.masksToBounds=YES;
    [self.DscButton setBackgroundColor:NGGColorFromRGB(0x30c2bd)];
    [self.DscButton addTarget:self action:@selector(DscButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.DscButton];
    
}

#pragma mark-给每个控件进行赋值
-(void)initWithForm:(NGGGoodsProperty*)Attribute{
    self.attribute=Attribute;
    
    self.TitleLabel.text = Attribute.supplylist_goodsname;
    self.AddressLab.text = Attribute.address_name;
    self.AddressLab.numberOfLines=0;
    [self.AddressLab sizeToFit];
    
    self.NumberLabel.text = [NSString stringWithFormat:@"%@斤起批",Attribute.supplylist_minnumber];
    
    self.Price.text=[NSString stringWithFormat:@"%@元/斤",Attribute.supplylist_price];
    [self.Price sizeToFit];
    
    self.SellerNickLab.text = Attribute.user_nick;
    self.TimeLabel.text = Attribute.supplylist_time;

    NSArray*array=[Attribute.supplylist_image componentsSeparatedByString:@".png"];
    NSString*StringImageUrl=[NSString stringWithFormat:@"%@%@.png",GoodsimagesPrefix,array[0]];
    NSURL *UrlImageUrl=[NSURL URLWithString:StringImageUrl];
    /*下载图片*/
    [self.ImgView sd_setImageWithURL:UrlImageUrl];
}

#pragma mark-查看详情按钮的触发事件
-(void)DscButtonClick:(UIButton*)sender{
    
    UITabBarController *tabBarVc = (UITabBarController *)self.window.rootViewController;
    UINavigationController*nav=tabBarVc.selectedViewController;
    NGGSupplyDescViewController *Des=[[NGGSupplyDescViewController alloc]init];
    Des.hidesBottomBarWhenPushed=YES;
    /***将物品数据模型传过去***/
    Des.attribute=self.attribute;
    [nav pushViewController:Des animated:YES];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
