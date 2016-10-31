//
//  NGGMyPurchaseViewController.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/10/31.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGMyPurchaseViewController.h"
#import "NGGPurchaseViewController.h"
#import "NGGPurchaseOrderController.h"
@interface NGGMyPurchaseViewController ()

@end

@implementation NGGMyPurchaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor=NGGCommonBgColor;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.navigationItem.title=@"我的采购";
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* CellID=@"CellId";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font=[UIFont systemFontOfSize:17];
    
    if (indexPath.row==0) {
        cell.textLabel.text=@"我发布的采购";
        /***下画线***/
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, cell.ngg_bottom+5, SCREEN_WIDTH, 0.5)];
        view.backgroundColor=NGGCutLineColor;
        [cell addSubview:view];
    }else{
        cell.textLabel.text=@"我的采购订单";
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==0) {
        NGGPurchaseViewController *purchase=[[NGGPurchaseViewController alloc]init];
        [self.navigationController pushViewController:purchase animated:YES];
    }else{
        NGGPurchaseOrderController*order=[[NGGPurchaseOrderController alloc]init];
        [self.navigationController pushViewController:order animated:YES];
    }
   
    
}
@end
