//
//  NGGChatViewController.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/9/29.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGChatViewController.h"
#import "NGGCertificationViewController.h"
#import "NGGMyCollectController.h"
@interface NGGChatViewController ()

@end

@implementation NGGChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        static NSString* CellID=@"CellId";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellID];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
        }
        cell.textLabel.text=@"实名认证";
        return cell;
    }else{
        static NSString* CellID=@"CellId";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellID];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
        }
        cell.textLabel.text=@"我的收藏";
        return cell;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        NGGCertificationViewController*cer=[[NGGCertificationViewController alloc]init];
        [self.navigationController pushViewController:cer animated:YES];
    }else{
        NGGMyCollectController*cer=[[NGGMyCollectController alloc]init];
        [self.navigationController pushViewController:cer animated:YES];
    }
}
@end
