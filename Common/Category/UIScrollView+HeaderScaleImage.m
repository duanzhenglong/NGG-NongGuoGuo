//
//  UIScrollView+NGGHeaderTableViewImage.m
//  NGG-NongGuoGuo
//
//  Created by mac on 16/9/29.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "UIScrollView+HeaderScaleImage.h"

#import <objc/runtime.h>

#define YZKeyPath(objc,keyPath) @(((void)objc.keyPath,#keyPath))

@interface NSObject (MethodSwizzling)

/** 交换对象方法*/
+ (void)yz_swizzleInstanceSelector:(SEL)origSelector
                   swizzleSelector:(SEL)swizzleSelector;

/**交换类方法*/
+ (void)yz_swizzleClassSelector:(SEL)origSelector
                swizzleSelector:(SEL)swizzleSelector;

@end

@implementation NSObject (MethodSwizzling)

+ (void)yz_swizzleInstanceSelector:(SEL)origSelector swizzleSelector:(SEL)swizzleSelector {
    
    // 获取原有方法
    Method origMethod = class_getInstanceMethod(self,origSelector);
    // 获取交换方法
    Method swizzleMethod = class_getInstanceMethod(self,swizzleSelector);
    // 添加原有方法实现为当前方法实现
    BOOL isAdd = class_addMethod(self, origSelector, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
    // 添加方法失败，表示原有方法存在，直接替换
    if (!isAdd) {
        method_exchangeImplementations(origMethod, swizzleMethod);
    }
}

+ (void)yz_swizzleClassSelector:(SEL)origSelector swizzleSelector:(SEL)swizzleSelector
{
    // 获取原有方法
    Method origMethod = class_getClassMethod(self,origSelector);
    // 获取交换方法
    Method swizzleMethod = class_getClassMethod(self,swizzleSelector);
    // 添加原有方法实现为当前方法实现
    BOOL isAdd = class_addMethod(self, origSelector, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
     // 添加方法失败，原有方法存在，直接替换
    if (!isAdd) {
        method_exchangeImplementations(origMethod, swizzleMethod);
    }
}

@end

//值可以改变，指向不能变
static char * const headerImageViewKey = "headerImageViewKey";
static char * const headerImageViewHeight = "headerImageViewHeight";
static char * const isInitialKey = "isInitialKey";

// 默认图片高度
static CGFloat const oriImageH = 150;


@implementation UIScrollView (HeaderScaleImage)

+ (void)load
{
    [self yz_swizzleInstanceSelector:@selector(setTableHeaderView:) swizzleSelector:@selector(setYz_TableHeaderView:)];
}

// 拦截通过代码设置tableView头部视图
- (void)setYz_TableHeaderView:(UIView *)tableHeaderView
{
    // 不是UITableView,就不需要做下面的事情
    if (![self isMemberOfClass:[UITableView class]]) return;
    // 设置tableView头部视图
    [self setYz_TableHeaderView:tableHeaderView];
    // 设置头部视图的位置
    UITableView *tableView = (UITableView *)self;
    self.yz_headerScaleImageHeight = tableView.tableHeaderView.frame.size.height;
    
}

// 懒加载头部imageView
- (UIImageView *)yz_headerImageView
{
    UIImageView *imageView = objc_getAssociatedObject(self, headerImageViewKey);
    if (imageView == nil) {
        imageView = [[UIImageView alloc] init];
        imageView.clipsToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self insertSubview:imageView atIndex:0];
        // 保存imageView
        objc_setAssociatedObject(self, headerImageViewKey, imageView,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return imageView;
}

// 属性：yz_isInitial
- (BOOL)yz_isInitial
{
    return [objc_getAssociatedObject(self, isInitialKey) boolValue];
}

- (void)setYz_isInitial:(BOOL)yz_isInitial
{
    objc_setAssociatedObject(self, isInitialKey, @(yz_isInitial),OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// 属性： yz_headerImageViewHeight
- (void)setYz_headerScaleImageHeight:(CGFloat)yz_headerScaleImageHeight
{
    objc_setAssociatedObject(self, headerImageViewHeight, @(yz_headerScaleImageHeight),OBJC_ASSOCIATION_COPY_NONATOMIC);
    // 设置头部视图的位置
    [self setupHeaderImageViewFrame];
}

- (CGFloat)yz_headerScaleImageHeight
{
    CGFloat headerImageHeight = [objc_getAssociatedObject(self, headerImageViewHeight) floatValue];
    return headerImageHeight == 0?oriImageH:headerImageHeight;
}

// 属性：yz_headerImage
- (UIImage *)yz_headerScaleImage
{
    return self.yz_headerImageView.image;
}

// 设置头部imageView的图片
- (void)setYz_headerScaleImage:(UIImage *)yz_headerScaleImage
{
    self.yz_headerImageView.image = yz_headerScaleImage;
    // 初始化头部视图
    [self setupHeaderImageView];

}

// 设置头部视图的位置
- (void)setupHeaderImageViewFrame
{
    self.yz_headerImageView.frame = CGRectMake(0 , 0, self.bounds.size.width , self.yz_headerScaleImageHeight);
    
}

// 初始化头部视图
- (void)setupHeaderImageView
{
    // 设置头部视图的位置
    [self setupHeaderImageViewFrame];
    // KVO监听偏移量，修改头部imageView的frame
    if (self.yz_isInitial == NO) {
        [self addObserver:self forKeyPath:YZKeyPath(self, contentOffset) options:NSKeyValueObservingOptionNew context:nil];
        self.yz_isInitial = YES;
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    // 获取当前偏移量
    CGFloat offsetY = self.contentOffset.y;
    if (offsetY < 0) {
        self.yz_headerImageView.frame = CGRectMake(offsetY, offsetY, self.bounds.size.width - offsetY * 2, self.yz_headerScaleImageHeight - offsetY);
        
    } else {
        
        self.yz_headerImageView.frame = CGRectMake(0, 0, self.bounds.size.width, self.yz_headerScaleImageHeight);
    }
    
}
- (void)dealloc
{
    if (self.yz_isInitial) {
        [self removeObserver:self forKeyPath:YZKeyPath(self, contentOffset)];
        
    }
    
}

@end


