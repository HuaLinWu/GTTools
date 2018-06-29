//
//  CAGradientLayer+GTTools.m
//  GTTools
//
//  Created by 吴华林 on 2018/6/20.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import "CAGradientLayer+GTTools.h"
#import "UIColor+GTTools.h"
@implementation CAGradientLayer (GTTools)
+ (CAGradientLayer *)generateGraColor:(CGSize)size fromColor:(UIColor *)fromColor toColor:(UIColor *)toColor type:(GradientType)type {
    switch (type) {
        case GradientTypeLeftToRight:
            return [self generateGraColor:size fromColor:fromColor toColor:toColor startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5)];
            break;
        case GradientTypeTopToBottom:
            return [self generateGraColor:size fromColor:fromColor toColor:toColor startPoint:CGPointMake(0.5, 0) endPoint:CGPointMake(0.5, 1)];
            break;
        case GradientTypeULToLR:
            return [self generateGraColor:size fromColor:fromColor toColor:toColor startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 1)];
            break;
        default:
            break;
    }
    return nil;
}

+ (CAGradientLayer *)generateGraColor:(CGSize)size fromColor:(UIColor *)fromColor toColor:(UIColor *)toColor startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint{
    //CAGradientLayer类对其绘制渐变背景颜色、填充层的形状(包括圆角)
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, size.width, size.height);
    
    //创建渐变色数组，需要转换为CGColor颜色
    gradientLayer.colors = @[(__bridge id)fromColor.CGColor,(__bridge id)toColor.CGColor];
    //设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
    gradientLayer.startPoint = startPoint;
    gradientLayer.endPoint = endPoint;
    
    //设置颜色变化点，取值范围 0.0~1.0
    gradientLayer.locations = @[@0,@1];
    
    return gradientLayer;
}

+ (CAGradientLayer *)generateGraColor:(CGSize)size fromHexColor:(NSString *)fromHexColor toHexColor:(NSString *)toHexColor type:(GradientType)type {
    
    UIColor *fromColor = [UIColor gt_colorWithHexString:fromHexColor];
    UIColor *toColor = [UIColor gt_colorWithHexString:toHexColor];
    return [self generateGraColor:size fromColor:fromColor toColor:toColor type:type];
}

+ (CAGradientLayer *)generateGraColor:(CGSize)size fromHexColor:(NSString *)fromHexColor toHexColor:(NSString *)toHexColor startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    
    UIColor *fromColor = [UIColor gt_colorWithHexString:fromHexColor];
    UIColor *toColor = [UIColor gt_colorWithHexString:toHexColor];
    return [self generateGraColor:size fromColor:fromColor toColor:toColor startPoint:startPoint endPoint:endPoint];
}

@end
