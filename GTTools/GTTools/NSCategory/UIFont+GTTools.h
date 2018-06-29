//
//  UIFont+GTTools.h
//  GTTools
//
//  Created by 吴华林 on 2018/6/29.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (GTTools)

/**
 如果系统不支持的指定的字体（将会使用系统默认的）

 @param fontName 字体名字
 @param fontSize 字体大小
 @return font
 */
+ (UIFont *)gt_safeFontWithName:(NSString *)fontName size:(CGFloat)fontSize;
@end
