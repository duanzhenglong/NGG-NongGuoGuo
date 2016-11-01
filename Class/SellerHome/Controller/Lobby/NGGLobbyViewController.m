//
//  NGGLobbyViewController.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/10/8.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGLobbyViewController.h"
#import "NGGGoodsViewCell.h"
#import "NGGCategoryofAd.h"
@interface NGGLobbyViewController ()
@property (strong, nonatomic) NSArray* DataArray;
@end

@implementation NGGLobbyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [NGGPublishSupply HiddenPublishView];
    
    self.tableView.backgroundColor=NGGCommonBgColor;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.sectionHeaderHeight=40;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(Category:) name:@"Category" object:nil];

     /***根据分类查询物品信息***/
    NSDictionary *myParameters = @{
                                   @"address":@"",
                                   @"goodsclassify":@""
                                   };
    [self inquireNeedlistInfo:myParameters];
}

#pragma mark-根据分类查询物品信息
-(void)inquireNeedlistInfo:(NSDictionary*)dic{
    NSString*url;
    if ([dic[@"address"] isEqualToString:@""]&&[dic[@"goodsclassify"] isEqualToString:@""]) {
         url=allNeedlistURL;
    }else{
         url=inquireNeedlistURL;
    }

    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:url parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString*str=responseObject[@"message"];
        if ([str isEqualToString:@"查询成功！"]) {
            self.DataArray=[NGGGoodsAttribute mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.DataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NGGGoodsViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[NGGGoodsViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    NGGGoodsAttribute *Attribute=self.DataArray[indexPath.row];
    [cell initWithForm:Attribute];
    /*设置cell被中的样式，这里让它没有变化*/
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView * View=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    View.backgroundColor=NGGCommonBgColor;
    
    UIButton* Button1=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2-1, 40)];
    Button1.backgroundColor=[UIColor whiteColor];
    [Button1 setTitle:@"地区" forState:UIControlStateNormal];
    [Button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [Button1 setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [Button1.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [Button1 addTarget:self action:@selector(Button1:) forControlEvents:UIControlEventTouchUpInside];
    [View addSubview:Button1];
    
    UIButton* Button2=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2+1, 0, SCREEN_WIDTH/2-1, 40)];
    [Button2 setTitle:@"品类" forState:UIControlStateNormal];
    Button2.backgroundColor=[UIColor whiteColor];
    [Button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [Button2 setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [Button2.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [Button2 addTarget:self action:@selector(Button2:) forControlEvents:UIControlEventTouchUpInside];
    [View addSubview:Button2];
    return View;
}

#pragma mark-Button1的响应事件
-(void)Button1:(UIButton*)sender{
    [NGGCategoryofAd ShowAdCategoryView];
}

-(void)Category:(NSNotification*)info{
    NSDictionary*dic=[info valueForKey:@"userInfo"];
    NSString*string=dic[@"tag"];
    NSDictionary *myParameters = @{
                                  @"address":string,
                                  @"goodsclassify":@""
                                  };
   [self inquireNeedlistInfo:myParameters];

}

#pragma mark-Button2的响应事件
-(void)Button2:(UIButton*)sender{
    NGGLogFunc
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}


@end
