//
//  TTViewController.m
//  SecretBox
//
//  Created by 刘杰cjs on 15/8/7.
//  Copyright (c) 2015年 com.cjs.lj. All rights reserved.
//

#import "CoreDataTestVC.h"
#import <CoreData/CoreData.h>
#import "Student.h"
#import "City.h"
#import "Common.h"
@interface CoreDataTestVC ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tbv;

@end

@implementation CoreDataTestVC
{
    NSPersistentStoreCoordinator * persistentStoreCoordinator;
    NSManagedObjectModel * managedObjectModel;
    NSManagedObjectContext * managedObjectContext;
    NSArray * _ds;
    NSArray * _dsGroupNames;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    
    
    
    NSString * group1Name = @"新增";
    NSArray * gourp1 = @[
                            @{
                                @"text":@"插入",
                                @"selectorString":@"insert"
                            },
                            @{
                                @"text":@"测试",
                                @"selectorString":@"testgff"
                                }
                         ];
    NSString * group2Name = @"查询";
    NSArray * gourp2 = @[
                         @{
                             @"text":@"查询-所有数据",
                             @"selectorString":@"searchAll"
                             },
                         @{
                             @"text":@"创建查询模板",
                             @"selectorString":@"createSearchTempleate"
                             },
                         @{
                             @"text":@"获取并使用查询模板",
                             @"selectorString":@"useSearchTempleate"
                             }
                         ];
    NSString * group3Name = @"删除";
    NSArray * gourp3 = @[
                         @{
                             @"text":@"删除-所有数据",
                             @"selectorString":@"deleteAll"
                             }
                         ];
    
    _ds = @[
            gourp1,
            gourp2,
            gourp3
            ];
    _dsGroupNames = @[group1Name,group2Name,group3Name];
    
    NSLog(@"%@",kDocumentsDir);
    _tbv.delegate = self;
    _tbv.dataSource = self;
    [_tbv registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    managedObjectContext = [self managedObjectContext];
}
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }
    NSURL *storeUrl = [NSURL fileURLWithPath: [kDocumentsDir stringByAppendingPathComponent:@"CoreData.sqlite"]];
    NSError *error;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]
                                  initWithManagedObjectModel: [self managedObjectModel]];
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                  configuration:nil URL:storeUrl options:nil error:&error]) {
    }
    return persistentStoreCoordinator;
}
- (NSManagedObjectModel *)managedObjectModel {
    if (managedObjectModel != nil) {
        return managedObjectModel;
    }
    managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    return managedObjectModel;
}
//托管对象上下文
-(NSManagedObjectContext *)managedObjectContext
{
    if (managedObjectContext!=nil) {
        return managedObjectContext;
    }
    
    NSPersistentStoreCoordinator* coordinator=[self persistentStoreCoordinator];
    if (coordinator!=nil) {
        managedObjectContext=[[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        
        [managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return managedObjectContext;
}
#pragma mark 测试
- (void)testgff{
    NSString * str = [NSString stringWithContentsOfFile:@"/Users/jerry/Desktop/城市信息.json" encoding:NSUTF8StringEncoding error:nil];
    NSDictionary * cityConfigDic =  [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    NSArray * groupCityDics = cityConfigDic[@"cityInfo"];
    for (NSDictionary * groupCityDic in groupCityDics) {
        NSString * groupName = groupCityDic[@"groupName"];
        NSArray * cityDics = groupCityDic[@"members"];
        for (NSDictionary * cityDic in cityDics) {
            NSString * cityID = cityDic[@"city_id"];
            NSString * cityName = cityDic[@"city_name"];
            NSString * match = cityDic[@"Match"];
            NSString * pinyin = cityDic[@"PinYin"];
            
            City  * cityInfo =  [NSEntityDescription insertNewObjectForEntityForName:@"City" inManagedObjectContext:managedObjectContext];
            cityInfo.cityID = cityID;
            cityInfo.cityName = cityName;
            cityInfo.match = match;
            cityInfo.pinyin = pinyin;
            cityInfo.groupName = groupName;
            
            NSLog(@"f");
        }
    }
    [managedObjectContext save:nil];
}
#pragma mark ---------------------------------------- demo 方法 ----------------------------------------
#pragma mark 保存更改
- (void) saveChanges{
    NSError * err;
    BOOL isSuc = [managedObjectContext save:&err];
    if (isSuc ) {
        NSLog(@"保存成功");
    }else{
        NSLog(@"保存失败 error:%@",err);
    }
}
#pragma mark ---------------------------------------- 新增 ----------------------------------------
#pragma mark 插入
- (void) insert{
    NSEntityDescription * entity = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:managedObjectContext];
    Student * stu = (Student *)entity;
    stu.name = @"jerry";
    [self saveChanges];
}
#pragma mark ---------------------------------------- 查询 ----------------------------------------
- (NSArray *) searchAll{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Student"];
    NSError * err;
    NSArray * results = [managedObjectContext executeFetchRequest:request error:&err];
    if (err) {
        NSLog(@"查询出错,error:%@",err);
        return nil;
    }
    if (results.count<=0) {
        NSLog(@"查询无数据");
    }else{
        NSLog(@"-------- 查询出来的所有数据 start start start ---------");
        for (Student * stu in results) {
            NSLog(@"name:%@ age:%@",stu.name,stu.age);
        }
        NSLog(@"-------- 查询出来的所有数据 end end end ---------");
    }
    return results;
}
#pragma mark 创建查询模板
- (void) createSearchTempleate{
    NSEntityDescription * entity = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:managedObjectContext];
    //模板1 不带参数
    NSFetchRequest  * fetchReqTemp = [[NSFetchRequest alloc]init];
    [fetchReqTemp setEntity:entity];
    [managedObjectModel setFetchRequestTemplate:fetchReqTemp forName:@"fetchAllStudentTemplate"];
    NSLog(@"创建了一个 名称为 fetchAllStudentTemplate 的查询模板，用于查询所有 Student 的信息");
    
    //模板2 带参数
    NSFetchRequest  * fetchReqTemp2 = [[NSFetchRequest alloc]init];
    [fetchReqTemp2 setEntity:entity];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@" name == $NAME"];
    [fetchReqTemp2 setPredicate:predicate];
    [managedObjectModel setFetchRequestTemplate:fetchReqTemp2 forName:@"fetchReqTemp2"];
    
    NSLog(@"创建了一个 名称为 fetchReqTemp2 的查询模板，用于查询所有 指定 Student 的信息");
}
#pragma mark 获取并使用查询模板
- (void) useSearchTempleate{
    //获取无惨模板
    NSFetchRequest * fetchReqTemp = [managedObjectModel fetchRequestTemplateForName:@"fetchAllStudentTemplate"];
    NSArray * res = [managedObjectContext executeFetchRequest:fetchReqTemp error:nil];
    NSLog(@"无参 查询结果：%@",res);
    
    //获取带参模板
    NSFetchRequest * fetchReqTemp2 = [managedObjectModel fetchRequestFromTemplateWithName:@"fetchReqTemp2" substitutionVariables:@{
                                                                                                                                   @"NAME":@"jerry"
                                                                                                                                   } ];
    NSArray * res2 = [managedObjectContext executeFetchRequest:fetchReqTemp2 error:nil];
    NSLog(@"有参 查询结果：%@",res2);
    
}
#pragma mark ---------------------------------------- 删除 ----------------------------------------
#pragma mark 删除-所有
- (void) deleteAll{
    NSArray * res = [self searchAll];
    for (Student * stu in res) {
        [managedObjectContext deleteObject:stu];
    }
    [self saveChanges];
}
#pragma mark ---------------------------------------- 代理 ----------------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dsGroupNames.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return _dsGroupNames[section];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return ((NSArray *)_ds[section]).count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSDictionary * dic =  ((NSArray *)_ds[indexPath.section])[indexPath.row];
    
    NSString * text = dic[@"text"];
    cell.textLabel.text = text;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary * dic =  ((NSArray *)_ds[indexPath.section])[indexPath.row];
    
    NSString * selectorString = dic[@"selectorString"];
    SEL sel =  NSSelectorFromString(selectorString);
    [self performSelector:sel withObject:nil];
}
@end
