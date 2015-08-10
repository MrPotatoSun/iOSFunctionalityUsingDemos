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
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    _ds = @[
            @{
                @"text":@"插入",
                @"selectorString":@"insert"
                },
            @{
                @"text":@"查询-所有数据",
                @"selectorString":@"searchAll"
                },
            @{
                @"text":@"删除-所有数据",
                @"selectorString":@"deleteAll"
                }
            ];
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
        // Handle error
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
#pragma mark 插入
- (void) insert{
    NSEntityDescription * entity = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:managedObjectContext];
    Student * stu = (Student *)entity;
    stu.name = @"fe2wa";
    [self saveChanges];
}
#pragma mark 查询
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
#pragma mark 删除-所有
- (void) deleteAll{
    NSArray * res = [self searchAll];
    for (Student * stu in res) {
        [managedObjectContext deleteObject:stu];
    }
    [self saveChanges];
}
#pragma mark ---------------------------------------- 代理 ----------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _ds.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSDictionary * dic =  _ds[indexPath.row];
    NSString * text = dic[@"text"];
    cell.textLabel.text = text;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary * dic =  _ds[indexPath.row];
    NSString * selectorString = dic[@"selectorString"];
    SEL sel =  NSSelectorFromString(selectorString);
    [self performSelector:sel withObject:nil];
}
@end
