//
//  MyBehavior.m
//  iOSFunctionalityUsingDemos
//
//  Created by 刘杰cjs on 15/1/19.
//  Copyright (c) 2015年 com.cjs.ljc. All rights reserved.
//

#import "MyBehavior.h"

@implementation MyBehavior
-(instancetype) initWithItems:(NSArray *)items
{
    if (self = [super init]) {
        UIGravityBehavior *gb = [[UIGravityBehavior alloc] initWithItems:items];
        UICollisionBehavior *cb = [[UICollisionBehavior alloc] initWithItems:items];
        cb.translatesReferenceBoundsIntoBoundary = YES;
        [self addChildBehavior:gb];
        [self addChildBehavior:cb];
    }
    return self;
}

@end
