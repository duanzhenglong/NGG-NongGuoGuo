//
//  NGGOrderTableViewCell.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/10/31.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGOrderTableViewCell.h"
@interface NGGOrderTableViewCell()
@property (strong, nonatomic) UIImageView* goodsimage;
@property (strong, nonatomic) UILabel* titleLabel;
@property (strong, nonatomic) UILabel* priceLabel;
@property (strong, nonatomic) UILabel* descLabel;
@property (strong, nonatomic) UILabel* addressLabel;
@property (strong, nonatomic) UILabel* timeLabel;
@end
@implementation NGGOrderTableViewCell

- (void)awakeFromNib {
}


+(instancetype)cellWithTable:(UITableView*)tableView{
    static NSString* cellid=@"cellId";
    NGGOrderTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell=[[NGGOrderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setData{
    /***下载图片***/
    NSArray*array=[self.Order.order_goodsimage componentsSeparatedByString:@".png"];
    NSString*StringImageUrl=[NSString stringWithFormat:@"%@%@.png",GoodsimagesPrefix,array[0]];
    NSURL *UrlImageUrl=[NSURL URLWithString:StringImageUrl];
    [self.goodsimage sd_setImageWithURL:UrlImageUrl];
    self.titleLabel.text=self.Order.order_goodsname;
    self.priceLabel.text=[NSString stringWithFormat:@"%@元/斤",self.Order.order_goodsprice];
    self.descLabel.text=self.Order.order_goodsdesc;
    self.addressLabel.text=self.Order.order_address;
    [self.addressLabel sizeToFit];
    self.timeLabel.text=self.Order.order_time;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        /***下画线***/
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
        view.backgroundColor=NGGCutLineColor;
        [self.contentView addSubview:view];
        /***图片***/
        UIImageView*imageview=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, self.ngg_width/4, self.ngg_width/4)];
        imageview.backgroundColor=NGGRandomColor;
        [self.contentView addSubview:imageview];
        self.goodsimage=imageview;
        /***标题***/
        UILabel*Alabel=[[UILabel alloc]initWithFrame:CGRectMake(imageview.ngg_right+10, imageview.ngg_y, SCREEN_WIDTH-self.ngg_width/4-30, 20)];
        Alabel.textColor=[UIColor blackColor];
        [Alabel setFont:[UIFont systemFontOfSize:15 weight:1]];
        Alabel.textAlignment=NSTextAlignmentLeft;
        Alabel.text=@"苹果";
        [self.contentView addSubview:Alabel];
        self.titleLabel=Alabel;
        /***价格***/
        UILabel*Alabel1=[[UILabel alloc]initWithFrame:CGRectMake(imageview.ngg_right+10, Alabel.ngg_bottom+5, SCREEN_WIDTH-self.ngg_width/4-30, 20)];
        Alabel1.textColor=[UIColor orangeColor];
        [Alabel1 setFont:[UIFont systemFontOfSize:14]];
        Alabel1.textAlignment=NSTextAlignmentLeft;
        Alabel1.text=@"1.2元/斤";
        [self.contentView addSubview:Alabel1];
        self.priceLabel=Alabel1;
        /***描述***/
        UILabel*Alabel2=[[UILabel alloc]initWithFrame:CGRectMake(imageview.ngg_right+10, Alabel1.ngg_bottom+5, SCREEN_WIDTH-self.ngg_width/4-30, 20)];
        Alabel2.textColor=[UIColor blackColor];
        [Alabel2 setFont:[UIFont systemFontOfSize:14]];
        Alabel2.textAlignment=NSTextAlignmentLeft;
        Alabel2.text=@"很好吃.............";
        [self.contentView addSubview:Alabel2];
        self.descLabel=Alabel2;
        /***地区***/
        UILabel*Alabel3=[[UILabel alloc]initWithFrame:CGRectMake(imageview.ngg_right+10, Alabel2.ngg_bottom+5, 80, 15)];
        Alabel3.textColor=[UIColor grayColor];
        [Alabel3 setFont:[UIFont systemFontOfSize:12 weight:1]];
        Alabel3.textAlignment=NSTextAlignmentLeft;
        Alabel3.text=@"江苏 苏州";
        [self.contentView addSubview:Alabel3];
        self.addressLabel=Alabel3;
        /***时间***/
        UILabel*Alabel4=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-110, Alabel3.ngg_y, 100, 15)];
        Alabel4.textColor=[UIColor lightGrayColor];
        [Alabel4 setFont:[UIFont systemFontOfSize:12 weight:1]];
        Alabel4.textAlignment=NSTextAlignmentRight;
        Alabel4.text=@"剩余时间 12天";
        [self.contentView addSubview:Alabel4];
        self.timeLabel=Alabel4;
    }
    return self;
}

-(void)setOrder:(NGGOrder *)Order{
    _Order=Order;
    [self setData];
}

@end
