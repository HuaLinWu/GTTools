//
//  UIButton+GTTools.h
//  GTTools
//
//  Created by 吴华林 on 2018/6/29.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, GTUIButtonLayoutStyle) {
    GSImageLeftTitleRightStyle = 0, //默认的方式 image左 title右
    GSTitleLeftImageRightStyle = 1, // image右,title左
    GSImageTopTitleBottomStyle = 2, //image上，title下
    GSTitleTopImageBottomStyle = 3, // image下,title上
};
@interface UIButton (GTTools)
/**
 功能:设置UIButton的布局，图片和文字按照指定方向显示
 
 @param aLayoutStyle       参见HJUIButtonLayoutStyle
 @param aSpacing            图片和文字之间的间隔
 */
- (void)gt_setLayout:(GTUIButtonLayoutStyle )aLayoutStyle
          spacing:(CGFloat)aSpacing;
@end
