//
//  UIView+LJ.m
//  Estay
//
//  Created by jerry on 14-7-10.
//  Copyright (c) 2014年 estay. All rights reserved.
//

#import "UIView+LJ.h"

@implementation UIView (LJ)

#pragma mark ---frame相关操作
+ (void) setFrame:(CGRect *) sourceFrame CenterXEqualToFrame:(CGRect *)desFrame{
    (*sourceFrame).origin.x=(*desFrame).origin.x+((*desFrame).size.width-(*sourceFrame).size.width)/2;
}

+ (void) setFrame:(CGRect *) sourceFrame CenterYEqualToFrame:(CGRect *)desFrame{
    (*sourceFrame).origin.y=(*desFrame).origin.y+((*desFrame).size.height-(*sourceFrame).size.height)/2;
}
+ (void) setFrame:(CGRect *) sourceFrame MaxYEqualToFrame:(CGRect *)desFrame{
    (*sourceFrame).origin.y=(*desFrame).origin.y+((*desFrame).size.height-(*sourceFrame).size.height);
}
+ (void) setFrame:(CGRect *) sourceFrame MaxXEqualToFrame:(CGRect *)desFrame{
    (*sourceFrame).origin.x=(*desFrame).origin.x+((*desFrame).size.width-(*sourceFrame).size.width);
}
#pragma mark ---getter/setter
- (CGFloat) maxX{
    return CGRectGetMaxX(self.frame);
}
- (CGFloat) maxY{
    return CGRectGetMaxY(self.frame);
}
- (CGFloat) x{
    return self.frame.origin.x;
}
- (CGFloat) y{
    return self.frame.origin.y;
}
- (CGFloat) width{
    return self.frame.size.width;
}
- (CGFloat) height{
    return self.frame.size.height;
}
- (CGPoint) origin{
    return self.frame.origin;
}
- (CGSize) size{
    return self.frame.size;
}
- (void) setX:(CGFloat)x{
    CGRect  f=self.frame;
    f.origin.x=x;
    self.frame=f;
}
- (void) setY:(CGFloat)y{
    CGRect  f=self.frame;
    f.origin.y=y;
    self.frame=f;
}
- (void) setWidth:(CGFloat )width{
    CGRect  f=self.frame;
    f.size.width=width;
    self.frame=f;
}
- (void) setHeight:(CGFloat )height{
    CGRect  f=self.frame;
    f.size.height=height;
    self.frame=f;
}
- (void) setOrigin:(CGPoint)origin{
    CGRect  f=self.frame;
    f.origin=origin;
    self.frame=f;
}
- (void) setSize:(CGSize)size{
    CGRect f=self.frame;
    f.size=size;
    self.frame=f;
}

#pragma mark 获取宽高比
- (CGFloat) w_h_ratio{
    return self.frame.size.width/self.frame.size.height;
}

@end
