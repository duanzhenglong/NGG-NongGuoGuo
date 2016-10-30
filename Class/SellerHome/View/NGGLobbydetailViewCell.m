//
//  NGGLobbydetailViewCell.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/10/12.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGLobbydetailViewCell.h"

@interface NGGLobbydetailViewCell()
 /***采购品类***/
@property (strong, nonatomic)UILabel* goodsclassifyLabel;
 /***物品名称***/
@property (strong, nonatomic) UILabel* goodsnameLabel;
 /***采购数量***/
@property (strong, nonatomic) UILabel* goodsnumberLabel;
 /***产地***/
@property (strong, nonatomic) UILabel* goodsaddressLabel;
 /***具体内容***/
@property (strong, nonatomic) UILabel* goodsdescLabel;
 /***接收需求表id***/
@property int listid;
@end

@implementation NGGLobbydetailViewCell

- (void)awakeFromNib {
    // Initialization code
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
    /***下划线***/
    UIView *view5=[[UIView alloc]initWithFrame:CGRectMake(12, 1, SCREEN_WIDTH-24, 1)];
    view5.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.3];
    [self addSubview:view5];
    /***物品分类***/
    UILabel*Alabel=[[UILabel alloc]initWithFrame:CGRectMake(12, 2, SCREEN_WIDTH/4, 60)];
    Alabel.textColor=[UIColor grayColor];
    [Alabel setFont:[UIFont systemFontOfSize:18 weight:1]];
    Alabel.backgroundColor=NGGCommonBgColor;
    Alabel.textAlignment=NSTextAlignmentCenter;
    Alabel.text=@"采购品类";
    [self addSubview:Alabel];
    /***物品分类名称***/
    UILabel*Alabel1=[[UILabel alloc]initWithFrame:CGRectMake(Alabel.ngg_right, 2, SCREEN_WIDTH*3/4, 60)];
    Alabel1.textColor=[UIColor blackColor];
    [Alabel1 setFont:[UIFont systemFontOfSize:14 weight:1]];
    Alabel1.backgroundColor=[UIColor whiteColor];
    Alabel1.textAlignment=NSTextAlignmentCenter;
    [self addSubview:Alabel1];
    self.goodsclassifyLabel=Alabel1;
    /***下划线***/
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(12, Alabel1.ngg_bottom, SCREEN_WIDTH-24, 1)];
    view.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.3];
    [self addSubview:view];
    
    /***物品名称***/
    UILabel*Alabel2=[[UILabel alloc]initWithFrame:CGRectMake(12, view.ngg_bottom, SCREEN_WIDTH/4, 60)];
    Alabel2.textColor=[UIColor grayColor];
    [Alabel2 setFont:[UIFont systemFontOfSize:18 weight:1]];
    Alabel2.backgroundColor=NGGCommonBgColor;
    Alabel2.textAlignment=NSTextAlignmentCenter;
    Alabel2.text=@"物品名称";
    [self addSubview:Alabel2];
    /***物品名称内容***/
    UILabel*Alabel3=[[UILabel alloc]initWithFrame:CGRectMake(Alabel2.ngg_right, Alabel2.ngg_y, SCREEN_WIDTH*3/4, 60)];
    Alabel3.textColor=[UIColor blackColor];
    [Alabel3 setFont:[UIFont systemFontOfSize:14 weight:1]];
    Alabel3.backgroundColor=[UIColor whiteColor];
    Alabel3.textAlignment=NSTextAlignmentCenter;
    [self addSubview:Alabel3];
    self.goodsnameLabel=Alabel3;
    /***下划线***/
    UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(12, Alabel2.ngg_bottom, SCREEN_WIDTH-24, 1)];
    view1.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.3];
    [self addSubview:view1];
    
    /***采购数量***/
    UILabel*Alabel4=[[UILabel alloc]initWithFrame:CGRectMake(12, view1.ngg_bottom, SCREEN_WIDTH/4, 60)];
    Alabel4.textColor=[UIColor grayColor];
    [Alabel4 setFont:[UIFont systemFontOfSize:18 weight:1]];
    Alabel4.backgroundColor=NGGCommonBgColor;
    Alabel4.textAlignment=NSTextAlignmentCenter;
    Alabel4.text=@"采购数量";
    [self addSubview:Alabel4];
    /***采购数量内容***/
    UILabel*Alabel5=[[UILabel alloc]initWithFrame:CGRectMake(Alabel4.ngg_right, Alabel4.ngg_y, SCREEN_WIDTH*3/4, 60)];
    Alabel5.textColor=[UIColor blackColor];
    [Alabel5 setFont:[UIFont systemFontOfSize:14 weight:1]];
    Alabel5.backgroundColor=[UIColor whiteColor];
    Alabel5.textAlignment=NSTextAlignmentCenter;
    [self addSubview:Alabel5];
    self.goodsnumberLabel=Alabel5;
    /***下划线***/
    UIView *view2=[[UIView alloc]initWithFrame:CGRectMake(12, Alabel4.ngg_bottom, SCREEN_WIDTH-24, 1)];
    view2.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.3];
    [self addSubview:view2];
    
    /***指定产地***/
    UILabel*Alabel6=[[UILabel alloc]initWithFrame:CGRectMake(12, view2.ngg_bottom, SCREEN_WIDTH/4, 60)];
    Alabel6.textColor=[UIColor grayColor];
    [Alabel6 setFont:[UIFont systemFontOfSize:18 weight:1]];
    Alabel6.backgroundColor=NGGCommonBgColor;
    Alabel6.textAlignment=NSTextAlignmentCenter;
    Alabel6.text=@"指定产地";
    [self addSubview:Alabel6];
    /***指定产地内容***/
    UILabel*Alabel7=[[UILabel alloc]initWithFrame:CGRectMake(Alabel6.ngg_right, Alabel6.ngg_y, SCREEN_WIDTH*3/4, 60)];
    Alabel7.textColor=[UIColor blackColor];
    [Alabel7 setFont:[UIFont systemFontOfSize:14 weight:1]];
    Alabel7.backgroundColor=[UIColor whiteColor];
    Alabel7.textAlignment=NSTextAlignmentCenter;
    [self addSubview:Alabel7];
    self.goodsaddressLabel=Alabel7;
    /***下划线***/
    UIView *view3=[[UIView alloc]initWithFrame:CGRectMake(12, Alabel6.ngg_bottom, SCREEN_WIDTH-24, 1)];
    view3.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.3];
    [self addSubview:view3];
    
    /***具体要求***/
    UILabel*Alabel8=[[UILabel alloc]initWithFrame:CGRectMake(12, view3.ngg_bottom, SCREEN_WIDTH/4, 60)];
    Alabel8.textColor=[UIColor grayColor];
    [Alabel8 setFont:[UIFont systemFontOfSize:18 weight:1]];
    Alabel8.backgroundColor=NGGCommonBgColor;
    Alabel8.textAlignment=NSTextAlignmentCenter;
    Alabel8.text=@"具体要求";
    [self addSubview:Alabel8];
    /***具体要求内容***/
    UILabel*Alabel9=[[UILabel alloc]initWithFrame:CGRectMake(Alabel8.ngg_right, Alabel8.ngg_y, SCREEN_WIDTH*3/4, 60)];
    Alabel9.textColor=[UIColor blackColor];
    [Alabel9 setFont:[UIFont systemFontOfSize:14 weight:1]];
    Alabel9.backgroundColor=[UIColor whiteColor];
    Alabel9.textAlignment=NSTextAlignmentCenter;
    [self addSubview:Alabel9];
    self.goodsdescLabel=Alabel9;
    /***下划线***/
    UIView *view4=[[UIView alloc]initWithFrame:CGRectMake(12, Alabel9.ngg_bottom, SCREEN_WIDTH-24, 1)];
    view4.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.3];
    [self addSubview:view4];
    /***下划线***/
    UIView *view6=[[UIView alloc]initWithFrame:CGRectMake(11, 0, 1, 400)];
    view6.ngg_bottom=view4.ngg_bottom;
    view6.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.3];
    [self addSubview:view6];
    /***下划线***/
    UIView *view7=[[UIView alloc]initWithFrame:CGRectMake(Alabel .ngg_right, 0, 1, 400)];
    view7.ngg_bottom=view4.ngg_bottom;
    view7.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.3];
    [self addSubview:view7];
    /***下划线***/
    UIView *view8=[[UIView alloc]initWithFrame:CGRectMake(view4.ngg_right, 0, 1, 400)];
    view8.ngg_bottom=view4.ngg_bottom;
    view8.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.3];
    [self addSubview:view8];
    
    
}

#pragma mark-进行赋值
-(void)setContentFrom:(NGGGoodsAttribute*)Attribute{
    self.goodsnameLabel.text=Attribute.needlist_goodsname;
    self.goodsnumberLabel.text=Attribute.needlist_number;
    self.goodsdescLabel.text=Attribute.needlist_desc;
    self.listid=Attribute.needlist_id;
    
    [self RequireListGoodsInfo];

}

#pragma mark-查询物品信息
-(void)RequireListGoodsInfo{
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    NSDictionary *myParameters = @{
                                   @"listid":[NSString stringWithFormat:@"%d",self.listid],
                                   @"type":@"1"
                                   };
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:inqureGoodsInfoByIdURL parameters:myParameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString*str=responseObject[@"message"];
        if ([str isEqualToString:@"查询成功！"]) {
            NSDictionary*dic=responseObject[@"data"];
            self.goodsclassifyLabel.text=dic[@"goodsclassify_name"];
            self.goodsaddressLabel.text=dic[@"address_name"];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
