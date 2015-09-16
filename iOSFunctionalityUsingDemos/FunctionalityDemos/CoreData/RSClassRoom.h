//
//  RSClassRoom.h
//  iOSFunctionalityUsingDemos
//
//  Created by 刘杰 on 15/9/16.
//  Copyright (c) 2015年 com.cjs.ljc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class RSStudent;

@interface RSClassRoom : NSManagedObject

@property (nonatomic, retain) NSString * roomName;
@property (nonatomic, retain) NSSet *stus;
@end

@interface RSClassRoom (CoreDataGeneratedAccessors)

- (void)addStusObject:(RSStudent *)value;
- (void)removeStusObject:(RSStudent *)value;
- (void)addStus:(NSSet *)values;
- (void)removeStus:(NSSet *)values;

@end
