//
//  UIView+LJ.h
//  Estay
//
//  Created by jerry on 14-7-10.
//  Copyright (c) 2014年 estay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LJ)
@property (nonatomic,assign,readonly) CGFloat maxX;
@property (nonatomic,assign,readonly) CGFloat maxY;
@property (nonatomic,assign,readonly)CGFloat w_h_ratio;//宽高比
@property (nonatomic,assign)CGFloat x;
@property (nonatomic,assign)CGFloat y;
@property (nonatomic,assign)CGFloat height;
@property (nonatomic,assign)CGFloat width;
@property (nonatomic,assign)CGSize size;
@property (nonatomic,assign)CGPoint origin;


#pragma mark frame计算方法
+ (void) setFrame:(CGRect *) sourceFrame CenterYEqualToFrame:(CGRect *)desFrame;
+ (void) setFrame:(CGRect *) sourceFrame CenterXEqualToFrame:(CGRect *)desFrame;
+ (void) setFrame:(CGRect *) sourceFrame MaxYEqualToFrame:(CGRect *)desFrame;
+ (void) setFrame:(CGRect *) sourceFrame MaxXEqualToFrame:(CGRect *)desFrame;
    
    

@end
