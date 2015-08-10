//
//  Menu.m
//  iOSFunctionalityDemos
//
//  Created by 刘杰cjs on 15/1/15.
//  Copyright (c) 2015年 com.cjs.ljc. All rights reserved.
//

#import "Menu.h"
#import "CoreGraphicsDemoRootVC.h"
#import "DynamicRVC.h"
#import "CoreDataTestVC.h"
@interface Menu ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tbv;

@end

@implementation Menu
{
    NSArray * _ds;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"iOS 各种功能演示DEMO";
    
    _ds= @[@"Core Graphics Demo",@"UIDynamic Demo",@"CoreData Demo"];
    
    CoreDataTestVC * rvc = [[CoreDataTestVC alloc]init];

    [self.navigationController pushViewController:rvc animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _ds.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * reuseId = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }

    cell.textLabel.text =_ds[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * str = _ds[indexPath.row];
    if ([str isEqualToString:@"Core Graphics Demo"]) {
        CoreGraphicsDemoRootVC * cgrvc = [[CoreGraphicsDemoRootVC alloc]init];
        cgrvc.title = str;
        [self.navigationController pushViewController:cgrvc animated:YES];
    }else if ([str isEqualToString:@"UIDynamic Demo"]) {
        DynamicRVC * rvc = [[DynamicRVC alloc]init];
        rvc.title = str;
        [self.navigationController pushViewController:rvc animated:YES];
    }else if ([str isEqualToString:@"CoreData Demo"]) {
        CoreDataTestVC * rvc = [[CoreDataTestVC alloc]init];
        rvc.title = str;
        [self.navigationController pushViewController:rvc animated:YES];
    }
}
@end
