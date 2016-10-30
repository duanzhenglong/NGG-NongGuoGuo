//
//  NGGInfoViewController.m
//  NGG-NongGuoGuo
//
//  Created by mac on 16/10/11.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGInfoViewController.h"
#import "NGGInfoCell.h"
@interface NGGInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) UITableView *tableView;

@end

@implementation NGGInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"通知";
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    NGGInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell == nil) {
        cell = [[NGGInfoCell alloc]initWithReuseIdentifier:@"cellID"];
    }
    cell.offeruserName.text = @"梁立";
    
    cell.offerPriceTime.text = @"2016-10-11";
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NGGLog(@"%ld",indexPath.section);
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NGGInfoCell *cell = [[NGGInfoCell alloc]initWithReuseIdentifier:@"cellID"];
    return cell.frame.size.height;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 4.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 4.0f;
}
@end
