//
//  UIColor+GTTools.m
//  GTTools
//
//  Created by 吴华林 on 2018/6/20.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import "UIColor+GTTools.h"
#import "CAGradientLayer+GTTools.h"
@implementation UIColor (GTTools)
+ (UIColor *)gt_colorWithHexString:(NSString *)color Alpha:(CGFloat)alpha{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:alpha];
}

+ (UIColor *)gt_colorWithHexString:(NSString *)color{
    return [self gt_colorWithHexString:color Alpha:1.0f];
}

+ (UIColor *)gt_colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha{
    if (red >1 || green >1 || blue >1) {
        red = red/255.0f;
        green = green/255.0f;
        blue = blue/255.0f;
    }
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor *)gt_colorWithChar:(char)RGB{
    unsigned long ulRGB = (unsigned long)RGB;
    long fRed = ( (((ulRGB >> 5) % 8) << 3) + ((ulRGB >> 5) % 8) - 4  ) * 4;
    long fGreen = ( (((ulRGB >> 2) % 8) << 3) + ((ulRGB >> 2) % 8) - 4  ) * 4;
    long fBlue = ( ((ulRGB % 4) << 4) + ((ulRGB % 4) << 2) + (ulRGB % 4)  - 10 ) * 4;
    return [UIColor colorWithRed: fRed / 255.f green: fGreen / 255.f blue: fBlue / 255.f alpha:1.0f];
}
+ (UIColor *)gt_generateGraColorInSize:(CGSize)size fromHexColor:(NSString *)fromHexColor toHexColor:(NSString *)toHexColor {
    
    CAGradientLayer *gradientLayer = [CAGradientLayer generateGraColor:size fromHexColor:fromHexColor toHexColor:toHexColor type:GradientTypeLeftToRight];
    UIGraphicsBeginImageContextWithOptions(gradientLayer.bounds.size,NO, [UIScreen mainScreen].scale);
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *backgroundColorImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return [UIColor colorWithPatternImage:backgroundColorImage];
}
@end
