//
//  NGGDetailedInfo.m
//  NGG-NongGuoGuo
//
//  Created by mac on 16/10/9.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGDetailedInfo.h"
#import "UIScrollView+HeaderScaleImage.h"
#import "UIView+NGGExtension.h"

#import "TableViewCell.h"
@interface NGGDetailedInfo ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableViewDetailed;
    NSArray *arrayLabel;//标签
    UIImageView *headerImg;//头像
    UILabel *jobLab;//职业
}
@end

@implementation NGGDetailedInfo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人详细信息";
    tableViewDetailed = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:tableViewDetailed];
    tableViewDetailed.delegate = self;
    tableViewDetailed.dataSource = self;
    
    
    tableViewDetailed.yz_headerScaleImage = [UIImage imageNamed:@"yi.png"];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0,tableViewDetailed.frame.size.width, 150)];
    [tableViewDetailed addSubview: view];
    headerImg  = [[UIImageView alloc]initWithFrame:CGRectMake(view.frame.size.width/2-view.frame.size.height/4-10, view.frame.size.height/4, view.frame.size.height/2, view.frame.size.height/2)];
    headerImg.image = [UIImage imageNamed:@"dongman.jpg"];
    headerImg.layer.cornerRadius = headerImg.frame.size.width/2;
    headerImg.layer.masksToBounds = YES;
    [view addSubview:headerImg];
    jobLab =[[UILabel alloc]initWithFrame:CGRectMake(40, headerImg.ngg_bottom, view.ngg_width-80, 36)];
    //[jobLab setBackgroundColor:[UIColor redColor]];
    jobLab.textAlignment= NSTextAlignmentCenter;
    
//    if (jobLab.text) {
//        //jobLab.text =
//    }else{
        jobLab.text = @"该用户还未选择职业";
        [jobLab setTextColor:NGGColorA(220, 220, 220, 255)];
//    }
    
    [view addSubview:jobLab];
    arrayLabel  = @[@"姓名",@"手机号",@"店铺",@"联系地址"];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrayLabel.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    //自定义cell类
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[TableViewCell alloc] initWithReuseIdentifier:CellIdentifier];
    }
    
    cell.descLable.text = arrayLabel[indexPath.row];
    if (indexPath.row==0) {
        cell.userInteractionEnabled = NO;
        //姓名
       // cell.infoLable.text =
        
    }else if (indexPath.row==1){
        cell.userInteractionEnabled = NO;
        //手机号
        // cell.infoLable.text =
    }else if (indexPath.row==2){
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        //店铺
        // cell.infoLable.text =
    }else if (indexPath.row==3){
        cell.userInteractionEnabled = NO;
        //联系地址
         cell.infoLable.text =@"江苏省苏州市吴中区";
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 160.0f;
    }
    else{
        return 0.1f;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableViewDetailed deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==2) {
        NGGLog(@"进入我的店铺");
    }
}
@end
