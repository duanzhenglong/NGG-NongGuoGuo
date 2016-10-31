//
//  NGGSellerHomeViewController.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/9/29.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGSellerHomeViewController.h"
#import "NGGSearchView.h"
#import "NGGGoodsViewCell.h"
#import "NGGGoodsAttribute.h"
#import "NGGHeadNewsViewCell.h"
#import "NGGChannelViewCell.h"
#import "NGGToolViewCell.h"
#import "NGGPublishSupply.h"
#import "NGGGoodsClassifyMenuController.h"
#import "NGGSellerHomeHeaderView.h"

#import "NGGFunctionViewCell.h"
#import "NGGGoodsClassViewCell.h"
#import "NGGGoodsTableViewCell.h"
#import "NGGHeadCell.h"
@interface NGGSellerHomeViewController (){
    CGFloat contentOffsetY;
    CGFloat newContentOffsetY;
    CGFloat oldContentOffsetY;
}
@property (strong, nonatomic) NSArray* DataArray;
@end

@implementation NGGSellerHomeViewController
 /*声明cell ID*/
static NSString * const NGGHeadNewsViewCellId = @"NGGHeadNewsViewCell";
static NSString * const NGGGoodsViewCellId = @"NGGGoodsViewCell";
static NSString * const NGGChannelViewCellId = @"NGGChannelViewCell";
static NSString * const NGGToolViewCellId = @"NGGToolViewCell";


static NSString *const NGGHeadViewCellId      = @"NGGHeadViewCell";
static NSString *const NGGFunctionViewCellId      = @"NGGFunctionViewCell";
static NSString *const NGGGoodsClassViewCellId    = @"NGGGoodsClassViewCell";
static NSString *const NGGGoodsTableViewCellId = @"NGGGoodsTableViewCell";


static int flg;
- (void)viewDidLoad {
    [super viewDidLoad];
    flg=USERDEFINE.currentUser.Usermark;
     /*背景颜色*/
    self.view.backgroundColor=NGGHomeBgColor;
    /*创建导航栏上的搜索栏*/
    [self CreateSearchBar];
     /*tableView的一些属性*/
    [self SetTableViewAttri];
     /*注册自定义cell*/
    [self registerCells];
     /*添加右发布按钮*/
    [self AddRightPublishBtn];
     /***今日推荐信息***/
    [self inquireNeedlistInfo];
}

#pragma mark-今日推荐信息
-(void)inquireNeedlistInfo{
    if (USERDEFINE.currentUser.Usermark==0) {
        AFHTTPRequestOperationManager *manager =
        [[AFHTTPRequestOperationManager alloc] init];
        //必须设置
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        [manager POST:PrivilegesURL
           parameters:nil
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  NSDictionary *responseDic = (NSDictionary *)responseObject;
                  NSString *str = [NSString
                                   stringWithFormat:@"%@", [responseDic valueForKey:@"code"]];
                  if ([str isEqualToString:@"200"]) {
                      self.DataArray = [NGGGoodsProperty mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                      kDISPATCH_MAIN_THREAD([self.tableView reloadData];);
                  }
              }
              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              }];
    }
    else{
        AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        [manager POST:RecommedURL parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            NSString*str=responseObject[@"message"];
            if ([str isEqualToString:@"查询成功！"]) {
                self.DataArray=[NGGGoodsAttribute mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                [self.tableView reloadData];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
        }];
    }
}

#pragma mark-发布按钮
-(void)AddRightPublishBtn{
    UIBarButtonItem*AddBtn=[[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(PublishBtnClick:)];
    [AddBtn setTintColor:NGGTheMeColor];
    self.navigationItem.rightBarButtonItem=AddBtn;
}

#pragma mark-供应事件
-(void)PublishBtnClick:(UIBarButtonItem*)sender{
    NGGGoodsClassifyMenuController* CalssifyMenu=[[NGGGoodsClassifyMenuController alloc]init];
    CalssifyMenu.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:CalssifyMenu animated:YES];
}

#pragma mark-注册自定义cell
-(void)registerCells{
    [self.tableView registerClass:[NGGHeadNewsViewCell class] forCellReuseIdentifier:NGGHeadNewsViewCellId];
    [self.tableView registerClass:[NGGGoodsViewCell class] forCellReuseIdentifier:NGGGoodsViewCellId];
    [self.tableView registerClass:[NGGChannelViewCell class] forCellReuseIdentifier:NGGChannelViewCellId];
    [self.tableView registerClass:[NGGToolViewCell class] forCellReuseIdentifier:NGGToolViewCellId];
  
    [self.tableView registerClass:[NGGHeadCell class]
           forCellReuseIdentifier:NGGHeadViewCellId];
    [self.tableView registerClass:[NGGFunctionViewCell class]
           forCellReuseIdentifier:NGGFunctionViewCellId];
    [self.tableView registerClass:[NGGGoodsClassViewCell class]
           forCellReuseIdentifier:NGGGoodsClassViewCellId];
    [self.tableView registerClass:[NGGGoodsTableViewCell class]
           forCellReuseIdentifier:NGGGoodsTableViewCellId];
}

#pragma mark- tableView的一些属性
-(void)SetTableViewAttri{
     /*tableview表头创建*/
    NSArray *arr = @[
                  [UIImage imageNamed:@"dazhaxie"],//本地图片，传image，不能传名称
                  [UIImage imageNamed:@"shucai"],
                  [UIImage imageNamed:@"shuidao"],
                  [UIImage imageNamed:@"shuiguo"],
                  [UIImage imageNamed:@"zoudiji"],
                  ];
    NGGSellerHomeHeaderView*header=[[NGGSellerHomeHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160)];
    [header setimageArray:arr];
    self.tableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160)];
    [self.tableView.tableHeaderView addSubview:header];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator=NO;
}

#pragma mark-创建搜索框
-(void)CreateSearchBar{
    UIView*titleView=[[UIView alloc]initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH-100, 28)];
    titleView.layer.cornerRadius=5;
    titleView.layer.masksToBounds=YES;
    
     /*创建一个搜索Button*/
    UIButton *SearButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, titleView.ngg_width, 28)];
    [SearButton setImage:[UIImage imageNamed:@"Search"] forState:UIControlStateNormal];
    [SearButton setImage:[UIImage imageNamed:@"Search"] forState:UIControlStateHighlighted];
    [SearButton addTarget:self action:@selector(SearButton:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:SearButton];
    [self.navigationItem.titleView sizeToFit];
    self.navigationItem.titleView=titleView;
}

#pragma mark-SearButton点击事件
-(void)SearButton:(UIButton*)sender{
    [NGGSearchView ShowSeatchView];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 2;
    }else if (section==1){
        return 1;
    }else{
        return self.DataArray.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0;
    }
    return 30;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            if (USERDEFINE.currentUser.Usermark==0) {
                NGGHeadCell *cell=[tableView dequeueReusableCellWithIdentifier:NGGHeadViewCellId];
              [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
              return cell;
            }
            NGGHeadNewsViewCell *cell=[tableView dequeueReusableCellWithIdentifier:NGGHeadNewsViewCellId];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell;
        }else{
            if (USERDEFINE.currentUser.Usermark==0) {
                return [tableView dequeueReusableCellWithIdentifier:NGGFunctionViewCellId];
            }
            return [tableView dequeueReusableCellWithIdentifier:NGGChannelViewCellId];
        }
    }else if (indexPath.section==1){
        if (USERDEFINE.currentUser.Usermark==0) {
            return [tableView dequeueReusableCellWithIdentifier:NGGGoodsClassViewCellId];
        }
        return [tableView dequeueReusableCellWithIdentifier:NGGToolViewCellId];
    }else{
        if (USERDEFINE.currentUser.Usermark==0) {
            NGGGoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NGGGoodsTableViewCellId];
            NGGGoodsProperty *Att = self.DataArray[indexPath.row];
            [cell initWithForm:Att];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell;
        }
        NGGGoodsViewCell*cell = [tableView dequeueReusableCellWithIdentifier:NGGGoodsViewCellId];
        NGGGoodsAttribute *Attribute=self.DataArray[indexPath.row];
        [cell initWithForm:Attribute];
        //设置cell被中的样式，这里让它没有变化
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==1) {
        UIView * bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        bgView.backgroundColor=NGGHomeBgColor;
        UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(12, 0, bgView.ngg_width/2, 25)];
        label.ngg_centerY=bgView.ngg_centerY;
        if (USERDEFINE.currentUser.Usermark==0) {
            label.text=@"货品分类";
        }else{
            label.text=@"应用工具";
        }
        [label setTextColor:[UIColor blackColor]];
        [bgView addSubview:label];
        return bgView;
    }else if(section==2){
        UIView * bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,30)];
        bgView.backgroundColor=NGGHomeBgColor;
        UILabel* label=[[UILabel alloc]initWithFrame:CGRectMake(12, 0, bgView.ngg_width/2, 25)];
        label.ngg_centerY=bgView.ngg_centerY;
        label.text=@"今日推荐";
        [label setTextColor:[UIColor blackColor]];
        [bgView addSubview:label];
        return bgView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return 50;
        }
        return 80;
    }else if (indexPath.section==2){
        if (USERDEFINE.currentUser.Usermark==0) {
            return 115;
        }
        return 150;
    }
    return 80;
}

#pragma mark-拖拽判断
/**
 *  刚开始拖拽
 */
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    contentOffsetY = scrollView.contentOffset.y;
}
/**
 *  手指离开屏幕后
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    newContentOffsetY= scrollView.contentOffset.y;
    if (scrollView.dragging) { // 拖拽
        if ((scrollView.contentOffset.y - contentOffsetY) > 5.0f) {  // 向上拖拽
            [NGGPublishSupply HiddenPublishView];
        }
        else if ((contentOffsetY - scrollView.contentOffset.y) > 5.0f)
        {   // 向下拖拽
            [NGGPublishSupply ShowPublishView];
        }
    }
}
// 完成拖拽(滚动停止时调用此方法，手指离开屏幕前)
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    oldContentOffsetY = scrollView.contentOffset.y;
    
}

-(void)viewWillAppear:(BOOL)animated{
   if (flg==USERDEFINE.currentUser.Usermark)  return;
    [self viewDidLoad];
}
@end
