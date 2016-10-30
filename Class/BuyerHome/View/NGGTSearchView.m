//
//  NGGTSearchView.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/10/17.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGTSearchView.h"
#import "NGGGoodsViewCell.h"
#import "NGGFuzzyQuery.h"
#import "NGGGoodsTableViewCell.h"
@interface NGGTSearchView()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>{
    UISearchBar *SearchBar;
}
@property(nonatomic,strong)UITableView*tavleview;
@property(nonatomic,strong)NSArray *DataArray;
@end

@implementation NGGTSearchView

static NGGTSearchView *SearchView;
/**
 *显示搜索界面
 */
+(void)ShowSeatchView{
    if (!SearchView) {
        UIWindow *window=[UIApplication sharedApplication].keyWindow;
        SearchView=[[NGGTSearchView alloc]initWithFrame:CGRectMake(0, 0, window.ngg_width, window.ngg_height)];
        SearchView.alpha=0;
        [UIView animateWithDuration:0.5 animations:^{
            SearchView.hidden=NO;
            SearchView.alpha=1;
            [window addSubview:SearchView];
            [SearchView viewDidLoad];
        }];
    }
}
/**
 *隐藏搜索界面
 */
+(void)HiddenSeatchView{
    [UIView animateWithDuration:0.5 animations:^{
        SearchView.alpha=0;
    } completion:^(BOOL finished) {
        SearchView.hidden=YES;
    }];
    SearchView=nil;
}
/**
 *  加载页面
 */
- (void)viewDidLoad{
    self.tavleview=[[UITableView alloc]initWithFrame:CGRectMake(0, 20, self.ngg_width, self.ngg_height)];
    /**
     *  self.tavleview属性设置
     */
    [self addSubview:self.tavleview];
    self.tavleview.delegate=self;
    self.tavleview.dataSource=self;
    self.tavleview.backgroundColor=NGGCommonBgColor;
    self.tavleview.showsVerticalScrollIndicator=NO;
    self.tavleview.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    self.tavleview.contentInset=UIEdgeInsetsMake(44, 0, 0, 0);
    /*创建搜索框*/
    [self CreateSearchBar];
    
    /*初始化数据*/
    self.DataArray=[NSArray array];
}

#pragma mark-tableView协议
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.DataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NGGGoodsTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[NGGGoodsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    NGGGoodsProperty *Attribute=self.DataArray[indexPath.row];
    [cell initWithForm:Attribute];
    /*设置cell被中的样式，这里让它没有变化*/
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

#pragma mark-创建搜索框
-(void)CreateSearchBar{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 44)];
    view.backgroundColor=[UIColor whiteColor];
    [SearchView addSubview:view];
    
    SearchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(30, 0, SCREEN_WIDTH-100, 30)];
    SearchBar.ngg_centerY=22;
    SearchBar.delegate=self;
    SearchBar.placeholder = @"|搜索你想要的东西";
    SearchBar.tintColor=[UIColor darkGrayColor];//改变光标的颜色
    SearchBar.searchBarStyle=UISearchBarStyleMinimal;
    [SearchBar becomeFirstResponder];
    [view addSubview:SearchBar];
    
    UIButton*CancelBtn=[[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-55, 0, 45, 25)];
    CancelBtn.ngg_centerY=22;
    [CancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [CancelBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [CancelBtn.titleLabel setFont:[UIFont systemFontOfSize:17 weight:1]];
    [CancelBtn addTarget:self action:@selector(CancelSearchClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:CancelBtn];
}

#pragma mark-searchBar协议
/*当搜索栏内容改变时调用*/
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    self.DataArray=nil;
    [self.tavleview reloadData];
    /***模糊查询数据返回***/
    NSString*str=[NSString stringWithFormat:@"%d",[NGGFuzzyQuery FuzzyQuery:searchText]];
    
    NSDictionary *myParameters = @{
                                   @"goodsid":str
                                   };
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:GoodsIdSupplylistURL parameters:myParameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString*str=responseObject[@"message"];
        if ([str isEqualToString:@"查询成功！"]) {
            self.DataArray=[NGGGoodsProperty mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self.tavleview reloadData];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}

#pragma mark-取消搜索
-(void)CancelSearchClick:(UIButton*)sender{
    [NGGTSearchView HiddenSeatchView];
    [SearchBar resignFirstResponder];
}


@end
