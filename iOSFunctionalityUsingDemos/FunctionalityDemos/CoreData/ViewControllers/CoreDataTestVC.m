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
    NSArray * _ds;
    NSArray * _dsGroupNames;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    
    NSString * group0Name = @"加载 Data Model 示例";
    NSArray * gourp0 = @[
                         @{
                             @"text":@"加载 Data Model 示例",
                             @"selectorString":@"loadDataModel"
                             },
                         @{
                             @"text":@"加载 不同版本的 data model",
                             @"selectorString":@"loadDataModel2"
                             }
                         ];
    
    NSString * group1Name = @"新增";
    NSArray * gourp1 = @[
                            @{
                                @"text":@"插入",
                                @"selectorString":@"insert"
                            }
                         ];
    
    
    NSString * group2Name = @"查询";
    NSArray * gourp2 = @[
                         @{
                             @"text":@"简单查询",
                             @"selectorString":@"searchAll"
                             },
                         @{
                             @"text":@"使用查询模板",
                             @"selectorString":@"userSearchTempleate"
                             },
                         @{
                             @"text":@"查询指定的值",
                             @"selectorString":@"specifySearch"
                             }
                         ];
    NSString * group3Name = @"删除";
    NSArray * gourp3 = @[
                         @{
                             @"text":@"删除-所有数据",
                             @"selectorString":@"deleteAll"
                             }
                         ];
    
    NSString * group4Name = @"本地化";
    NSArray * gourp4 = @[
                         @{
                             @"text":@"本地化",
                             @"selectorString":@"LocalizingTest"
                             }
                         ];
    
    _ds = @[
            gourp0,
            gourp1,
            gourp2,
            gourp3,
            gourp4
            ];
    _dsGroupNames = @[group0Name,group1Name,group2Name,group3Name,group4Name];
    
    NSLog(@"%@",kDocumentsDir);
    _tbv.delegate = self;
    _tbv.dataSource = self;
    [_tbv registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

#pragma mark ---------------------------------------- demo 方法 ----------------------------------------
#pragma mark 保存更改
- (void) saveChangesForManagedObjectContext:(NSManagedObjectContext *)managedObjectContext{
    NSError * err;
    BOOL isSuc = [managedObjectContext save:&err];
    if (isSuc ) {
        NSLog(@"保存成功");
    }else{
        NSLog(@"保存失败 error:%@",err);
    }
}
#pragma mark 加载 ---------------------------------------- 加载 Data Model 示例 ----------------------------------------
- (void) loadDataModel{
    NSLog(@"示例代码>>>> %@ 中 第 %d 行",NSStringFromClass([self class]),__LINE__);
    /*
     注：当两个model中拥有同名的实体时，只有当他们相同时，才能 merge 加载这两个model ，否则就会报错。
     Model1 中的 TestEntity1 和 Model2 中的 TestEntity1 ，目前他们是相同的，将他们得属性改成不同的之后，运行可以查看效果。
     */
    
//    //1 合并指定bundle 中所有model
//    NSManagedObjectModel * manangedModel = [NSManagedObjectModel mergedModelFromBundles:@[[NSBundle mainBundle]]];
//    //2 获取指定model
//    NSURL * url = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"Model1" ofType:@"momd"]];
//    NSManagedObjectModel * manangedModel = [[NSManagedObjectModel alloc]initWithContentsOfURL:url];
    
    //合并指定model
    NSManagedObjectModel * model1 = [[NSManagedObjectModel alloc]initWithContentsOfURL:[NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"Model1" ofType:@"momd"]]];
    NSManagedObjectModel * model2 = [[NSManagedObjectModel alloc]initWithContentsOfURL:[NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"Model2" ofType:@"momd"]]];
    NSManagedObjectModel * manangedModel = [NSManagedObjectModel modelByMergingModels:@[model1,model2]];

    //输出所有实体
    for (NSEntityDescription * entity in manangedModel.entities) {
        NSLog(@"%@",entity.name);
    }
}
- (void) loadDataModel2{
    NSLog(@"暂时不知道怎么获取");
//    NSLog(@"示例代码>>>> %@ 中 第 %d 行",NSStringFromClass([self class]),__LINE__);
//    NSManagedObjectModel * model1_version2 = [[NSManagedObjectModel alloc]initWithContentsOfURL:[NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"Model1_version2" ofType:@"mom"]]];
//    //输出所有实体
//    for (NSEntityDescription * entity in model1_version2.entities) {
//        NSLog(@"%@",entity.name);
//        
//    }
}
#pragma mark ---------------------------------------- 新增 ----------------------------------------
#pragma mark 插入
- (void) insert{
    NSLog(@"示例代码>>>> %@ 中 第 %d 行",NSStringFromClass([self class]),__LINE__);
    NSManagedObjectContext * managedObjectContext = [self managedObjectContextWithModelName:@"Model3"];
    
    NSEntityDescription * entity = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:managedObjectContext];
    Student * stu = (Student *)entity;
    stu.name = @"jerry";
    [self saveChangesForManagedObjectContext:managedObjectContext];
}
#pragma mark ---------------------------------------- 查询 ----------------------------------------
- (NSArray *) searchAll{
    NSLog(@"示例代码>>>> %@ 中 第 %d 行",NSStringFromClass([self class]),__LINE__);
    NSManagedObjectContext * managedObjectContext = [self managedObjectContextWithModelName:@"Model3"];
    
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
        NSLog(@"%@",results);
    }
    return results;
}
#pragma mark 创建查询模板
- (void) userSearchTempleate{
    NSLog(@"示例代码>>>> %@ 中 第 %d 行",NSStringFromClass([self class]),__LINE__);
    NSManagedObjectContext * managedObjectContext = [self managedObjectContextWithModelName:@"Model3"];
    NSManagedObjectModel * managedObjectModel = [self managedObjectModelWithModelName:@"Model3"];
    
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
    
    //获取无参模板
    NSFetchRequest * temp1 = [managedObjectModel fetchRequestTemplateForName:@"fetchAllStudentTemplate"];
    NSArray * res = [managedObjectContext executeFetchRequest:temp1 error:nil];
    NSLog(@"无参 查询结果：%@",res);
    //获取带参模板
    NSFetchRequest * temp2 = [managedObjectModel fetchRequestFromTemplateWithName:@"fetchReqTemp2" substitutionVariables:@{
                                                                                                                                   @"NAME":@"jerry"
                                                                                                                                   } ];
    NSArray * res2 = [managedObjectContext executeFetchRequest:temp2 error:nil];
    NSLog(@"有参 查询结果：%@",res2);
}
#pragma mark 查询指定的值
- (void) specifySearch{
    NSManagedObjectContext * managedObjectContext = [self managedObjectContextWithModelName:@"Model3"];
    //先插入一些测试数据
    for (NSInteger i = 1; i<=10; i++) {
        NSEntityDescription * entity = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:managedObjectContext];
        Student * stu = (Student *)entity;
        stu.name = [NSString stringWithFormat:@"name%d",i];
        stu.age = @(i);
    }
    [self saveChangesForManagedObjectContext:managedObjectContext];
    //指定那个属性
    NSExpression *keyPathExpression = [NSExpression expressionForKeyPath:@"age"];
    //表达式
    NSExpression *maxAgeExpression = [NSExpression expressionForFunction:@"max:"
                                                                  arguments:[NSArray arrayWithObject:keyPathExpression]];
    
    
    NSExpressionDescription *expressionDescription = [[NSExpressionDescription alloc] init];
    
    [expressionDescription setName:@"maxAge"];
    
    [expressionDescription setExpression:maxAgeExpression];
    
    [expressionDescription setExpressionResultType:NSInteger16AttributeType];
    
    NSFetchRequest  *request = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    [request setResultType:NSDictionaryResultType];
    [request setPropertiesToFetch:@[expressionDescription]];
    NSArray * rs = [managedObjectContext executeFetchRequest:request error:nil];
    NSLog(@"%@",rs);
}
#pragma mark ---------------------------------------- 删除 ----------------------------------------
#pragma mark 删除-所有
- (void) deleteAll{
    NSLog(@"示例代码>>>> %@ 中 第 %d 行",NSStringFromClass([self class]),__LINE__);
    NSManagedObjectContext * managedObjectContext = [self managedObjectContextWithModelName:@"Model3"];
    NSArray * res = [self searchAll];
    for (Student * stu in res) {
        [managedObjectContext deleteObject:stu];
    }
    [self saveChangesForManagedObjectContext:managedObjectContext];
}


#pragma mark ---------------------------------------- 本地化 ----------------------------------------

- (void) LocalizingTest{
    //相关资料 查阅：https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/CoreData/Articles/cdUsingMOM.html#//apple_ref/doc/uid/TP40005190-SW1
    NSManagedObjectContext * managedObjectContext = [self managedObjectContextWithModelName:@"LocalizingTestModel"];
    NSManagedObjectModel * managedObjectModel = [self managedObjectModelWithModelName:@"LocalizingTestModel"];
    //输出所有实体
    for (NSEntityDescription * entity in managedObjectModel.entities) {
        NSLog(@"%@",entity.name);
    }
}


#pragma mark ---------------------------------------- Relationship ----------------------------------------
/*
    https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/CoreData/Articles/cdRelationships.html#//apple_ref/doc/uid/TP40001857-CJBDBHCB
 
    1、to-many relationship 你可以定义一个upper and lower 区间，lower 不一定必须是0.
    2、当一个关系是可选的并且定义了upper and lower 区间，要么该关系不存在，要么关系存在并且满足upper and lower 区间。
    3、大多数关系是双向的，fetched property是个例外，fetched property 表示一个单向的弱关系。
 
 删除规则 
    1、Deny ： 关系的 destination 只要有一个对象，那么 source 对象就不能被删除。例如：如果你要移除一个部门，你必须确保部门下所有的员工都已经被转移到其他部门或者被解雇。
 
    2、Nullify ： 在 destination 对象中将 source 对象设置为 null。例如：如果你要移除一个部门，就把部门下所有员工的部门属性设置为 null。但是这只能在 部门 ---> 员工 这个关系是 optional
                 情况下使用，或者你得确定在下次保存操作前将该部门下所有员工的部门属性设置为一个新的。
 
    3、Cascade：删除 source 对象的同时 删除 destination 对象。例如：当你要移除一个部门的时候，将该部门所有员工解雇。
    
    4、No Action ： 不对 destination 对象做任何操作。例如：你移除了一个部门，但是你没管这个部门下的员工，那些员工甚至会认为他们还在那个部门中。
 
    如果你使用了 No Action，你将可能会使 object graph 处于一个矛盾状态（员工和一个不存在的部门建立了关系）。此时就得靠你自己去维护  object graph 的一致性了。你要负责将 反向关系设置为一个有意义的值。比如：你有一个to-manay 的关系，然后 destination 处有很多对象。
 
 
 Many-to-Many Relationships 关系：
    你必须在两个方向上都定义 Many-to-Many 关系。
 */
















#pragma mark ---------------------------------------- tableview 代理 ----------------------------------------
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
#pragma mark ----- helper -------
-(NSManagedObjectContext *)managedObjectContextWithModelName:(NSString * ) modelName
{

    
    NSPersistentStoreCoordinator* coordinator=[self persistentStoreCoordinatorWithModelName:modelName];
    NSManagedObjectContext * managedObjectContext=[[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [managedObjectContext setPersistentStoreCoordinator:coordinator];
    
    return managedObjectContext;
}
- (NSPersistentStoreCoordinator *)persistentStoreCoordinatorWithModelName:(NSString * ) modelName {
    NSURL *storeUrl = [NSURL fileURLWithPath: [kDocumentsDir stringByAppendingPathComponent:@"CoreData.sqlite"]];
    NSError *error;
    NSPersistentStoreCoordinator * persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]
                                  initWithManagedObjectModel: [self managedObjectModelWithModelName: modelName]];
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                  configuration:nil URL:storeUrl options:nil error:&error]) {
    }
    return persistentStoreCoordinator;
}
- (NSManagedObjectModel *)managedObjectModelWithModelName:(NSString * ) modelName {
    NSManagedObjectModel * managedObjectModel = [[NSManagedObjectModel alloc]initWithContentsOfURL:[NSURL URLWithString:[[NSBundle mainBundle] pathForResource:modelName ofType:@"momd"]]];
    return managedObjectModel;
}

@end
