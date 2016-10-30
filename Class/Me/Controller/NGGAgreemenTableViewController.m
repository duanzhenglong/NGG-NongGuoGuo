//
//  NGGAgreemenTableViewController.m
//  NGG-NongGuoGuo
//
//  Created by mac on 16/10/6.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGAgreemenTableViewController.h"

@interface NGGAgreemenTableViewController ()
@property(strong,nonatomic)NSArray *array;
@end

@implementation NGGAgreemenTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.title = @"农果果服务条款与协议";
    self.array = @[@"农果果服务条款与协议农果果服务条款与协议农果果服务条款与协议农果果服务条款与协议农果果服务条款与协议农果果服务条款与协议农果果服务条款与协议农果果服务条款与协议农果果服务条款与协议议农果果服务条款与协议农果果服务条议农果果服务条款与协议农果果服务条议农果果服务条款与协议农果果服务条议农果果果服务条议农果果服务条款与协议农果果服务条议农果果服务条款与协议农果果服务条议农果果服务条款与协议农果果服务条议农果果服务条款与协议农果果服务条议农果果服务条款与协议农果果服务条农果果服务条款与协议农果果服务条款与协议",@"农果果服务条款与协议农果果服务条款与协议农果果服务条款与协议农果果服务条款与协议农果果服务条款与协议农果果服务条款与协议农果果服务条款与协议农果果服务条款与协议农果果服务条款与协议农果果服务条款与协议农果果服务条款与协议",@"农果果服务条款与协议农果果服务条款与协议农果果服务条款与协议农果果服务条款与协议农果果服务条款与协议农果果服务条款与协议农果果服务条款与协议农果果服务条款与协议农果果服务条款与协议农果果服务条款与协议农果果服务条款与协议",@"农果果果果服务条款与协议农果果服务条款与协议农果果服务条款与协议农果果服务条款与协议农果果服务条款与协议"];
     
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell ==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    cell.textLabel.text = self.array[indexPath.row];
    cell.userInteractionEnabled = NO;
    cell.textLabel.numberOfLines = 0;
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellText = [self.array objectAtIndex:indexPath.row];
    UIFont *cellFont = [UIFont systemFontOfSize:14];
    CGSize constraintSize = CGSizeMake(self.view.frame.size.width, MAXFLOAT);
    
    NSDictionary *attribute = @{NSFontAttributeName: cellFont};
    CGSize labelSize = [cellText boundingRectWithSize:constraintSize options: NSStringDrawingTruncatesLastVisibleLine| NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    return labelSize.height + 88;
}
@end
