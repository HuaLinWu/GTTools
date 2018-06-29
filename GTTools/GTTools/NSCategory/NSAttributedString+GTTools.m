//
//  NSAttributedString+GTTools.m
//  GTTools
//
//  Created by 吴华林 on 2018/6/29.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import "NSAttributedString+GTTools.h"
#import <UIKit/UIKit.h>
@implementation NSAttributedString (GTBounds)
- (CGRect)gt_boundingRectWithSize:(CGSize)size {
     NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
   return [self boundingRectWithSize:size options:options context:nil];
}
@end
