//
//  CAGradientLayer+GTTools.h
//  GTTools
//
//  Created by 吴华林 on 2018/6/20.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
@class UIColor;
typedef NS_ENUM(NSInteger, GradientType){
    /*
     *  从左到右
     */
    GradientTypeLeftToRight = 0,
    /*
     *  从上到下
     */
    GradientTypeTopToBottom = 1,
    /*
     *  从左上到右下
     */
    GradientTypeULToLR = 2,
};
@interface CAGradientLayer (GTTools)
/**
 根据指定的size 和渐变色 以及渐变方向生成一个GradientLayer（这个layer的size 就是size）
 
 @param size GradientLayer 的size
 @param fromColor fromColor 起始渐变色
 @param toColor toColor 结束渐变色
 @param type 渐变类型（GradientType）
 @return CAGradientLayer
 */
+ (CAGradientLayer *)generateGraColor:(CGSize)size fromColor:(UIColor *)fromColor toColor:(UIColor *)toColor type:(GradientType)type;
/**
 根据指定的size 和渐变色 以及渐变方向生成一个GradientLayer（这个layer的size 就是size）
 
 @param size GradientLayer 的size
 @param fromColor 起始渐变色
 @param toColor 结束渐变色
 @param startPoint 开始渐变的坐标
 @param endPoint 结束渐变的坐标
 @return CAGradientLayer
 */
+ (CAGradientLayer *)generateGraColor:(CGSize)size fromColor:(UIColor *)fromColor toColor:(UIColor *)toColor startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

/**
 根据指定的size 和渐变色 以及渐变方向生成一个GradientLayer（这个layer的size 就是size）
 
 @param size GradientLayer 的size
 @param fromHexColor 起始渐变色
 @param toHexColor 结束渐变色
 @param type 渐变类型（GradientType）
 @return CAGradientLayer
 */
+ (CAGradientLayer *)generateGraColor:(CGSize)size fromHexColor:(NSString *)fromHexColor toHexColor:(NSString *)toHexColor type:(GradientType)type;

/**
 根据指定的size 和渐变色 以及渐变方向生成一个GradientLayer（这个layer的size 就是size）
 
 @param size GradientLayer 的size
 @param fromHexColor 起始渐变色
 @param toHexColor 结束渐变色
 @param startPoint 开始渐变的坐标
 @param endPoint 结束渐变的坐标
 @return CAGradientLayer
 */
+ (CAGradientLayer *)generateGraColor:(CGSize)size fromHexColor:(NSString *)fromHexColor toHexColor:(NSString *)toHexColor startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;


@end
