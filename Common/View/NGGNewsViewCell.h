//
//  NGGNewsViewCell.h
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/10/9.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NGGNewsViewCell : UITableViewCell
/*标题*/
@property (strong, nonatomic) UILabel*TitleLabel;
/*内容*/
@property (strong, nonatomic) NSString*ConentURL;
/*发布时间*/
@property (strong, nonatomic) UILabel*TimeLabel;
/*图片*/
@property (strong, nonatomic) UIImageView* Imageview;
 /*赋值*/
-(void)initWithForm:(NSDictionary*)dic;
@end
