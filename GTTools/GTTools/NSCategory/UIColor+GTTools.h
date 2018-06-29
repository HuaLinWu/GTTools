//
//  UIColor+GTTools.h
//  GTTools
//
//  Created by 吴华林 on 2018/6/20.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import <UIKit/UIKit.h>

#define  GT_COLOR_RGB(r,g,b)         [UIColor gsColorWithRed:r green:g blue:b alpha:1.0f]
#define  GT_COLOR_RGBA(r,g,b,a)      [UIColor gsColorWithRed:r green:g blue:b alpha:a]
#define  GT_COLOR_HEX(color)         [UIColor colorWithHexString:color]
#define  GT_COLOR_HEXA(color,a)      [UIColor colorWithHexString:color Alpha:a]
@interface UIColor (GTTools)
/*
 *  十六进制生成颜色
 *  @param alpha 透明度
 */
+ (UIColor *)gt_colorWithHexString:(NSString *)color Alpha:(CGFloat) alpha;

/*
 *  十六进制生成颜色
 */
+ (UIColor *)gt_colorWithHexString:(NSString *)color;

/*
 *  @param red|green|blue > 1 自动除以255.0f
 *  @param red&green&blue <=1 取当前值
 */
+ (UIColor *)gt_colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

/**
 根据字节生成颜色
 */
+ (UIColor *)gt_colorWithChar:(char)RGB;

/**
 根据两个16进制颜色值来生成渐变色（个人建议少用，尽量用图片替代，这个方法很耗性能）

 @param size 需要使用渐变色的范围
 @param fromHexColor 起始色
 @param toHexColor 结束色
 @return 一个颜色值
 */
+ (UIColor *)gt_generateGraColorInSize:(CGSize)size fromHexColor:(NSString *)fromHexColor toHexColor:(NSString *)toHexColor;
@end
