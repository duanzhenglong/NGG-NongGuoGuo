//
//  NGGGoodsViewCell.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/9/30.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGGoodsViewCell.h"
#import "NGGDetailTableViewController.h"
#import "NGGCategoryofAd.h"
@interface NGGGoodsViewCell()
@property (strong, nonatomic) NGGGoodsAttribute* attribute;
@end

@implementation NGGGoodsViewCell

/** 使用xib初始化cell,并完成IBoutlet 及IBAction 的关联后，可以在这里设置它们的默认值或配置 */
- (void)awakeFromNib {
   
}
/** 在这里可以布局cell中的元素，当cell的frame改变或旋转时会触发这个方法 */
- (void)layoutSubviews
{
   
}
/** 在这里可以重写cell的frame */
- (void)setFrame:(CGRect)frame
{
    frame.origin.x = 3;
    frame.origin.y+=3;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 1;
    [super setFrame:frame];
}

/** 在使用xib来加载cell进行初始化时，会被调用。可以在这里进行一些初始化操作 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder: aDecoder]) {
        //
    }
    return self;
}
/** 当需要在上下文中绘制时可以在这里处理 */
- (void)drawRect:(CGRect)rect
{
    
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
    /***上面的分割线***/
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    view.backgroundColor=NGGCutLineColor;
    [self.contentView addSubview:view];
    /*创建标题Label*/
    self.TitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH/2, 35)];
    [self.TitleLabel setFont:[UIFont systemFontOfSize:18 weight:2]];
    [self.TitleLabel setTextColor:NGGColorFromRGB(0x333333)];
    [self addSubview:self.TitleLabel];
    /*创建数量Label*/
    self.NumberLabel=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-100, 20, 60, 15)];
    [self.NumberLabel setFont:[UIFont systemFontOfSize:15]];
    [self addSubview:self.NumberLabel];
    /*创建内容Label*/
    self.ConentLabel=[[UILabel alloc]initWithFrame:CGRectMake(15, self.TitleLabel.ngg_bottom+10, SCREEN_WIDTH-40, 40)];
    [self.ConentLabel setFont:[UIFont systemFontOfSize:16]];
    self.ConentLabel.numberOfLines=0;
    [self addSubview:self.ConentLabel];
    /*创建时间Label*/
    self.TimeLabel=[[UILabel alloc]initWithFrame:CGRectMake(15, self.ConentLabel.ngg_bottom+20, 130, 15)];
    [self.TimeLabel setFont:[UIFont systemFontOfSize:14]];
    [self.TimeLabel setTextColor:[UIColor grayColor]];
    [self addSubview:self.TimeLabel];
    /*创建查看详情Button*/
    self.DscButton=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-100, self.TimeLabel.ngg_y-10, 80, 25)];
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
-(void)initWithForm:(NGGGoodsAttribute*)Attribute{
    self.attribute=Attribute;
    
    self.TitleLabel.text=Attribute.needlist_goodsname;
    self.NumberLabel.text=[NSString stringWithFormat:@"%@斤起批",Attribute.needlist_number];
    [self.NumberLabel sizeToFit];
    
    self.ConentLabel.text=Attribute.needlist_desc;
    self.TimeLabel.text=Attribute.needlist_time;
}

#pragma mark-查看详情按钮的触发事件
-(void)DscButtonClick:(UIButton*)sender{
    
    UITabBarController *tabBarVc = (UITabBarController *)self.window.rootViewController;
    UINavigationController*nav=tabBarVc.selectedViewController;
    NGGDetailTableViewController *Des=[[NGGDetailTableViewController alloc]init];
    Des.hidesBottomBarWhenPushed=YES;
     /***将物品数据模型传过去***/
    Des.attribute=self.attribute;
    [nav pushViewController:Des animated:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [NGGCategoryofAd HiddenAdCategoryView];
}
@end
