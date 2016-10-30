//
//  NGGScrollView.h
//  NGG-NongGuoGuo
//
//  Created by Agan on 16/10/8.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import <UIKit/UIKit.h>
/** 遵循该代理就可以监控到网络滚动视图的index*/

@protocol WYScrollViewNetDelegate <NSObject>

@optional

/** 点中网络滚动视图后触发*/
- (void)didSelectedNetImageAtIndex:(NSInteger)index;

@end

/** 遵循该代理就可以监控到本地滚动视图的index*/

@protocol WYScrollViewLocalDelegate <NSObject>

@optional

/** 点中本地滚动视图后触发*/
- (void)didSelectedLocalImageAtIndex:(NSInteger)index;

@end

@interface NGGScrollView : UIView

/** 选中本地图片的索引*/
@property(nonatomic, strong) id<WYScrollViewLocalDelegate> localDelagate;

/** 占位图*/
@property(nonatomic, strong) UIImage *placeholderImage;

/** 滚动延时*/
@property(nonatomic, assign) NSTimeInterval AutoScrollDelay;

/**
 *  本地图片
 *
 *  @param frame      位置
 *  @param imageArray 加载本地图片
 *
 *  @return
 */
- (instancetype)initWithFrame:(CGRect)frame
              WithLocalImages:(NSArray *)imageArray;

@end
