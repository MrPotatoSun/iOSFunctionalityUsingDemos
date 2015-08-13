//
//  City.h
//  iOSFunctionalityUsingDemos
//
//  Created by 刘杰cjs on 15/8/13.
//  Copyright (c) 2015年 com.cjs.ljc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface City : NSManagedObject

@property (nonatomic, retain) NSString * cityID;
@property (nonatomic, retain) NSString * cityName;
@property (nonatomic, retain) NSString * match;
@property (nonatomic, retain) NSString * pinyin;
@property (nonatomic, retain) NSString * groupName;

@end
