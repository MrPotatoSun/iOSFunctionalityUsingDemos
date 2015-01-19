//
//  aaViewController.m
//  iOSFunctionalityUsingDemos
//
//  Created by 刘杰cjs on 15/1/19.
//  Copyright (c) 2015年 com.cjs.ljc. All rights reserved.
//

#import "DynamicRVC.h"
#import "Common.h"
#import "MyBehavior.h"
@interface DynamicRVC ()
{
    NSArray * _ds;
    UIDynamicAnimator * _animator;
    
    UIAttachmentBehavior* _attachmentBehavior;

}
@property (weak, nonatomic) IBOutlet UITableView *tbv;
@property (weak, nonatomic) IBOutlet UIView *blueView;

@end

@implementation DynamicRVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"UIDynamic Demo";
    [_tbv registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    _ds=@[
          @"UIGravityBehavior(重力行为)",
          @"UICollisionBehavior(碰撞行为)",
          @"UISnapBehavior(捕捉行为)",
          @"UIPushBehavior(推动行为)",
          @"UIAttachmentBehavior(附着行为)",
          @"UIDynamicItemBehavior(动力元素行为)",
          @"行为的组合"
          ];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"重置" style:UIBarButtonItemStylePlain target:self action:@selector(reset)];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _ds.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text=_ds[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * entry = _ds[indexPath.row];
    if ([entry isEqualToString:@"UIGravityBehavior(重力行为)"]) {
       UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[_blueView]];
        [_animator addBehavior:gravity];
    }else if ([entry isEqualToString:@"UICollisionBehavior(碰撞行为)"]) {
        UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[_blueView]];
        UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[_blueView]];
        //指定 ReferenceView 为边界
        collision.translatesReferenceBoundsIntoBoundary = YES;
        //以指定的path为碰撞边界
        //[collision  addBoundaryWithIdentifier:@"b1" forPath:[UIBezierPath bezierPathWithRect:CGRectMake(0, 300, 100, 100)]];"
        //以指定两点的连线为碰撞边界
        //[collision addBoundaryWithIdentifier:@"b2" fromPoint:CGPointMake(0, 300) toPoint:CGPointMake(300, 400)];
        [_animator addBehavior:gravity];
        [_animator addBehavior:collision];
    }else if ([entry isEqualToString:@"UISnapBehavior(捕捉行为)"]) {
        UISnapBehavior * snap = [[UISnapBehavior alloc]initWithItem:_blueView snapToPoint:CGPointMake(160, 300)];
        //阻尼
        snap.damping=0.8;
        [_animator addBehavior:snap];
    }else if ([entry isEqualToString:@"UIPushBehavior(推动行为)"]) {
        //UIPushBehaviorModeInstantaneous 瞬时的一个力
        //UIPushBehaviorModeContinuous 持续的一个力
        UIPushBehavior *  push = [[UIPushBehavior alloc]initWithItems:@[_blueView] mode:UIPushBehaviorModeInstantaneous];
        // magnitude 表示力的大小
        //angle 表示力的角度
        //magnitude 和 angle能够确定物体的运动方向 和 设置 pushDirection效果一样
        push.magnitude = 0.5;
        push.angle = kDegreesToRadian(0);
        //1表示一个 100x100的密度为1的view以100 point/s² 的加速度移动
        //x,y能够确定方向
      // push.pushDirection = CGVectorMake(0.1,0);
        [_animator addBehavior:push];
    }else if ([entry isEqualToString:@"UIAttachmentBehavior(附着行为)"]) {
        UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handleAttachmentGesture:)];
        [self.view addGestureRecognizer:pan];
       
    }else if ([entry isEqualToString:@"UIDynamicItemBehavior(动力元素行为)"]) {
        UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[_blueView]];
    
        UIDynamicItemBehavior * param = [[UIDynamicItemBehavior alloc]initWithItems:@[_blueView]];
        param.resistance = 20;
        [_animator addBehavior:gravity];
        [_animator addBehavior:param];
    }else if ([entry isEqualToString:@"行为的组合"]){
        MyBehavior * mb=[[MyBehavior alloc]initWithItems:@[_blueView]];
        [_animator addBehavior:mb];
    }
}

-(IBAction)handleAttachmentGesture:(UIPanGestureRecognizer*)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan){
        UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[_blueView]];
        _attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:_blueView attachedToAnchor:CGPointMake(0, 0)];
        //默认从view中心点到锚点的长度
        _attachmentBehavior.length = 100;
        _attachmentBehavior.damping = 0.5;
        //摆动频率
        _attachmentBehavior.frequency=1;
        [_animator addBehavior:_attachmentBehavior];
        [_animator addBehavior:gravity];
    } else if ( gesture.state == UIGestureRecognizerStateChanged) {
        _attachmentBehavior.anchorPoint = [gesture locationInView:self.view];
    } else if (gesture.state == UIGestureRecognizerStateEnded) {
        [_animator removeBehavior:_attachmentBehavior];
    }
}

- (void) reset{
    
}
@end
