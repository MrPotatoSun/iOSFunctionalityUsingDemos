//
//  RSStudent.h
//  iOSFunctionalityUsingDemos
//
//  Created by 刘杰 on 15/9/16.
//  Copyright (c) 2015年 com.cjs.ljc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class RSBed, RSClassRoom;

@interface RSStudent : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) RSClassRoom *classRoom;
@property (nonatomic, retain) RSBed *bed;

@end
