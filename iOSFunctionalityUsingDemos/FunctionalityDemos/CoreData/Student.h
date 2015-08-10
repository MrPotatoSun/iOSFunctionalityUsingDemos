//
//  Student.h
//  SecretBox
//
//  Created by 刘杰cjs on 15/8/7.
//  Copyright (c) 2015年 com.cjs.lj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Student : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * age;

@end
