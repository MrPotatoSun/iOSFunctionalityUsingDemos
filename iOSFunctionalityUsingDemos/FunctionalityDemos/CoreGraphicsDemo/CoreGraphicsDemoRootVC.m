//
//  RVC.m
//  CoreGraphicsTest
//
//  Created by 刘杰cjs on 14/12/23.
//  Copyright (c) 2014年 刘杰cjs. All rights reserved.
//

#import "CoreGraphicsDemoRootVC.h"
#import "MyView.h"
#import "UIView+LJ.h"

@interface CoreGraphicsDemoRootVC ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tbv;
@property (weak, nonatomic) IBOutlet MyView *myView;

@end

@implementation CoreGraphicsDemoRootVC
{
    NSDictionary * _ds;
    NSArray * _dsSortedKeys;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //key的数字为了排序
    //value中的数字 作为操作的id
    _ds = @{
            @"1-简单绘制":@[
                      @"绘制直线-11",
                      @"绘制矩形-12",
                      @"绘制圆弧-13",
                      @"绘制曲线-14",
                      @"绘制椭圆-15",
                      @"快速绘制图形的方法-16",
                      @"裁剪-17"
                    ],
            @"2-描边参数( Parameters That Affect Stroking )":@[
                    @"Line width (path的宽度)-21",
                    @"Line join (path连接处的样式)-22",
                    @"Line cap (path 端帽)-23",
                    @"Line dash pattern-24",
                    @"暂未做 Stroke color space，Stroke color，Stroke pattern -0000"
                    ],
            @"3-填充 (fill a path)":@[
                        @"填充一个path-31",
                        @"快速填充方法-32",
                        @"填充规则:onzero winding number rule(非零环绕数规则)-33",
                        @"填充规则:even odd rule (奇偶规则)-34"
                    ],
            @"4-混合模式 (Blend Modes)":@[
                        @"Normal Blend Mode-41",
                        @"Multiply Blend Mode-42",
                        @"Screen Blend Mode-43",
                        @"Overlay Blend Mode-44",
                        @"Darken Blend Mode-45",
                        @"Lighten Blend Mode-46",
                        @"Color Dodge Blend Mode-47",
                        @"Color Burn Blend Mode-48",
                        @"Soft Light Blend Mode-49",
                        @"Hard Light Blend Mode-411",
                        @"Difference Blend Mode-412",
                        @"Exclusion Blend Mode-413",
                        @"Hue Blend Mode-414",
                        @"Saturation Blend Mode-415",
                        @"Color Blend Mode-416",
                        @"Luminosity Blend Mode-417"
                    ],
            @"5-Transforms (变换)":@[
                        @"Translation(平移)-51",
                        @"Rotation(旋转)-52",
                        @"Scaling(缩放)-53",
                        @"Translation2(平移2)-54",
                        @"Rotation2(旋转2)-55",
                        @"Scaling2(缩放2)-56",
                        @"Invert(翻转)-57",
                        @"变换坐标计算-58",
                        @"Transforms比较、恒等变换-59",
                        @"设备坐标系统相关-511"
                    ],
            @"6-Pattern (模板)":@[
                        @"Painting Colored Patterns-61",
                        @"Painting Stencil Patterns-62"
                    ],
            @"7-Shadows (阴影)":@[
                        @"Shadows-71"
                    ],
            @"8-Gradients (渐变)":@[
                        @"LinearGradient(线性渐变)-81",
                        @"RadialGradient(径向渐变)-82",
                        @"CGShading(暂无)-83"
                    ],
            @"9-Transparency Layer":@[
                        @"Transparency Layer-91"
                    ],
            @"10-Layer Drawing":@[
                    @"Layer Drawing-101"
                    ]
            };
    _dsSortedKeys = [_ds.allKeys sortedArrayWithOptions:NSSortConcurrent usingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString * obj1Str = (NSString  *)obj1;
        NSString * obj2Str = (NSString  *)obj2;
        NSInteger obj1SortIndex =  [[obj1Str substringToIndex:[obj1Str rangeOfString:@"-"].location] integerValue];
        NSInteger obj2SortIndex =  [[obj2Str substringToIndex:[obj2Str rangeOfString:@"-"].location] integerValue];
        return obj1SortIndex - obj2SortIndex;
    }];
    _tbv.sectionHeaderHeight=1;
    _tbv.sectionFooterHeight = 1;
   
    //滚动到最后一行
   // [_tbv scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:((NSArray *)[_ds objectForKey:_dsSortedKeys[_dsSortedKeys.count-1]]).count-1 inSection:_ds.allKeys.count-1] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray * sectionTitle = _dsSortedKeys[section];
    NSArray * titlesArr = (NSArray *)_ds[sectionTitle];
    return titlesArr.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  _dsSortedKeys.count;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return _dsSortedKeys[section];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * sectionTitle = _dsSortedKeys[indexPath.section];
    NSArray * titlesArr = (NSArray *)_ds[sectionTitle];
    
    static NSString * reuseId = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    cell.textLabel.font= [UIFont systemFontOfSize:13];
    NSString * title = titlesArr[indexPath.row];
    cell.textLabel.text = [title substringToIndex:[title rangeOfString:@"-"].location];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * sectionTitle = _dsSortedKeys[indexPath.section];
    NSArray * titlesArr = (NSArray *)_ds[sectionTitle];
     NSString * title = titlesArr[indexPath.row];
    NSInteger drawDemoId =[title substringFromIndex:([title rangeOfString:@"-"].location+1)].integerValue;
    _myView.drawDemoId = drawDemoId;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}
#define kColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * hv= [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, 25)];
    hv.backgroundColor = [UIColor redColor];
    UILabel * lb=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 1, 25)];
    lb.textAlignment=NSTextAlignmentCenter;
    lb.backgroundColor = [UIColor grayColor];
    lb.font = [UIFont systemFontOfSize:14];
    lb.text=_dsSortedKeys[section];
    return lb;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 25;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
@end
