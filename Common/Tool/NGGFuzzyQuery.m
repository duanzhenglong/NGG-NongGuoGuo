//
//  NGGFuzzyQuery.m
//  NGG-NongGuoGuo
//
//  Created by administrator on 16/10/15.
//  Copyright © 2016年 duanzhenglong&ganguijun&xuliangli. All rights reserved.
//

#import "NGGFuzzyQuery.h"

@implementation NGGFuzzyQuery

+(int)FuzzyQuery:(NSString*)string{
    if ([string containsString:@"苹果"]) {
        return 1;
    }
    if ([string containsString:@"梨"]) {
        return 2;
    }
    if ([string containsString:@"香蕉"]) {
        return 3;
    }
    if ([string containsString:@"西瓜"]) {
        return 4;
    }
    if ([string containsString:@"芒果"]) {
        return 5;
    }
    if ([string containsString:@"橙子"]) {
        return 6;
    }
    if ([string containsString:@"甘蔗"]) {
        return 7;
    }
    if ([string containsString:@"榴莲"]) {
        return 8;
    }
    if ([string containsString:@"毛桃"]) {
        return 9;
    }
    if ([string containsString:@"草莓"]) {
        return 10;
    }
    if ([string containsString:@"奇异果"]) {
        return 11;
    }
    if ([string containsString:@"菠萝"]) {
        return 12;
    }
    if ([string containsString:@"人参果"]) {
        return 13;
    }if ([string containsString:@"石榴"]) {
        return 14;
    }
    if ([string containsString:@"蜜桔"]) {
        return 15;
    }
    if ([string containsString:@"琵琶"]) {
        return 16;
    }if ([string containsString:@"哈密瓜"]) {
        return 17;
    }if ([string containsString:@"葡萄"]) {
        return 18;
    }if ([string containsString:@"龙眼"]) {
        return 19;
    }if ([string containsString:@"荔枝"]) {
        return 20;
    }if ([string containsString:@"甘蓝"]) {
        return 21;
    }
    if ([string containsString:@"茄子"]) {
        return 22;
    }
    if ([string containsString:@"豆芽"]) {
        return 23;
    }
    if ([string containsString:@"生菜"]) {
        return 24;
    }
    if ([string containsString:@"苦瓜"]) {
        return 25;
    }
    if ([string containsString:@"油麦菜"]) {
        return 26;
    }
    if ([string containsString:@"黄瓜"]) {
        return 27;
    }
    if ([string containsString:@"竹笋"]) {
        return 28;
    }
    if ([string containsString:@"西红柿"]) {
        return 29;
    }
    if ([string containsString:@"豆角"]) {
        return 30;
    }
    if ([string containsString:@"莲藕"]) {
        return 31;
    }
    if ([string containsString:@"萝卜"]) {
        return 32;
    }
    if ([string containsString:@"冬瓜"]) {
        return 33;
    }
    if ([string containsString:@"菜心"]) {
        return 34;
    }
    if ([string containsString:@"苹果"]) {
        return 35;
    }
    if ([string containsString:@"苦苣"]) {
        return 36;
    }
    if ([string containsString:@"黄花菜"]) {
        return 37;
    }
    if ([string containsString:@"甜瓜"]) {
        return 38;
    }
    if ([string containsString:@"芹菜"]) {
        return 39;
    }
    if ([string containsString:@"娃娃菜"]) {
        return 40;
    }
    if ([string containsString:@"亚麻籽"]) {
        return 41;
    }
    if ([string containsString:@"小扁豆"]) {
        return 42;
    }
    if ([string containsString:@"白豆"]) {
        return 43;
    }
    if ([string containsString:@"大豆"]) {
        return 44;
    }
    if ([string containsString:@"黑豆"]) {
        return 45;
    }
    if ([string containsString:@"油豆"]) {
        return 46;
    }
    if ([string containsString:@"红豆"]) {
        return 47;
    }
    if ([string containsString:@"绿豆"]) {
        return 48;
    }
    if ([string containsString:@"蚕豆"]) {
        return 49;
    }
    if ([string containsString:@"葵花"]) {
        return 50;
    }
    if ([string containsString:@"油瓜"]) {
        return 51;
    }
    if ([string containsString:@"乌米"]) {
        return 52;
    }
    if ([string containsString:@"稻谷"]) {
        return 53;
    }
    if ([string containsString:@"谷子"]) {
        return 54;
    }
    if ([string containsString:@"玉米"]) {
        return 55;
    }
    if ([string containsString:@"小麦"]) {
        return 56;
    }
    if ([string containsString:@"油棕"]) {
        return 57;
    }
    if ([string containsString:@"油菜籽"]) {
        return 58;
    }
    if ([string containsString:@"花生油"]) {
        return 59;
    }
    if ([string containsString:@"黄豆"]) {
        return 60;
    }
    if ([string containsString:@"鲈鱼"]) {
        return 61;
    }
    if ([string containsString:@"柴鱼"]) {
        return 62;
    }
    if ([string containsString:@"扇贝"]) {
        return 63;
    }if ([string containsString:@"生蚝"]) {
        return 64;
    }
    if ([string containsString:@"鳌"]) {
        return 65;
    }
    if ([string containsString:@"龙虾"]) {
        return 66;
    }if ([string containsString:@"章鱼"]) {
        return 67;
    }if ([string containsString:@"青鱼"]) {
        return 68;
    }if ([string containsString:@"鲤鱼"]) {
        return 69;
    }if ([string containsString:@"鲫鱼"]) {
        return 70;
    }if ([string containsString:@"泥鳅"]) {
        return 71;
    }
    if ([string containsString:@"黄鳝"]) {
        return 72;
    }
    if ([string containsString:@"秋刀鱼"]) {
        return 73;
    }
    if ([string containsString:@"乌龟"]) {
        return 74;
    }
    if ([string containsString:@"黄花鱼"]) {
        return 75;
    }
    if ([string containsString:@"帝王蟹"]) {
        return 76;
    }
    if ([string containsString:@"水母"]) {
        return 77;
    }
    if ([string containsString:@"鱿鱼"]) {
        return 78;
    }
    if ([string containsString:@"濑尿虾"]) {
        return 79;
    }
    if ([string containsString:@"螃蟹"]) {
        return 80;
    }
    if ([string containsString:@"羊杂"]) {
        return 81;
    }
    if ([string containsString:@"鸽子肉"]) {
        return 82;
    }
    if ([string containsString:@"鹿肉"]) {
        return 83;
    }
    if ([string containsString:@"鸵鸟肉"]) {
        return 84;
    }
    if ([string containsString:@"火鸡肉"]) {
        return 85;
    }
    if ([string containsString:@"排骨"]) {
        return 86;
    }
    if ([string containsString:@"猪排"]) {
        return 87;
    }
    if ([string containsString:@"羊排"]) {
        return 88;
    }
    if ([string containsString:@"鸭排"]) {
        return 89;
    }
    if ([string containsString:@"鸡排"]) {
        return 90;
    }
    if ([string containsString:@"驴肉"]) {
        return 91;
    }
    if ([string containsString:@"猪鼻子"]) {
        return 92;
    }
    if ([string containsString:@"鹅肉"]) {
        return 93;
    }
    if ([string containsString:@"鸭肉"]) {
        return 94;
    }
    if ([string containsString:@"马肉"]) {
        return 95;
    }
    if ([string containsString:@"狗肉"]) {
        return 96;
    }
    if ([string containsString:@"羊肉"]) {
        return 97;
    }
    if ([string containsString:@"鸡肉"]) {
        return 98;
    }
    if ([string containsString:@"猪肉"]) {
        return 99;
    }
    if ([string containsString:@"牛肉"]) {
        return 100;
    }
    
    return 0;
}

@end
