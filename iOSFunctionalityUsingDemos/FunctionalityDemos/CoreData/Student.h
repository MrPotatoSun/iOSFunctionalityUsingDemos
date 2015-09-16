//
//  Student.h
//  iOSFunctionalityUsingDemos
//
//  Created by 刘杰 on 15/9/16.
//  Copyright (c) 2015年 com.cjs.ljc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Student : NSManagedObject

@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSString * name;

@end
