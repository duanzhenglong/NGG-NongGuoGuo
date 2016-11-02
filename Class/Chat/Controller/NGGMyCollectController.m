//
//  NGGMyCollectController.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/11/2.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGMyCollectController.h"
#import "NGGGoodsTableViewCell.h"
#import "NGGRefreshHeader.h"
#import "NGGGoodsViewCell.h"
@interface NGGMyCollectController ()

@property(strong, nonatomic) NSArray *DataArray;

@end

@implementation NGGMyCollectController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createInitDate];
}

- (void)createInitDate {
    
    self.navigationItem.title = @"我的收藏";
    self.tableView.backgroundColor = NGGCommonBgColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    /*初始化数据*/
    self.DataArray = [[NSArray alloc] init];
    self.tableView.mj_header=[NGGRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestSupply)];
    [self.tableView.mj_header beginRefreshing];

}

//获取网络数据进行解析
- (void)requestSupply {
    NSDictionary*dic=@{@"userid":@(USERDEFINE.currentUser.userId)};
    NSString*url=[[NSString alloc]init];
    if (USERDEFINE.currentUser.Usermark==0) {
        //买家收藏
        url=MycollectgoodsURL;
    }else{
        url=sMycollectgoodsURL;
    }
    AFHTTPRequestOperationManager *manager =
    [[AFHTTPRequestOperationManager alloc] init];
    //必须设置
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:url
       parameters:dic
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if (USERDEFINE.currentUser.Usermark==0){
                  self.DataArray = [NGGGoodsProperty
                                    mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
              }else{
                  self.DataArray = [NGGGoodsAttribute
                                    mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
              }
              [self.tableView reloadData];
              [self.tableView.mj_header endRefreshing];
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
               [self.tableView.mj_header endRefreshing];
          }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return self.DataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (USERDEFINE.currentUser.Usermark==0) {
        static NSString *ID = @"cellID";
        NGGGoodsTableViewCell *cell =
        [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[NGGGoodsTableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier:ID];
        }
        NGGGoodsProperty *Attribute = self.DataArray[indexPath.row];
        [cell initWithForm:Attribute];
        /*设置cell被中的样式，这里让它没有变化*/
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }else{
        static NSString *ID = @"celliD";
        NGGGoodsViewCell *cell =
        [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[NGGGoodsViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier:ID];
        }
        NGGGoodsAttribute *Attribute = self.DataArray[indexPath.row];
        [cell initWithForm:Attribute];
        /*设置cell被中的样式，这里让它没有变化*/
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 删除模型
//    [self.DataArray removeObjectAtIndex:indexPath.row];
    
    // 刷新
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (USERDEFINE.currentUser.Usermark==0) {
        return 115;
    }
    return 145;
}

@end
