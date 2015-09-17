//
//  A.h
//  iOSFunctionalityUsingDemos
//
//  Created by 刘杰 on 15/9/17.
//  Copyright (c) 2015年 com.cjs.ljc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Entity.h"

@class B;

@interface A : Entity

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) B *b;

@end
