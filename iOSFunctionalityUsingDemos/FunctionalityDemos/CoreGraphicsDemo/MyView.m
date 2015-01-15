//
//  MyView.m
//  CoreGraphicsTest
//
//  Created by 刘杰cjs on 14/12/23.
//  Copyright (c) 2014年 刘杰cjs. All rights reserved.
//
#import "MyView.h"
#define kRandomColor [UIColor colorWithHue:(arc4random() % 256 / 256.0 ) saturation:( arc4random() % 256 / 256.0 ) brightness:( arc4random() % 256 / 256.0 ) alpha:1];
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)
@implementation MyView
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    switch (_drawDemoId) {
#pragma mark ------------------------------------------------------------ 简单图形绘制 ------------------------------------------------------------
        #pragma mark 绘制直线
        case 11:{
            //添加多条直线
            CGPoint  points[] = {CGPointMake(20, 10),CGPointMake(100,10),CGPointMake(100,40),CGPointMake(110,30)};
            CGContextAddLines(context, points,4);
            //添加一条直线
            CGContextMoveToPoint(context, 0, 0);
            CGContextAddLineToPoint(context, 50, 50);
            CGContextStrokePath(context);
            break;
        }
        #pragma mark 绘制矩形
        case 12:{
            //添加一个
            CGContextAddRect(context, CGRectMake(50, 50, 100, 100));
            CGRect rects[]={CGRectMake(0, 0, 20, 20),CGRectMake(30, 0, 20, 20),CGRectMake(10, 40, 20, 20)};
            //添加多个
            CGContextAddRects(context,rects ,3);
            CGContextStrokePath(context);
            break;
        }
        #pragma mark 绘制弧线
        case 13:{
            //添加一个圆弧 第一种方式
            /*
             从起始点 (100,100) 连接一条线到 (50,100),
             再从 (50,100) 连接一条线到(150,50)
             圆弧与这两条线相切,然后设定一个半径，就可以确定这条圆弧了
             */
            CGContextMoveToPoint(context, 100, 100);
            CGContextAddArcToPoint(context, 50, 100, 50, 150, 50);
            
            
            //添加一个圆弧 第二种方式
            /*
                x1,y1 圆点坐标,
                radius 半径
                startAngle:开始的弧度
                endAngle:结束的弧度
                clockwise 0为顺时针，1为逆时针
             */
            CGContextAddArc(context, 100, 100, 20, 0* M_PI/ 180, 90* M_PI/ 180, 0);
            
            CGContextStrokePath(context);
            
            //注:If the current path already contains a subpath, Quartz appends a straight line segment from the current point to the starting point of the arc. If the current path is empty, Quartz creates a new subpath at the starting point for the arc and does not add the initial straight line segment
            //所以第二段的arc 和 第一段的arc会有一条线连接
            break;
        }
        #pragma mark 绘制曲线
        case 14:{
            //第一种类型曲线 cubic Bézier curve (三次方贝塞尔曲线，可以拥有多个控制点)
            //添加第一条
            CGContextMoveToPoint(context, 10, 50);
            /*
             cp1x,cp1y,cp2x,cp2y 控制点的x，y坐标
             x,y : 该条路径终点的坐标
             */
            CGContextAddCurveToPoint(context,30,20, 60,20, 300, 50);
            //添加第二条
            CGContextMoveToPoint(context, 10, 100);
            CGContextAddCurveToPoint(context,30,30,200,180, 300, 100);
            
            
            //第二种类型曲线 quadratic Bézier curve (二次方贝塞尔曲线,只有一个控制点)
            CGContextMoveToPoint(context, 10, 200);
            CGContextAddQuadCurveToPoint(context, 100,80, 300, 200);
            
            CGContextStrokePath(context);
            break;
        }
        #pragma mark 绘制椭圆
        case 15:{
            //用矩形确定一个椭圆
            CGContextAddEllipseInRect(context, CGRectMake(100, 50, 100, 50));
            CGContextStrokePath(context);
            break;
        }
        #pragma mark 快速绘制图形的方法
        case 16:{
            //快速绘制一个矩形 1
            CGContextStrokeRect(context, CGRectMake(10, 10, 50, 50));
            
            //快速绘制一个矩形 2
            /*
                width:当前要绘制的这个矩形的边的宽度
             */
            CGContextStrokeRectWithWidth(context, CGRectMake(90, 30, 50, 50), 20 );
            
            //快速绘制一个椭圆
            CGContextStrokeEllipseInRect(context, CGRectMake(160, 20, 100, 50));
            
            //快速添加多条线段
            //每两个元素确定一条线段的起始点
            CGPoint  points[] = {CGPointMake(20, 100),CGPointMake(100,100),CGPointMake(20,120),CGPointMake(80,120)};
            CGContextStrokeLineSegments(context, points, 4);
            
            //CGContextDrawPath 使用
            CGContextAddEllipseInRect(context, CGRectMake(100, 100, 100, 50));
            //该方法可以替代 CGContextStrokePath(context)
            CGContextDrawPath(context, kCGPathStroke);
            
            break;
        }
        #pragma mark 裁剪
        case 17:{
            //添加裁剪路径 (圆弧 和 矩形)
            CGContextAddArc(context, 50, 50, 20, 0* M_PI/ 180, 90* M_PI/ 180, 0);
            CGContextAddRect(context, CGRectMake(0, 0, 20, 20));
            CGContextClip(context);
            
            //添加一个矩形path
            CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
            CGContextAddRect(context, CGRectMake(0, 0, 200, 200));
            CGContextFillPath(context);
            break;
        }
        #pragma mark ------------------------------------------------------------ 影响描边的参数 ( Parameters That Affect Stroking )------------------------------------------------------------
        #pragma mark Line width (path的宽度)
        case 21:{
            //添加一条直线
            CGContextMoveToPoint(context, 10, 100);
            CGContextAddLineToPoint(context, 200, 100);
            //设置宽度
            CGContextSetLineWidth(context,10);
            CGContextStrokePath(context);
            break;
        }
        #pragma mark Line join (path连接处的样式)
        case 22:{
            //第一种 kCGLineJoinRound
            CGPoint  points[] = {CGPointMake(20, 10),CGPointMake(100,10),CGPointMake(20,50)};
            CGContextAddLines(context, points,3);
            CGContextSetLineWidth(context,10);
            CGContextSetLineJoin(context, kCGLineJoinRound);
            CGContextStrokePath(context);
            
            //第二种 kCGLineJoinBevel
            CGPoint  points2[] = {CGPointMake(20, 90),CGPointMake(100,90),CGPointMake(20,130)};
            CGContextAddLines(context, points2,3);
            CGContextSetLineJoin(context, kCGLineJoinBevel);
            CGContextStrokePath(context);
            
            //第三种 kCGLineJoinMiter 默认
            CGPoint  points3[] = {CGPointMake(20, 170),CGPointMake(100,170),CGPointMake(20,210)};
            CGContextAddLines(context, points3,3);
            CGContextSetLineJoin(context, kCGLineJoinMiter);
            CGContextStrokePath(context);
            break;
        }
        #pragma mark Line cap (path 端帽)
        case 23:{
            /*
             下面的 kCGLineCapButt 和 kCGLineCapRound 长度看起来是有一点不一样的 原因看注释
             */
            //kCGLineCapButt
            //Quartz squares off the stroke at the endpoint of the path. There is no projection beyond the end of the path.
            //Quartz 把path 的终点绘制成正方形，不会有投影超出path的终点
            CGContextMoveToPoint(context, 50, 50);
            CGContextAddLineToPoint(context, 250, 50);
            CGContextSetLineCap(context, kCGLineCapButt);
            CGContextSetLineWidth(context,30);
            CGContextStrokePath(context);
            
            //kCGLineCapRound  默认
            //Quartz extends the stroke beyond the endpoint of the path for a distance equal to half the line width. The extension is squared off.
            //Quartz 会有一个超出path终点的投影，超出的长度是path宽度的一半
            CGContextMoveToPoint(context, 50, 150);
            CGContextAddLineToPoint(context, 250, 150);
            CGContextSetLineCap(context, kCGLineCapRound);
            CGContextSetLineWidth(context,30);
            CGContextStrokePath(context);
            
            //kCGLineCapSquare
            CGContextMoveToPoint(context, 50, 100);
            CGContextAddLineToPoint(context, 250, 100);
            CGContextSetLineCap(context, kCGLineCapSquare);
            CGContextSetLineWidth(context,30);
            CGContextStrokePath(context);
                                
            //注：A closed subpath treats the starting point as a junction between connected line segments; the starting point is rendered using the selected line-join method. In contrast, if you close the path by adding a line segment that connects to the starting point, both ends of the path are drawn using the selected line-cap method.
            //一个闭合的路径会把当前路径各个线段的起始点作为连接处,此时,这个起始点会使用line-join的设置进行渲染。与其相对的，如果你通过添加一个连接起始点和结束点的线段的形式来使一个路径(path)闭合，那么这个path的所有线段的起始点和结束点就会使用line-cap的设置进行渲染
            
            break;
        }
        case 24:{
            /*
             phase:指定第一个线段开始点的x坐标 （相对于线段本身）
             lengths数组:每个线段的长度,交替使用有颜色的和没颜色的线段进行绘制
            */
            //第一条
            CGContextMoveToPoint(context, 10, 50);
            CGContextAddLineToPoint(context, 300, 50);
            CGFloat lens [] ={2,3};
            CGContextSetLineDash(context, 0,lens, 2);
            CGContextSetLineWidth(context, 10);
            CGContextStrokePath(context);
            
            //第二条
            CGContextMoveToPoint(context, 10, 80);
            CGContextAddLineToPoint(context, 300, 80);
            CGFloat lens2 [] ={20,10,5};
            CGContextSetLineDash(context, 0,lens2, 3);
            CGContextStrokePath(context);
            
            //第三条
            CGContextMoveToPoint(context, 10, 110);
            CGContextAddLineToPoint(context, 300, 110);
            CGFloat lens3 [] ={20,10};
            CGContextSetLineDash(context,10,lens3, 2);
            CGContextStrokePath(context);
            break;
        }
        #pragma mark ------------------------------------------------------------ 填充 (fill a path) ------------------------------------------------------------
        #pragma mark 填充一个path
        case 31:{
            //绘制一个椭圆
            CGContextAddEllipseInRect(context, CGRectMake(10, 10, 100, 50));
            
            
            //绘制自定义图形
            CGPoint points [] ={CGPointMake(130, 10),CGPointMake(200, 10),CGPointMake( 200, 60),CGPointMake( 165, 100),CGPointMake(130,60)};
            CGContextAddLines(context, points, 4);
            
            
            //设置填充色
            CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
            //填充
            CGContextFillPath(context);
            //CGContextDrawPath(context, kCGPathFill);//该方法也可
        }
        #pragma mark 快速填充方法
        case 32:{
            //填充一个矩形
            CGContextFillRect(context, CGRectMake(50, 50, 100, 50));
            CGRect rects[]={CGRectMake(0, 0, 20, 20),CGRectMake(30, 0, 20, 20),CGRectMake(10, 40, 20, 20)};
            //填充多个矩形
            CGContextFillRects(context, rects, 3 );
            //填充一个椭圆
            CGContextFillEllipseInRect(context, CGRectMake(100, 140, 100, 50));
            break;
        }
        #pragma mark 填充规则:onzero winding number rule(非零环绕数规则)
        case 33:{
            /*
                注意：根据填充规则，path的绘制方向也会影响填充效果
             详细规则描述请百度
             */
            //第一个同心圆
            //大圆
            CGContextAddArc(context, 80, 80, 70,  0* M_PI/ 180, 360* M_PI/ 180, 1);
            CGContextClosePath(context);
            CGContextMoveToPoint(context, 130, 80);
            //小圆
            CGContextAddArc(context,80,80,50, 0* M_PI/ 180, 360* M_PI/ 180, 0);
            CGContextClosePath(context);
            CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
            CGContextFillPath(context);
            //第二个同心圆
            //大圆
            CGContextAddArc(context, 240, 80, 70,  0* M_PI/ 180, 360* M_PI/ 180, 1);
            CGContextClosePath(context);
            CGContextMoveToPoint(context, 290, 80);
            //小圆
            CGContextAddArc(context,240,80,50, 0* M_PI/ 180, 360* M_PI/ 180, 1);
            CGContextClosePath(context);
            CGContextSetFillColorWithColor(context, [UIColor greenColor].CGColor);
            CGContextFillPath(context);
            break;
        }
        #pragma mark even-odd rule (奇-偶规则)
        case 34:{
            /*
             注意：根据填充规则，path的绘制方向也会影响填充效果
             详细规则描述请百度
             */
            //第一个同心圆
            //大圆
            CGContextAddArc(context, 80, 80, 70,  0* M_PI/ 180, 360* M_PI/ 180, 1);
            CGContextClosePath(context);
            CGContextMoveToPoint(context, 130, 80);
            //小圆
            CGContextAddArc(context,80,80,50, 0* M_PI/ 180, 360* M_PI/ 180, 0);
            CGContextClosePath(context);
            CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
            CGContextEOFillPath(context);
            //第二个同心圆
            //大圆
            CGContextAddArc(context, 240, 80, 70,  0* M_PI/ 180, 360* M_PI/ 180, 1);
            CGContextClosePath(context);
            CGContextMoveToPoint(context, 290, 80);
            //小圆
            CGContextAddArc(context,240,80,50, 0* M_PI/ 180, 360* M_PI/ 180, 1);
            CGContextClosePath(context);
            //设置使用 even-odd 规则填充
            CGContextSetFillColorWithColor(context, [UIColor greenColor].CGColor);
            CGContextEOFillPath(context);
            break;
        }
        #pragma mark  ------------------------------------------------------------ 混合模式 (Blend Modes) ------------------------------------------------------------
        #pragma mark 普通模式 (Normal Blend Mode)
        case 41:{
            //默认混合模式 Normal Blend Mode
            [self createRectsForTestBlendMode:context];
            break;
        }
        #pragma mark Multiply Blend Modes
        case 42:{
            /*
                Multiply blend mode specifies to multiply the foreground image samples with the background image samples. The resulting colors are at least as dark as either of the two contributing sample colors
               Multiply blend mode
             
             Multiply Blend Mode 混合了前景色和背景色。生成的颜色至少要与参与混合的颜色一样 或者 更黑 (more dark)
             */
            CGContextSetBlendMode(context, kCGBlendModeMultiply);
            [self createRectsForTestBlendMode:context];
            break;
        }
        #pragma mark Screen Blend Mode
        case 43:{
            /*
             Screen blend mode specifies to multiply the inverse of the foreground image samples with the inverse of the background image samples. The resulting colors are at least as light as either of the two contributing sample colors
             
             Screen blend mode 将前景色和后景色翻转后进行混合。生成的颜色至少要和它们的翻转色一样轻 或者 更轻(more light)
             */
            CGContextSetBlendMode(context, kCGBlendModeScreen);
            [self createRectsForTestBlendMode:context];
            break;
        }
        #pragma mark Overlay Blend Mode
        case 44:{
            /*
             Overlay blend mode specifies to either multiply or screen the foreground image samples with the background image samples, depending on the background color. The background color mixes with the foreground color to reflect the lightness or darkness of the background
             
             */
            CGContextSetBlendMode(context, kCGBlendModeOverlay);
            [self createRectsForTestBlendMode:context];
            break;
        }
        #pragma mark Darken Blend Mode
        case 45:{
            /*
             Specifies to create the composite image samples by choosing the darker samples (either from the foreground image or the background). The background image samples are replaced by any foreground image samples that are darker. Otherwise, the background image samples are left unchanged
             */
            CGContextSetBlendMode(context, kCGBlendModeDarken);
            [self createRectsForTestBlendMode:context];
            break;
        }
        #pragma mark Lighten Blend Mode
        case 46:{
            /*
             Specifies to create the composite image samples by choosing the lighter samples (either from the foreground or the background). The result is that the background image samples are replaced by any foreground image samples that are lighter. Otherwise, the background image samples are left unchanged.
             */
            CGContextSetBlendMode(context, kCGBlendModeLighten);
            [self createRectsForTestBlendMode:context];
            break;
        }
            
        #pragma mark Color Dodge Blend Mode
        case 47:{
            /*
             Specifies to brighten the background image samples to reflect the foreground image samples. Foreground image sample values that specify black do not produce a change
             */
            CGContextSetBlendMode(context, kCGBlendModeColorDodge);
            [self createRectsForTestBlendMode:context];
            break;
        }
            
        #pragma mark Color Burn Blend Mode
        case 48:{
            /*
             Specifies to darken the background image samples to reflect the foreground image samples. Foreground image sample values that specify white do not produce a change
             */
            CGContextSetBlendMode(context, kCGBlendModeColorBurn);
            [self createRectsForTestBlendMode:context];
            break;
        }
            
            
        #pragma mark Soft Light Blend Mode
        case 49:{
            /*
             Specifies to either darken or lighten colors, depending on the foreground image sample color. If the foreground image sample color is lighter than 50% gray, the background is lightened, similar to dodging. If the foreground image sample color is darker than 50% gray, the background is darkened, similar to burning. If the foreground image sample color is equal to 50% gray, the background is not changed. Image samples that are equal to pure black or pure white produce darker or lighter areas, but do not result in pure black or white. The overall effect is similar to what you’d achieve by shining a diffuse spotlight on the foreground image. Use this to add highlights to a scene.
             */
            CGContextSetBlendMode(context, kCGBlendModeSoftLight);
            [self createRectsForTestBlendMode:context];
            break;
        }
            
        #pragma mark Hard Light Blend Mode
        case 411:{
            /*
             Specifies to either multiply or screen colors, depending on the foreground image sample color. If the foreground image sample color is lighter than 50% gray, the background is lightened, similar to screening. If the foreground image sample color is darker than 50% gray, the background is darkened, similar to multiplying. If the foreground image sample color is equal to 50% gray, the foreground image is not changed. Image samples that are equal to pure black or pure white result in pure black or white. The overall effect is similar to what you’d achieve by shining a harsh spotlight on the foreground image. Use this to add highlights to a scene.
             */
            CGContextSetBlendMode(context, kCGBlendModeHardLight);
            [self createRectsForTestBlendMode:context];
            break;
        }
            
        #pragma mark Difference Blend Mode
        case 412:{
            /*
             Specifies to subtract either the foreground image sample color from the background image sample color, or the reverse, depending on which sample has the greater brightness value. Foreground image sample values that are black produce no change; white inverts the background color values.
             */
            CGContextSetBlendMode(context, kCGBlendModeDifference);
            [self createRectsForTestBlendMode:context];
            break;
        }
            
        #pragma mark Exclusion Blend Mode
        case 413:{
            /*
             Specifies an effect similar to that produced by kCGBlendModeDifference, but with lower contrast. Foreground image sample values that are black don’t produce a change; white inverts the background color values
             */
            CGContextSetBlendMode(context, kCGBlendModeExclusion);
            [self createRectsForTestBlendMode:context];
            break;
        }
            
        #pragma mark Hue Blend Mode
        case 414:{
            /*
             Specifies to use the luminance and saturation values of the background with the hue of the foreground image
             */
            CGContextSetBlendMode(context, kCGBlendModeHue);
            [self createRectsForTestBlendMode:context];
            break;
        }
            
        #pragma mark Saturation Blend Mode
        case 415:{
            /*
             Specifies to use the luminance and hue values of the background with the saturation of the foreground image. Areas of the background that have no saturation (that is, pure gray areas) don’t produce a change
             */
            CGContextSetBlendMode(context, kCGBlendModeSaturation);
            [self createRectsForTestBlendMode:context];
            break;
        }
            
        #pragma mark Color Blend Mode
        case 416:{
            /*
             Specifies to use the luminance values of the background with the hue and saturation values of the foreground image. This mode preserves the gray levels in the image. You can use this mode to color monochrome images or to tint color images.
             */
            CGContextSetBlendMode(context, kCGBlendModeColor);
            [self createRectsForTestBlendMode:context];
            break;
        }
        #pragma mark Luminosity Blend Mode
        case 417:{
            /*
             Specifies to use the hue and saturation of the background with the luminance of the foreground image. This mode creates an effect that is inverse to the effect created by kCGBlendModeColor.
             */
            CGContextSetBlendMode(context, kCGBlendModeLuminosity);
            [self createRectsForTestBlendMode:context];
            break;
        }
        #pragma mark  ------------------------------------------------------------ Transforms (变换) ------------------------------------------------------------
        #pragma mark Translation(平移)
        /*
         CTM:current transformation matrix 当前变换矩阵 （将 device space coordinates 映射到 user space coordinates的一个矩阵）
         Quartz 2D 提供了一系列方法修改CTM ，修改的结果就是  user space coordinates 进行相应的变化。
         iOS中，user space coordinates 就是以左上角为原点，向右为x增长，向下为y增长。
         */
        case 51:{
            //注：此时移动的是用户坐标系(user space)，即ios布局中的默认坐标系统。 向右移20单位 向下移动20单位
            
            //平移前添加一个矩形
            CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
            CGContextFillRect(context, CGRectMake(0, 0, 100, 100));
            //平移坐标系
            CGContextTranslateCTM(context, 20,20);
            //平移后添加一个矩形(坐标与之前相同)
            CGContextSetFillColorWithColor(context, [UIColor greenColor].CGColor);
            CGContextFillRect(context, CGRectMake(0, 0, 100, 100));
            break;
        }
        #pragma mark Rotation(旋转)
        case 52:{
            //添加一个rect 旋转前的
            CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
            CGContextFillRect(context, CGRectMake(150,50, 100, 100));
            //旋转坐标系
            CGContextRotateCTM(context, kDegreesToRadians(30));
            //添加一个rect 旋转后的(坐标与之前相同)
            CGContextSetFillColorWithColor(context, [UIColor greenColor].CGColor);
            CGContextFillRect(context, CGRectMake(150,50, 100, 100));
            break;
        }
        #pragma mark Scaling(缩放)
        case 53:{
            //在正常坐标系中添加一个rect
            CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
            CGContextFillRect(context, CGRectMake(0, 0, 100, 100));
            //缩放坐标系
            CGContextScaleCTM(context, 1.2, 1.2);
            //添加一个rect(宽度与之前相同)
            CGContextSetFillColorWithColor(context, [UIColor greenColor].CGColor);
            CGContextFillRect(context, CGRectMake(150, 0, 100, 100));
            /*
             两个rect在不用的坐标系下显示出来的宽度不一样
             */
            break;
        }
        #pragma mark Translation2(平移2)
        case 54:{
            //首先平移坐标系后添加一个红色矩形
            CGAffineTransform tf1 = CGAffineTransformMakeTranslation(20, 20);
            CGContextConcatCTM(context, tf1);
            CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
            CGContextFillRect(context, CGRectMake(0, 0, 100, 100));
            
            //再原先基础上继续平移坐标系 添加一个黄色矩形
            CGAffineTransform tf2 = CGAffineTransformTranslate(tf1, 20, 20);
            CGContextConcatCTM(context, tf2);
            CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
            CGContextFillRect(context, CGRectMake(0, 0, 100, 100));
            break;
        }
        #pragma mark Rotation2(旋转2)
        case 55:{
            //首先旋转坐标系后添加一个红色矩形
            CGAffineTransform tf1 = CGAffineTransformMakeRotation(kDegreesToRadians(30));
            CGContextConcatCTM(context, tf1);
            CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
            CGContextFillRect(context, CGRectMake(100, 0, 100, 100));
            
            //再原先基础上继续旋转坐标系 添加一个黄色矩形
            CGAffineTransform tf2 = CGAffineTransformRotate(tf1, kDegreesToRadians(10));
            CGContextConcatCTM(context, tf2);
            CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
            CGContextFillRect(context, CGRectMake(100, 0, 100, 100));
            break;
        }
        #pragma mark Scaling2(缩放2)
        case 56:{
            //首先缩放坐标系后添加一个红色矩形
            CGAffineTransform tf1 = CGAffineTransformMakeScale(1.2, 1.2);
            CGContextConcatCTM(context, tf1);
            CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
            CGContextFillRect(context, CGRectMake(0, 0, 100, 100));
            
            //再原先基础上继续缩放坐标系 添加一个黄色矩形
            CGAffineTransform tf2 = CGAffineTransformScale(tf1, 1.2, 1.2);
            CGContextConcatCTM(context, tf2);
            CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
            CGContextFillRect(context, CGRectMake(100, 0, 100, 100));
            break;
        }
        #pragma mark Invert(翻转)
        case 57:{
            /*
             CGAffineTransformInvert 用于计算得到某个变换矩阵的逆向矩阵
             */
            //首相缩放坐标系 1.2倍后添加一个红色矩形
            CGAffineTransform tf1 = CGAffineTransformMakeScale(2, 2);
            CGContextConcatCTM(context, tf1);
            CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
            CGContextFillRect(context, CGRectMake(0, 0, 100, 100));
            
            //翻转缩放的变换 添加一个黄色的矩形
            CGAffineTransform invertTf1 = CGAffineTransformInvert(tf1);
            CGContextConcatCTM(context, invertTf1);
            CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
            CGContextFillRect(context, CGRectMake(0, 0, 100, 100));
            break;
        }
        #pragma mark 变换坐标计算
        case 58:{
            CGRect r = CGRectMake(0, 0, 100, 100);
            CGPoint p= CGPointMake(100, 100);
            CGSize s = CGSizeMake(100,100);
            
            //Translation
            CGAffineTransform tf1 = CGAffineTransformMakeTranslation(50, 50);
            //Rotation
            CGAffineTransform tf2 = CGAffineTransformMakeRotation(kDegreesToRadians(90));
            //Scale
            CGAffineTransform tf3 = CGAffineTransformMakeScale(1.2, 1.2);
            
            
            CGRect rectAfterTranslation =  CGRectApplyAffineTransform(r, tf1);
            CGRect rectAfterRotation =  CGRectApplyAffineTransform(r, tf2);
            CGRect rectAfterScale =  CGRectApplyAffineTransform(r, tf3);
            
            
            CGPoint pointAfterTranslation = CGPointApplyAffineTransform(p, tf1);
            CGPoint pointAfterRotation = CGPointApplyAffineTransform(p, tf2);
            CGPoint pointAfterScale = CGPointApplyAffineTransform(p, tf3);
            
            
            CGSize sizeAfterTranslation = CGSizeApplyAffineTransform(s, tf1);
            CGSize sizeAfterRotation = CGSizeApplyAffineTransform(s, tf2);
            CGSize sizeAfterScale = CGSizeApplyAffineTransform(s, tf3);
           
            NSLog(@"------------------------------------ 变换坐标计算 ------------------------------------");
            NSLog(@"变换前rect:%@", NSStringFromCGRect(r));
            NSLog(@"Translation 变换后rect:%@", NSStringFromCGRect(rectAfterTranslation));
            NSLog(@"Rotation 变换后rect:%@", NSStringFromCGRect(rectAfterRotation));
            NSLog(@"Scale 变换后rect:%@", NSStringFromCGRect(rectAfterScale));
            NSLog(@"\n");
            
            NSLog(@"变换前point:%@", NSStringFromCGPoint(p));
            NSLog(@"Translation 变换后point:%@", NSStringFromCGPoint(pointAfterTranslation));
            NSLog(@"Rotation 变换后point:%@", NSStringFromCGPoint(pointAfterRotation));
            NSLog(@"Scale 变换后point:%@", NSStringFromCGPoint(pointAfterScale));
            NSLog(@"\n");
            
            NSLog(@"变换前size:%@", NSStringFromCGSize(s));
            NSLog(@"Translation 变换后size:%@", NSStringFromCGSize(sizeAfterTranslation));
            NSLog(@"Rotation 变换后size:%@", NSStringFromCGSize(sizeAfterRotation));
            NSLog(@"Scale 变换后size:%@", NSStringFromCGSize(sizeAfterScale));
            
            /*
             平移、旋转的size 是不变的 Rotation 计算出来的可能会有问题 可以无视
             */
        }
        #pragma mark Transforms比较、恒等变换
        case 59:{
            //判断是否相等
            CGAffineTransform tf1 = CGAffineTransformMakeTranslation(50, 50);
            CGAffineTransform tf2 = CGAffineTransformMakeTranslation(50, 50);
            if (CGAffineTransformEqualToTransform(tf1, tf2)) {
                NSLog(@"tf1 和 tf2 相等");
            }else{
                NSLog(@"tf1 和 tf2 不相等");
            }
            //判断是否是恒等变换
            CGAffineTransform tf3 = CGAffineTransformMakeScale(1, 1);
            CGAffineTransform tf4 = CGAffineTransformMakeScale(1, 1.1);
            if (CGAffineTransformEqualToTransform(tf3, CGAffineTransformIdentity)) {
                NSLog(@"tf3 是恒等变换");
            }else{
                NSLog(@"tf3 不是恒等变换");
            }
            if (CGAffineTransformEqualToTransform(tf4, CGAffineTransformIdentity)) {
                NSLog(@"tf4 是恒等变换");
            }else{
                NSLog(@"tf4 不是恒等变换");
            }
            /*
             The identity transform performs no translation, scaling, or rotation. Applying this transform to the input coordinates always returns the input coordinates. The Quartz constant CGAffineTransformIdentity represents the identity transform.
             总结：恒等变换不会对坐标系统产生任何影响。
             */
            break;
        }
        #pragma mark 设备坐标系统相关
        case 511:{
            NSLog(@"请查看 %@.m 中 %d 行开始的相关描述",NSStringFromClass([self class]),__LINE__);
            //获取用于 用户坐标系统到设备坐标系统转换的 变换矩阵
            //CGContextGetUserSpaceToDeviceSpaceTransform(context);
            //不同坐标系统间相关转换方法
            //CGContextConvertPointToDeviceSpace
            //CGContextConvertPointToUserSpace
            //CGContextConvertSizeToDeviceSpace
            //CGContextConvertSizeToUserSpace
            //CGContextConvertRectToDeviceSpace
            //CGContextConvertRectToUserSpace
            break;
        }
        #pragma mark  ------------------------------------------------------------ Pattern ------------------------------------------------------------
        #define H_PATTERN_SIZE 100
        #define V_PATTERN_SIZE 50
        #pragma mark Painting Colored Patterns
        case 61:{
            static const CGPatternCallbacks callbacks = {0,
                &myDrawColoredPattern,
                NULL};
            //创建一个 ColorSpace
            //Sets the fill color space to the pattern color space. If you are stroking your pattern, call CGContextSetStrokeColorSpace
            CGColorSpaceRef patternSpace = CGColorSpaceCreatePattern (NULL);// 6
        
            CGContextSetFillColorSpace (context, patternSpace);
            
            CGColorSpaceRelease (patternSpace);
            /*
             info: 传递给 DrawPatternCallback 回调方法的自定义参数
             bounds: pattern cell 边界的宽高。绘图系统会按这个宽高将超过的部分裁剪。
             matrix: 表示一个从pattern space 到 user space 的转换矩阵。如果不需要转换，则传递一个恒等矩阵 (identity matrix)
             xStep:pattern cell 水平位移。如果cell之间不想要有额外的间距，则传递cell的宽度即可。
             yStep:同 xStep,方向变为垂直方向。
             tiling: CGPatternTiling 常量。平铺的方式。
             isColored:指定 pattern cell 是一个colored pattern cell 还是一个 stencil pattern cell。如果你指定为True，pattern绘制时会回调你指定的 pattern color，同时，你也必须设置 pattern color space。
             callbacks:一个结构体。
                version：结构体的版本号，此处应设置为0
                drawPattern：patter的绘制回调方法。
                releaseInfo：当 CGPattern 对象被释放的时候会回调该方法，你可以在此方法中释放先前传递给pattern 绘制回调方法的自定参数（info），如果不需要释放任何东西，你可以将其设置为NULL。
             */
            CGPatternRef pattern = CGPatternCreate (NULL,
                                       
                                       CGRectMake (0, 0, H_PATTERN_SIZE, V_PATTERN_SIZE),
                                       
                                       CGAffineTransformIdentity,
                                       
                                       H_PATTERN_SIZE,
                                       
                                       V_PATTERN_SIZE,
                                       
                                       kCGPatternTilingConstantSpacing,
                                       
                                       true,
                                       
                                       &callbacks);
            CGFloat alpha = 1;
            CGContextSetFillPattern (context, pattern, &alpha);
            CGPatternRelease (pattern);
            //设置pattern 填充区域
            CGContextFillRect (context, CGRectMake(0, 0, 200, 200));
        
        }
        #pragma mark Painting Stencil Patterns
        case 62:{
            CGPatternRef pattern;
            
            CGColorSpaceRef baseSpace;
            
            CGColorSpaceRef patternSpace;
            
            static const CGFloat color[4] = { 0, 1, 0, 1 };
            
            static const CGPatternCallbacks callbacks = {0, &myDrawStencilPattern, NULL};// 2
            
            baseSpace = CGColorSpaceCreateDeviceRGB ();
            
            patternSpace = CGColorSpaceCreatePattern (baseSpace);
            
            CGContextSetFillColorSpace (context, patternSpace);
            
            CGColorSpaceRelease (patternSpace);
            
            CGColorSpaceRelease (baseSpace);
            
            pattern = CGPatternCreate(NULL, CGRectMake(0, 0, H_PATTERN_SIZE , V_PATTERN_SIZE),
                                      
                                      CGAffineTransformIdentity, H_PATTERN_SIZE, V_PATTERN_SIZE,
                                      
                                      kCGPatternTilingConstantSpacing,
                                      
                                      NO, &callbacks);
            
            CGContextSetFillPattern (context , pattern, color);
            
            CGPatternRelease (pattern);
            
            CGContextFillRect (context,CGRectMake (0,0,200,200));
            break;
        }
        #pragma mark  ------------------------------------------------------------ Shadow (阴影) ------------------------------------------------------------
        case 71:{
            
            //CGContextSetShadow(context, CGSizeMake(10, 10), 1);
            CGContextSetShadowWithColor(context, CGSizeMake(10,10),6, [UIColor redColor].CGColor );
            
            CGContextSetFillColorWithColor(context, [UIColor greenColor].CGColor);
            CGContextFillRect(context,  CGRectMake(0,0,50,50));
            break;
        }
        #pragma mark  ------------------------------------------------------------ Gradients (渐变) ------------------------------------------------------------
        #pragma mark LinearGradient(线性渐变)
        case 81:{
            NSArray * colorArrs = @[(id)[UIColor redColor].CGColor,(id)[UIColor greenColor].CGColor,(id)[UIColor blueColor].CGColor];
            //存放颜色数组中每个颜色要填充的位置  0~1 ,代表距离起始点的比例
            //注:此时起始点颜色不是从0开始1结束 下文中 CGGradientDrawingOptions 参数可以进行
            CGFloat colorLocations[3] = {0.2, 0.5,0.8};
            CGColorSpaceRef myColorspace = CGColorSpaceCreateDeviceRGB();
          
            
            
            //注意 color 数组中存放的必须是CGColor
            CGGradientRef myGradient = CGGradientCreateWithColors(myColorspace, (__bridge CFArrayRef )colorArrs, colorLocations);
            //或者使用以下方法 , CGGradientCreateWithColors 相对 CGGradientCreateWithColorComponents 更加方便快捷
            //CGGradientRef myGradient = CGGradientCreateWithColorComponents(myColorspace, components, locations, 2);
            
            /*
              startPoint:线性渐变的开始点坐标
              endPoint:线性渐变的结束点坐标
             CGGradientDrawingOptions:如果起始颜色不是从起始点开始的，那么这个参数指定了 超过起点或结束点位置的部分是不是要用相应的起始点颜色进行绘制 (0表示既不延伸起始点也不延伸结束点)
             */
            CGContextDrawLinearGradient(context, myGradient,CGPointMake(50, 50),CGPointMake(150,150), 0);
            break;
        }
        #pragma mark RadialGradient(径向渐变)
        case 82:{
            NSArray * colorArrs = @[(id)[UIColor redColor].CGColor,(id)[UIColor greenColor].CGColor,(id)[UIColor blueColor].CGColor];
            //存放颜色数组中每个颜色要填充的位置  0~1 ,代表距离起始点的比例
            //注:此时起始点颜色不是从0开始1结束 下文中 CGGradientDrawingOptions 参数可以进行
            CGFloat colorLocations[3] = {0, 0.5,1};
            CGColorSpaceRef myColorspace = CGColorSpaceCreateDeviceRGB();
            
            //注意 color 数组中存放的必须是CGColor
            CGGradientRef myGradient = CGGradientCreateWithColors(myColorspace, (__bridge CFArrayRef )colorArrs, colorLocations);
            //或者使用以下方法, CGGradientCreateWithColors 相对 CGGradientCreateWithColorComponents 更加方便快捷
            //CGGradientRef myGradient = CGGradientCreateWithColorComponents(myColorspace, components, locations, 2);
            CGContextDrawRadialGradient(context, myGradient, CGPointMake(50,50), 20, CGPointMake(100, 100), 50, 0);
            break;
        }
        #pragma mark  ------------------------------------------------------------ Transparency Layer ------------------------------------------------------------
        #pragma mark Transparency Layer
        case 91:{
            CGSize myShadowOffset = CGSizeMake (10, -20);// 2
            CGContextSetShadow (context, myShadowOffset, 10);   // 3
            CGContextBeginTransparencyLayer (context, NULL);
            
            CGContextFillRect (context, CGRectMake (50,50,100,100));
            CGContextFillRect (context,CGRectMake(100, 100, 100, 100));
            CGContextEndTransparencyLayer (context);
            break;
        }
        #pragma mark  ------------------------------------------------------------ Layer Drawing ------------------------------------------------------------
        #pragma mark Layer Drawing
        case 101:{
            //创建一个 大小 100x100 的 layer
            CGLayerRef myLayer = CGLayerCreateWithContext(context, CGSizeMake(100, 100), NULL);
            //获取layer 的 context
            CGContextRef myLayerContext = CGLayerGetContext(myLayer);
            CGContextSetFillColorWithColor(myLayerContext, [UIColor redColor].CGColor);
            //绘制图形到layer上
            CGContextFillRect(myLayerContext, CGRectMake(0, 0, 20, 20));
            CGContextFillRect(myLayerContext, CGRectMake(80,80, 100, 100));
            /*
                将layer绘制到指定的point位置
             */
            //CGContextDrawLayerAtPoint(context, CGPointMake(10, 10), myLayer);
            /*
                将layer绘制到指定的矩形中，layer会拉伸或压缩以适应指定的矩形。
             */
            CGContextDrawLayerInRect(context, CGRectMake(0, 0, 320, 240), myLayer);
            
            break;
        }
    }
}
#pragma mark  Color pattern cell 绘制回调
void myDrawColoredPattern (void *info, CGContextRef myContext)

{
    CGFloat dimension  = 5; // the pattern cell itself is 16 by 18
    CGRect  myRect1 = {{0,0}, {dimension, dimension}},
    myRect2 = {{dimension, dimension}, {dimension, dimension}},
    myRect3 = {{0,dimension}, {dimension, dimension}},
    myRect4 = {{dimension,0}, {dimension, dimension}},
    myRect5 = {{dimension*2,0}, {dimension, dimension}};
    
    CGContextSetFillColorWithColor(myContext, [UIColor redColor].CGColor);
    CGContextFillRect (myContext, myRect1);
    
    CGContextSetFillColorWithColor(myContext, [UIColor greenColor].CGColor);
    CGContextFillRect (myContext, myRect2);
    
    CGContextSetFillColorWithColor(myContext, [UIColor blueColor].CGColor);
    CGContextFillRect (myContext, myRect3);
    
    CGContextSetFillColorWithColor(myContext, [UIColor yellowColor].CGColor);
    CGContextFillRect (myContext, myRect4);
    
    CGContextSetFillColorWithColor(myContext, [UIColor blackColor].CGColor);
    CGContextFillRect (myContext, myRect5);
    
    //将pattern cell的边界画出
    CGContextSetStrokeColorWithColor(myContext, [UIColor redColor].CGColor);
    CGContextStrokeRect(myContext, CGRectMake(0, 0, H_PATTERN_SIZE, V_PATTERN_SIZE));
}
#pragma mark  Stencil pattern cell 绘制回调
void myDrawStencilPattern (void *info, CGContextRef myContext)

{
   
    CGPoint points[]={CGPointMake(10, 10),CGPointMake(20, 0),CGPointMake(30, 10)};
    CGContextAddLines(myContext, points, 3);
    CGContextClosePath(myContext);
   
    CGContextFillPath(myContext);
    //将pattern cell的边界画出
    CGContextSetStrokeColorWithColor(myContext, [UIColor redColor].CGColor);
    CGContextStrokeRect(myContext, CGRectMake(0, 0, H_PATTERN_SIZE, V_PATTERN_SIZE));
}
#pragma mark 测试 BlendMode 时用的方法 生成一系列各种颜色的矩形
- (void) createRectsForTestBlendMode:(CGContextRef)context{
    //水平方向 从左到右 红 橙 黄 绿 蓝
    CGContextSetFillColorWithColor(context,[UIColor redColor].CGColor);
    CGContextFillRect(context, CGRectMake(35, 0, 50, 240));
    CGContextSetFillColorWithColor(context,[UIColor orangeColor].CGColor);
    CGContextFillRect(context, CGRectMake(85, 0, 50, 240));
    CGContextSetFillColorWithColor(context,[UIColor yellowColor].CGColor);
    CGContextFillRect(context, CGRectMake(135, 0, 50, 240));
    CGContextSetFillColorWithColor(context,[UIColor greenColor].CGColor);
    CGContextFillRect(context, CGRectMake(185, 0, 50, 240));
    CGContextSetFillColorWithColor(context,[UIColor blueColor].CGColor);
    CGContextFillRect(context, CGRectMake(235, 0, 50, 240));
    
    //垂直方向 从上到下 红 橙 黄 绿
    CGContextSetFillColorWithColor(context,[UIColor redColor].CGColor);
    CGContextFillRect(context, CGRectMake(0, 20, 320, 50));
    CGContextSetFillColorWithColor(context,[UIColor orangeColor].CGColor);
    CGContextFillRect(context, CGRectMake(0,70, 320, 50));
    CGContextSetFillColorWithColor(context,[UIColor yellowColor].CGColor);
    CGContextFillRect(context, CGRectMake(0, 120, 320, 50));
    CGContextSetFillColorWithColor(context,[UIColor greenColor].CGColor);
    CGContextFillRect(context, CGRectMake(0, 170, 320, 50));
    
    
}
- (void)setDrawDemoId:(NSInteger)drawDemoId{
    _drawDemoId = drawDemoId;
    [self setNeedsDisplay];
}

@end
