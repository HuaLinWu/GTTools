//
//  NSAttributedString+GTTools.h
//  GTTools
//
//  Created by 吴华林 on 2018/6/29.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGGeometry.h>
@interface NSAttributedString (GTBounds)

/**
 根据给定size 算出富文本的size

 @param size 限定的size
 @return 富文本的CGRect
 */
- (CGRect)gt_boundingRectWithSize:(CGSize)size;
@end

