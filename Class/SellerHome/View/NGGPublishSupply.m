//
//  NGGPublishSupply.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/10/9.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGPublishSupply.h"
#import "NGGGoodsClassifyMenuController.h"
@interface NGGPublishSupply(){
    int TotalTime;
}
/*创建计时器*/
@property (strong, nonatomic) NSTimer* Timer;
@end

@implementation NGGPublishSupply

#define Window [UIApplication sharedApplication].keyWindow
static int distence;
static NGGPublishSupply *PublishView;
/**
 *显示发布界面
 */
+(void)ShowPublishView{
    if (!PublishView) {
        PublishView=[[NGGPublishSupply alloc]initWithFrame:CGRectMake(Window.ngg_width-Window.ngg_width/5-20, Window.ngg_height, Window.ngg_width/6,Window.ngg_width/6 )];
        [UIView animateWithDuration:0.5 animations:^{
            PublishView.hidden=NO;
            PublishView.ngg_y-=(60+Window.ngg_width/5);
            distence=(60+Window.ngg_width/5);
            PublishView.backgroundColor=[UIColor whiteColor];
            if (USERDEFINE.currentUser.Usermark==0) {
                UIImageView*imageview=[[UIImageView alloc]init];
                imageview.frame=PublishView.bounds;
                imageview.image=[UIImage imageNamed:@"cai"];
                [PublishView addSubview:imageview];
            }else{
                UIImageView*imageview=[[UIImageView alloc]init];
                imageview.frame=PublishView.bounds;
                imageview.image=[UIImage imageNamed:@"gong"];
                [PublishView addSubview:imageview];
            }
            PublishView.layer.cornerRadius=PublishView.ngg_width/2;
            PublishView.layer.masksToBounds=YES;
            /*添加属性*/
            [PublishView addAttribute];
            [Window addSubview:PublishView];
        } completion:^(BOOL finished) {
            [PublishView AddTimer];
        }];
    }
}
/**
 *隐藏发布界面
 */
+(void)HiddenPublishView{
    [UIView animateWithDuration:0.5 animations:^{
        if (PublishView) {
           PublishView.ngg_y+=distence;
        }
    } completion:^(BOOL finished) {
        [PublishView removeFromSuperview];
    }];
    PublishView=nil;
}

#pragma mark- 添加属性
-(void)addAttribute{
    PublishView.layer.cornerRadius=PublishView.ngg_width/2;
    PublishView.layer.masksToBounds=YES;
     /*添加手势*/
    UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapGesture:)];
    PublishView.userInteractionEnabled=YES;
    [PublishView addGestureRecognizer:tap];
    UIPanGestureRecognizer*pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(PanGesture:)];
    [PublishView addGestureRecognizer:pan];
}

#pragma mark-手势事件
-(void)TapGesture:(UITapGestureRecognizer*)Gesture{
    UITabBarController *tabBarVc = (UITabBarController *)self.window.rootViewController;
    UINavigationController*nav=tabBarVc.selectedViewController;

    NGGGoodsClassifyMenuController *Supply=[[NGGGoodsClassifyMenuController alloc]init];
    Supply.hidesBottomBarWhenPushed=YES;
    [NGGPublishSupply HiddenPublishView];
    [nav pushViewController:Supply animated:YES];
  
}

-(void)PanGesture:(UIPanGestureRecognizer*)Gesture{
    CGPoint currentPoint=Gesture.view.center;
    CGPoint translation=[Gesture translationInView:Window];
    Gesture.view.center=CGPointMake(currentPoint.x+translation.x, currentPoint.y+translation.y);
    distence=Window.ngg_height;
    [Gesture setTranslation:CGPointZero inView:Window];
}

#pragma mark-添加计时器
-(void)AddTimer{
    TotalTime=6;
    self.Timer=[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(ChangeTime) userInfo:nil repeats:YES];
}

#pragma mark-移除计时器
-(void)RemoveTimer{
    [self.Timer invalidate];
    self.Timer=nil;
}

#pragma mark-计时开始
-(void)ChangeTime{
    if (TotalTime==0) {
        [NGGPublishSupply HiddenPublishView];
        [self RemoveTimer];
    }
    TotalTime--;
}

@end
