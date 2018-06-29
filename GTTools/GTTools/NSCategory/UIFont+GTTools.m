//
//  UIFont+GTTools.m
//  GTTools
//
//  Created by 吴华林 on 2018/6/29.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import "UIFont+GTTools.h"

@implementation UIFont (GTTools)
+ (UIFont *)gt_safeFontWithName:(NSString *)fontName size:(CGFloat)fontSize {
    UIFont *font = [UIFont fontWithName:fontName size:fontSize];
    if (!font) {
        font = [UIFont systemFontOfSize:fontSize];
    }
    return font;
}
@end
