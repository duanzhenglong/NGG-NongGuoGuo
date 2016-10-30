//
//  NGGBuyerHomeViewController.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/9/29.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGBuyerHomeViewController.h"
#import "NGGFunctionViewCell.h"
#import "NGGGoodsClassViewCell.h"
#import "NGGGoodsTableViewCell.h"
#import "NGGHeadCell.h"
#import "NGGPublishSupply.h"
#import "NGGSellerHomeHeaderView.h"

#import "NGGTSearchView.h"

@interface NGGBuyerHomeViewController () {
  UIView *_headview;
  CGFloat contentOffsetY;
  CGFloat newContentOffsetY;
  CGFloat oldContentOffsetY;
}
@property (nonatomic, strong) NSArray *DataArray;

@end

@implementation NGGBuyerHomeViewController

/*声明cell ID*/
static NSString *const NGGHeadNewsViewCellId      = @"NGGHeadNewsViewCell";
static NSString *const NGGFunctionViewCellId      = @"NGGFunctionViewCell";
static NSString *const NGGGoodsClassViewCellId    = @"NGGGoodsClassViewCell";
static NSString *const NGGGoodsTableViewCellId = @"NGGGoodsTableViewCell";

- (void)viewDidLoad {
  [super viewDidLoad];
  /*头部轮播器方法*/
  [self createLocalScrollView];
  /*注册自定义cell*/
  [self registerCells];
  /*获取网络数据*/
  [self requestPrivileges];
     /***创建搜索框***/
  [self CreateSearchBar];
}

- (void)createLocalScrollView {
      /*初始化数组*/
      self.DataArray = [[NSArray alloc] init];
      /*tableview表头创建*/
      self.tableView.tableHeaderView=[[NGGSellerHomeHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 160)];
      /*给tableView添加颜色*/
      self.tableView.backgroundColor = NGGCommonBgColor;
      /*禁止垂直滚动*/
      self.tableView.showsVerticalScrollIndicator = NO;
      self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
     /***创建导航栏上买家卖家的标识***/
//    UIButton*btn=[UIButton buttonWithType:UIButtonTypeCustom];
//    [btn setBackgroundImage:[UIImage imageNamed:@"mai"] forState:UIControlStateNormal];
//    [btn sizeToFit];
//    UIBarButtonItem*byerBtn=[[UIBarButtonItem alloc]initWithCustomView:btn];
//    self.navigationItem.leftBarButtonItem=byerBtn;
}


#pragma mark-创建搜索框
-(void)CreateSearchBar{
    UIView*titleView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-100, 28)];
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
    [NGGTSearchView ShowSeatchView];
}

#pragma mark -注册自定义cell
- (void)registerCells {
  [self.tableView registerClass:[NGGHeadCell class]
         forCellReuseIdentifier:NGGHeadNewsViewCellId];
  [self.tableView registerClass:[NGGFunctionViewCell class]
         forCellReuseIdentifier:NGGFunctionViewCellId];
  [self.tableView registerClass:[NGGGoodsClassViewCell class]
         forCellReuseIdentifier:NGGGoodsClassViewCellId];
  [self.tableView registerClass:[NGGGoodsTableViewCell class]
         forCellReuseIdentifier:NGGGoodsTableViewCellId];
}

//获取网络数据进行解析
- (void)requestPrivileges {
   
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
            self.DataArray = [NGGGoodsProperty
                mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
              kDISPATCH_MAIN_THREAD([self.tableView reloadData];);
          }
      }
      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
      }];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 3;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  if (section == 0) {
    return 2;
  } else if (section == 1) {
    return 1;
  } else {
    return self.DataArray.count;
  }
}

- (CGFloat)tableView:(UITableView *)tableView
    heightForHeaderInSection:(NSInteger)section {
  if (section == 0) {
    return 0;
  }
  return 35;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 0) {
    if (indexPath.row == 0) {
      return
          [tableView dequeueReusableCellWithIdentifier:NGGHeadNewsViewCellId] ;
    } else {
      return
          [tableView dequeueReusableCellWithIdentifier:NGGFunctionViewCellId];
    }
  } else if (indexPath.section == 1) {
    return
        [tableView dequeueReusableCellWithIdentifier:NGGGoodsClassViewCellId];
  } else {
      NGGGoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NGGGoodsTableViewCellId];
      NGGGoodsProperty *Att = self.DataArray[indexPath.row];
      [cell initWithForm:Att];
      [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
      return cell;
  }
}

- (UIView *)tableView:(UITableView *)tableView
    viewForHeaderInSection:(NSInteger)section {
  if (section == 1) {
    UIView *bgView =
        [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
    bgView.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc]
        initWithFrame:CGRectMake(12, 0, bgView.ngg_width / 2, 25)];
    label.ngg_centerY = bgView.ngg_centerY;
    label.text = @"货品分类";
    [label setTextColor:[UIColor blackColor]];
    [bgView addSubview:label];
    return bgView;
  } else if (section == 2) {
    UIView *bgView =
        [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
    bgView.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc]
        initWithFrame:CGRectMake(12, 0, bgView.ngg_width / 2, 25)];
    label.ngg_centerY = bgView.ngg_centerY;
    label.text = @"今日推荐";
    [label setTextColor:[UIColor blackColor]];
    [bgView addSubview:label];

    UIButton *refreshBtn =
        [UIButton buttonWithType:UIButtonTypeCustom];
    refreshBtn.frame = CGRectMake(SCREEN_WIDTH -90, 0, 80, 30);
    [refreshBtn setTitle:@"换一批" forState:UIControlStateNormal];
    [refreshBtn.titleLabel setFont:[UIFont systemFontOfSize:14 weight:1]];
    [refreshBtn setTitleColor:NGGTheMeColor forState:UIControlStateNormal];
    [refreshBtn addTarget:self
                   action:@selector(refreshBtnClick)
         forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:refreshBtn];

    return bgView;
  }
  return nil;
}

- (void)refreshBtnClick {
  NGGLogFunc;
}

- (CGFloat)tableView:(UITableView *)tableView
    heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 0) {
    if (indexPath.row == 0) {
      return 50;
    }
    return 80;
  } else if (indexPath.section == 2) {
    return 120;
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
    UITabBarController*tabbar=(UITabBarController *)self.parentViewController.parentViewController.parentViewController;
        if (tabbar.tabBar.hidden==YES) {
        tabbar.tabBar.hidden=NO;
        }
}

@end
