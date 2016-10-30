//
//  NGGCategoryofAd.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/10/18.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGCategoryofAd.h"
@interface NGGCategoryofAd()
@property (strong, nonatomic) NSArray* DataArray;

@end
@implementation NGGCategoryofAd
static NGGCategoryofAd *AdCategoryView;

+(void)ShowAdCategoryView{
    if (!AdCategoryView) {
        UIWindow *window=[UIApplication sharedApplication].keyWindow;
        AdCategoryView=[[NGGCategoryofAd alloc]initWithFrame:CGRectMake(- window.ngg_width*2/3, 0, window.ngg_width*2/3, window.ngg_height)];
        AdCategoryView.backgroundColor=[UIColor whiteColor];
        [UIView animateWithDuration:0.5 animations:^{
            AdCategoryView.hidden=NO;
            AdCategoryView.ngg_x=0;
            [window addSubview:AdCategoryView];
            [AdCategoryView viewDidLoad];
        }];
    }
}

+(void)HiddenAdCategoryView{
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    [UIView animateWithDuration:0.5 animations:^{
        AdCategoryView.ngg_x=- window.ngg_width*2/3;
    } completion:^(BOOL finished) {
        AdCategoryView.hidden=YES;
    }];
    AdCategoryView=nil;
}

#pragma mark-加载数据
-(void)viewDidLoad{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:inqureAlladdressURL parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString*str=responseObject[@"message"];
        if ([str isEqualToString:@"查询成功"]) {
            self.DataArray=responseObject[@"data"];
            [self Layout:self.DataArray];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}

#pragma mark-进行布局
-(void)Layout:(NSArray*)DataArray{
    /***地区名称***/
    UILabel*Alabel=[[UILabel alloc]initWithFrame:CGRectMake(12, 64, 40, 20)];
    Alabel.textColor=[UIColor grayColor];
    [Alabel setFont:[UIFont systemFontOfSize:16]];
    Alabel.textAlignment=NSTextAlignmentCenter;
    Alabel.text=@"地区";
    [AdCategoryView addSubview:Alabel];
    /***分割线***/
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0,Alabel.ngg_bottom+10, AdCategoryView.ngg_width, 1)];
    view.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.1];
    [AdCategoryView addSubview:view];
    /***创建装button的背景***/
    UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(5, view.ngg_bottom+5, AdCategoryView.ngg_width-10, AdCategoryView.ngg_height-41)];
    [AdCategoryView addSubview:view1];

    CGFloat buttonW=(AdCategoryView.ngg_width-20)/3;
    CGFloat buttonH=25;
    for (int i=0; i<DataArray.count; i++) {
        NSDictionary*dic=DataArray[i];
        /***物品选项***/
        UIButton* Btn=[[UIButton alloc]init];
        
        /***设置frame***/
        Btn.ngg_x=(i%3)*buttonW+5*(i%3+1);
        Btn.ngg_y=(i/3)*buttonH+10*(i/3+1);
        Btn.ngg_width=buttonW;
        Btn.ngg_height=buttonH;
        /***设置属性***/
        [Btn setBackgroundColor:NGGCommonBgColor];
        [Btn setTitleColor:[[UIColor blackColor]colorWithAlphaComponent:0.7 ] forState:UIControlStateNormal];
        [Btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [Btn.titleLabel setFont:[UIFont systemFontOfSize:15 weight:2]];
        Btn.layer.cornerRadius=5;
        Btn.layer.masksToBounds=YES;
        /***赋值***/
        [Btn setTitle:dic[@"address_name"] forState:UIControlStateNormal];
        Btn.tag=[dic[@"address_id"] integerValue]+100;
        
        [Btn addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
        [view1 addSubview:Btn];
    }
     /***让装Button的背景高度等于它上面最后一个Button的底***/
    view1.ngg_height=view1.subviews.lastObject.ngg_bottom;
}

#pragma mark-事件触发
-(void)Click:(UIButton*)sender{
    NSString*tag=[NSString stringWithFormat:@"%ld",sender.tag-100];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Category" object:self userInfo:@{@"tag":tag}];
    [NGGCategoryofAd HiddenAdCategoryView];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [NGGCategoryofAd HiddenAdCategoryView];
}
@end
