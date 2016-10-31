//
//  NGGAddressSelectView.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/10/30.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGAddressSelectView.h"

@implementation NGGAddressSelectView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor whiteColor];
        [self reloadAddressData];
    }
    return self;
}

-(void)SelectClick:(UIButton*)sender{
    if (self.addressBlock) {
        self.addressBlock(sender.tag-100,sender.currentTitle);
    }
    [sender.superview removeFromSuperview];
}

#pragma mark-获取数据
-(void)reloadAddressData{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:inqureAlladdressURL parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString*str=responseObject[@"message"];
        if ([str isEqualToString:@"查询成功"]) {
            self.addressArray=responseObject[@"data"];
            
            for (int i=0; i<self.addressArray.count; i++) {
                NSDictionary*dic=self.addressArray[i];
                /***地区***/
                CGFloat BtnW=(self.ngg_width-20)/3;
                CGFloat BtnH=25;
                UIButton* Btn=[[UIButton alloc]initWithFrame:CGRectMake((i%3)*BtnW+5*(i%3+1), (i/3)*BtnH+5*(i/3+1), BtnW, BtnH)];
                [Btn setBackgroundColor:NGGTheMeColor];
                [Btn.titleLabel setFont:[UIFont systemFontOfSize:12 weight:2]];
                Btn.layer.cornerRadius=5;
                Btn.layer.masksToBounds=YES;
                [Btn setTitle:dic[@"address_name"] forState:UIControlStateNormal];
                Btn.tag=[dic[@"address_id"] integerValue]+100;
                [Btn addTarget:self action:@selector(SelectClick:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:Btn];
            }
            self.ngg_height=self.subviews.lastObject.ngg_bottom;
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}

-(NSArray *)addressArray{
    if (!_addressArray) {
        _addressArray=[[NSMutableArray alloc]init];
    }
    return _addressArray;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self removeFromSuperview];
}

@end
