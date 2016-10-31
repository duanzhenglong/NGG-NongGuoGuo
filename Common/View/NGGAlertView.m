//
//  NGGAlertView.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/10/31.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGAlertView.h"
@interface NGGAlertView()

@end
@implementation NGGAlertView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.3];
        /***提示框背景***/
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.ngg_width*4/5, self.ngg_height/4)];
        view.backgroundColor=[UIColor whiteColor];
        view.layer.borderWidth=0.5;
        view.layer.borderColor=[NGGCutLineColor CGColor];
        view.layer.cornerRadius=5;
        view.layer.masksToBounds=YES;
        [UIView animateWithDuration:0.5 animations:^{
            view.ngg_x=(self.ngg_width-self.ngg_width*4/5)/2;
            view.ngg_centerY=self.ngg_centerY+15;
        }];
        [self addSubview:view];
        /***内容***/
        UILabel*Alabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 16, view.ngg_width-20, 35)];
        Alabel.textColor=[UIColor grayColor];
        [Alabel setFont:[UIFont systemFontOfSize:17 weight:1]];
        Alabel.textAlignment=NSTextAlignmentCenter;
        [view addSubview:Alabel];
        self.title =Alabel;
        
        UILabel*Alabel1=[[UILabel alloc]initWithFrame:CGRectMake(13, Alabel.ngg_bottom+5, view.ngg_width-20, 35)];
        Alabel1.textColor=[UIColor lightGrayColor];
        [Alabel1 setFont:[UIFont systemFontOfSize:15 weight:1]];
        Alabel1.textAlignment=NSTextAlignmentCenter;
        [view addSubview:Alabel1];
        self.Subtitle =Alabel1;
        
        /***取消***/
        UIButton* Btn=[[UIButton alloc]initWithFrame:CGRectMake(0, view.ngg_height-45, view.ngg_width/2, 45)];
        [Btn setBackgroundColor:NGGTheMeColor];
        [Btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [Btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [Btn.titleLabel setFont:[UIFont systemFontOfSize:15 weight:1]];
        [Btn addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:Btn];
        self.cancle=Btn;
        /***继续***/
        UIButton* Btn1=[[UIButton alloc]initWithFrame:CGRectMake(Btn.ngg_right+0.5, view.ngg_height-45, view.ngg_width/2, 45)];
        [Btn1 setBackgroundColor:NGGTheMeColor];
        [Btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [Btn1 setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [Btn1.titleLabel setFont:[UIFont systemFontOfSize:15 weight:1]];
        [Btn1 addTarget:self action:@selector(OkClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:Btn1];
        self.ok=Btn1;
    }
    return self;
}

#pragma mark-取消
-(void)cancelClick:(UIButton*)sender{
    self.cancelBlock();
}

#pragma mark-继续
-(void)OkClick:(UIButton*)sender{
    self.OkBlock();
}

-(void)settitle:(NSString*)title subtitle:(NSString*)subtitle cancelTitle:(NSString*)canceltitle okTitle:(NSString*)oktitle{
    self.title.text=title;
    self.Subtitle.text=subtitle;
    self.Subtitle.numberOfLines=0;
    [self.Subtitle sizeToFit];
    [self.cancle setTitle:canceltitle forState:UIControlStateNormal];;
    [self.ok setTitle:oktitle forState:UIControlStateNormal];;
}

@end
