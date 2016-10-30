//
//  ChinaArea.m
//  addressChoose
//
//  Created by mac on 16/10/10.
//  Copyright © 2016年 xll. All rights reserved.
//

#import "ChinaArea.h"

@interface ChinaArea ()

@property (nonatomic,strong)FMDatabaseQueue *fmdbQueue;
@property (nonatomic,strong)FMDatabase *dataBase;
@property (nonatomic,copy)NSString *dbPath;
@end

@implementation ChinaArea

- (instancetype)init{
    if (self = [super init]) {
        [self initDataBase];
    }
    return self;
}

// 初始化数据库
- (void)initDataBase{
    self.dbPath=[[NSBundle mainBundle]pathForResource:@"china_citys_name.db" ofType:nil];
    self.fmdbQueue = [[FMDatabaseQueue alloc] initWithPath:self.dbPath];
    self.dataBase = [[FMDatabase alloc] initWithPath:self.dbPath];
}
//创建省份表单
- (void)creatProvinceTabel{
    [self.dataBase open];
    [self.dataBase executeUpdate:@"CREATE TABLE IF  NOT EXISTS Province (rowid INTEGER PRIMARY KEY AUTOINCREMENT, GRADE text,ID text,NAME text,PARENT_AREA_ID text)"];
    [self.dataBase close];
}
// 创建城市表单

- (void)creatCityTabel{
    [self.dataBase open];
    [self.dataBase executeUpdate:@"CREATE TABLE IF  NOT EXISTS City (rowid INTEGER PRIMARY KEY AUTOINCREMENT, GRADE text,ID text,NAME text,PARENT_AREA_ID text)"];
    [self.dataBase close];
}
//创建区域表单
- (void)creatAreaTabel{
    [self.dataBase open];
    [self.dataBase executeUpdate:@"CREATE TABLE IF  NOT EXISTS Area (rowid INTEGER PRIMARY KEY AUTOINCREMENT, GRADE text,ID text,NAME text,PARENT_AREA_ID text)"];
    [self.dataBase close];
}
// 插入省份数据
- (void)insterProvince:(ProvinceModel *)province{
    [self.fmdbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        [db executeUpdate:@"INSERT INTO Province (GRADE,ID,NAME,PARENT_AREA_ID) VALUES (?,?,?,?)",province.GRADE,province.ID,province.NAME,province.PARENT_AREA_ID];
        [db close];
    }];
}
// 插入城市数据
- (void)insterCity:(CityModel *)city{
    [self.fmdbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        [db executeUpdate:@"INSERT INTO City (GRADE,ID,NAME,PARENT_AREA_ID) VALUES (?,?,?,?)",city.GRADE,city.ID,city.NAME,city.PARENT_AREA_ID];
        [db close];
    }];
}
// 插入区域数据
- (void)insterArea:(AreaModel *)area{
    [self.fmdbQueue inDatabase:^(FMDatabase *db) {
        [db open];
        [db executeUpdate:@"INSERT INTO Area (GRADE,ID,NAME,PARENT_AREA_ID) VALUES (?,?,?,?)",area.GRADE,area.ID,area.NAME,area.PARENT_AREA_ID];
        [db close];
    }];
}
// 获取所有省份模型的集合数组
- (NSMutableArray *)getAllProvinceData{
    NSMutableArray *provinceArray = [[NSMutableArray alloc] init];
    [self.fmdbQueue inDatabase:^(FMDatabase *db) {
        [self openChinaAreaDB:db];
        FMResultSet *result = [db executeQuery:@"SELECT * FROM Province"];
        while ([result next]) {
            ProvinceModel *model = [[ProvinceModel alloc] init];
            model.GRADE = [result stringForColumn:@"GRADE"];
            model.ID = [result stringForColumn:@"ID"];
            model.NAME = [result stringForColumn:@"NAME"];
            model.PARENT_AREA_ID = [result stringForColumn:@"PARENT_AREA_ID"];
            [provinceArray addObject:model];
        }
        [db close];
    }];
    return provinceArray;
}
// 根据省份ID获取对应的省份数据模型

- (ProvinceModel *)getProvinceDataByID:(NSString *)provinceID{
    ProvinceModel *pmodel = [[ProvinceModel alloc] init];
    [self.fmdbQueue inDatabase:^(FMDatabase *db) {
        [self openChinaAreaDB:db];
        FMResultSet *result = [db executeQuery:@"SELECT * FROM Province WHERE ID = ?",provinceID];
        while ([result next]) {
            pmodel.GRADE = [result stringForColumn:@"GRADE"];
            pmodel.ID = [result stringForColumn:@"ID"];
            pmodel.NAME = [result stringForColumn:@"NAME"];
            pmodel.PARENT_AREA_ID = [result stringForColumn:@"PARENT_AREA_ID"];
        }
        [db close];
    }];
    return pmodel;
}
// 根据省份ID获取该省份的所有城市数据模型的集合
- (NSMutableArray *)getCityDataByParentID:(NSString *)parentID{
    NSMutableArray *cityArray = [[NSMutableArray alloc] init];
    [self.fmdbQueue inDatabase:^(FMDatabase *db) {
        [self openChinaAreaDB:db];
        FMResultSet *result = [db executeQuery:@"SELECT * FROM City WHERE PARENT_AREA_ID = ?",parentID];
        while ([result next]) {
            CityModel *model = [[CityModel alloc] init];
            model.GRADE = [result stringForColumn:@"GRADE"];
            model.ID = [result stringForColumn:@"ID"];
            model.NAME = [result stringForColumn:@"NAME"];
            model.PARENT_AREA_ID = [result stringForColumn:@"PARENT_AREA_ID"];
            [cityArray addObject:model];
        }
        [db close];
    }];
    return cityArray;
}
//根据城市ID获取对应的城市数据模型

- (CityModel *)getCityDataByID:(NSString *)cityID{
    CityModel *pmodel = [[CityModel alloc] init];
    [self.fmdbQueue inDatabase:^(FMDatabase *db) {
        [self openChinaAreaDB:db];
        FMResultSet *result = [db executeQuery:@"SELECT * FROM City WHERE ID = ?",cityID];
        while ([result next]) {
            pmodel.GRADE = [result stringForColumn:@"GRADE"];
            pmodel.ID = [result stringForColumn:@"ID"];
            pmodel.NAME = [result stringForColumn:@"NAME"];
            pmodel.PARENT_AREA_ID = [result stringForColumn:@"PARENT_AREA_ID"];
        }
        [db close];
    }];
    return pmodel;
}
//根据城市ID获取该城市的所有区域数据模型的集合
 
- (NSMutableArray *)getAreaDataByParentID:(NSString *)parentID{
    NSMutableArray *areaArray = [[NSMutableArray alloc] init];
    [self.fmdbQueue inDatabase:^(FMDatabase *db) {
        [self openChinaAreaDB:db];
        FMResultSet *result = [db executeQuery:@"SELECT * FROM Area WHERE PARENT_AREA_ID = ?",parentID];
        while ([result next]) {
            AreaModel *model = [[AreaModel alloc] init];
            model.GRADE = [result stringForColumn:@"GRADE"];
            model.ID = [result stringForColumn:@"ID"];
            model.NAME = [result stringForColumn:@"NAME"];
            model.PARENT_AREA_ID = [result stringForColumn:@"PARENT_AREA_ID"];
            [areaArray addObject:model];
        }
        [db close];
    }];
    return areaArray;
}
//根据地区ID获取对应的地区数据模型

- (AreaModel *)getAreaDataByID:(NSString *)areaID{
    AreaModel *pmodel = [[AreaModel alloc] init];
    [self.fmdbQueue inDatabase:^(FMDatabase *db) {
        [self openChinaAreaDB:db];
        FMResultSet *result = [db executeQuery:@"SELECT * FROM Area WHERE ID = ?",areaID];
        while ([result next]) {
            pmodel.GRADE = [result stringForColumn:@"GRADE"];
            pmodel.ID = [result stringForColumn:@"ID"];
            pmodel.NAME = [result stringForColumn:@"NAME"];
            pmodel.PARENT_AREA_ID = [result stringForColumn:@"PARENT_AREA_ID"];
        }
        [db close];
    }];
    return pmodel;
}
// 打开数据库
- (void)openChinaAreaDB:(FMDatabase *)db{
    BOOL isOpen = [db open];
    if (isOpen == YES) {

    }
    else{

    }
}

//制作省份数据模型
- (ProvinceModel *)makeProvinceModel:(NSNumber *)GRADE provinceID:(NSNumber *)ID name:(NSString *)NAME parentId:(NSNumber *)PARENT_AREA_ID{
    ProvinceModel *model = [[ProvinceModel alloc] init];
    model.GRADE = [NSString stringWithFormat:@"%@",GRADE];
    model.ID = [NSString stringWithFormat:@"%@",ID];
    model.NAME = NAME;
    model.PARENT_AREA_ID = [NSString stringWithFormat:@"%@",PARENT_AREA_ID];
    return model;
}

// 制作城市数据模型

- (CityModel *)makeCityModel:(NSNumber *)GRADE cityID:(NSNumber *)ID name:(NSString *)NAME parentId:(NSNumber *)PARENT_AREA_ID{
    CityModel *model = [[CityModel alloc] init];
    model.GRADE = [NSString stringWithFormat:@"%@",GRADE];
    model.ID = [NSString stringWithFormat:@"%@",ID];
    model.NAME = NAME;
    model.PARENT_AREA_ID = [NSString stringWithFormat:@"%@",PARENT_AREA_ID];
    return model;
}


//制作区域数据模型

- (AreaModel *)makeAreaModel:(NSNumber *)GRADE areaID:(NSNumber *)ID name:(NSString *)NAME parentId:(NSNumber *)PARENT_AREA_ID{
    AreaModel *model = [[AreaModel alloc] init];
    model.GRADE = [NSString stringWithFormat:@"%@",GRADE];
    model.ID = [NSString stringWithFormat:@"%@",ID];
    model.NAME = NAME;
    model.PARENT_AREA_ID = [NSString stringWithFormat:@"%@",PARENT_AREA_ID];
    return model;
}





@end
