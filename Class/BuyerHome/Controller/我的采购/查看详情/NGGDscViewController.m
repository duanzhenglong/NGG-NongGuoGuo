
//
//  NGGDscViewController.m
//  NGG-NongGuoGuo
//
//  Created by Agan on 16/10/10.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGDscViewController.h"
#import "NGGOneViewCell.h"
#import "NGGThreeViewCell.h"
#import "NGGTwoViewCell.h"
@interface NGGDscViewController () <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *mainTableView;

@property(strong, nonatomic) NSArray *DataArray;

@end

@implementation NGGDscViewController
/*声明cell ID*/
static NSString *const NGGOneViewCellId = @"NGGOneViewCell";
static NSString *const NGGTwoViewCellId = @"NGGTwoViewCell";
static NSString *const NGGThreeViewCellId = @"NGGThreeViewCell";

- (void)viewDidLoad {
  [super viewDidLoad];

  /*标题*/
  self.navigationItem.title = @"采购详情";
  /*创建MainTableView*/
  [self createTableView];
  /*注册cell*/
  [self registerCells];
  /*网络数据请求*/
}

/*创建mainTableView*/
- (void)createTableView {

  self.mainTableView = [[UITableView alloc]
      initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
  [self.view addSubview:self.mainTableView];
  self.mainTableView.delegate = self;
  self.mainTableView.dataSource = self;
  self.mainTableView.showsVerticalScrollIndicator = NO;
  self.mainTableView.backgroundColor = NGGCommonBgColor;
}

- (void)registerCells {
  [self.mainTableView registerClass:[NGGOneViewCell class]
             forCellReuseIdentifier:NGGOneViewCellId];
  [self.mainTableView registerClass:[NGGTwoViewCell class]
             forCellReuseIdentifier:NGGTwoViewCellId];
  [self.mainTableView registerClass:[NGGThreeViewCell class]
             forCellReuseIdentifier:NGGThreeViewCellId];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 3;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  if (section == 0) {
    return 1;
  } else if (section == 1) {
    return 1;
  } else {
    return 1;
  }
}

- (CGFloat)tableView:(UITableView *)tableView
    heightForHeaderInSection:(NSInteger)section {
  if (section == 0) {
    return 0;
  } else if (section == 1) {
    return 2;
  }
  return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 0) {
    return [tableView dequeueReusableCellWithIdentifier:NGGOneViewCellId];
  } else if (indexPath.section == 1) {
    NGGTwoViewCell *cell =
        [tableView dequeueReusableCellWithIdentifier:NGGTwoViewCellId];

    [cell initWithForm:self.Attribute];

    return cell;

  } else {
    NGGThreeViewCell *cell =
        [tableView dequeueReusableCellWithIdentifier:NGGThreeViewCellId];

    [cell initWithForm:self.Attribute];

    return cell;
  }
}

- (UIView *)tableView:(UITableView *)tableView
    viewForHeaderInSection:(NSInteger)section {
  if (section == 2) {
    UIView *bgView =
        [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];

    UILabel *label = [[UILabel alloc]
        initWithFrame:CGRectMake(12, 0, bgView.ngg_width / 2, 25)];
    label.ngg_centerY = bgView.ngg_centerY;
    label.text = @"补充";
    [label setTextColor:[UIColor blackColor]];
    [bgView addSubview:label];
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
    return 50;
  } else if (indexPath.section == 1) {
    return 230;
  } else {
    return 150;
  }
}

@end
