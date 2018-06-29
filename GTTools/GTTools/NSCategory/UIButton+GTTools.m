//
//  UIButton+GTTools.m
//  GTTools
//
//  Created by 吴华林 on 2018/6/29.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import "UIButton+GTTools.h"

@implementation UIButton (GTTools)
- (void)gt_setLayout:(GTUIButtonLayoutStyle )aLayoutStyle
             spacing:(CGFloat)aSpacing
{
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    
    CGFloat totalHeight = (imageSize.height + titleSize.height + aSpacing);
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets titleEdgeInsets = UIEdgeInsetsZero;
    if (aLayoutStyle == GSImageLeftTitleRightStyle) {
        imageEdgeInsets = UIEdgeInsetsMake(0, -(aSpacing / 2.0f), 0, 0 );
        titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, - (aSpacing / 2.0f));
    }
    else if (aLayoutStyle == GSTitleLeftImageRightStyle) {
        imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -(titleSize.width * 2 + aSpacing / 2.0f));
        titleEdgeInsets = UIEdgeInsetsMake(0, -(imageSize.width * 2 + aSpacing / 2.0f), 0, 0);
    }else if (aLayoutStyle == GSImageTopTitleBottomStyle){
        imageEdgeInsets = UIEdgeInsetsMake( -(totalHeight - imageSize.height),
                                           0.0,
                                           0.0,
                                           - titleSize.width);
        titleEdgeInsets  = UIEdgeInsetsMake(0.0,
                                            -imageSize.width,
                                            - (totalHeight - titleSize.height),
                                            0.0);
    }else if (aLayoutStyle == GSTitleTopImageBottomStyle){
        imageEdgeInsets = UIEdgeInsetsMake(0.0,
                                           0.0,
                                           -(totalHeight - imageSize.height),
                                           - titleSize.width);
        
        titleEdgeInsets = UIEdgeInsetsMake(-(totalHeight - titleSize.height),
                                           0.0,
                                           -imageSize.width,
                                           0.0);
    }
    self.imageEdgeInsets = imageEdgeInsets;
    self.titleEdgeInsets = titleEdgeInsets;
}

@end
