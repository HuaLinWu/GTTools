//
//  UIView+GTTools.h
//  GTTools
//
//  Created by 吴华林 on 2018/6/21.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (GTFrame)
@property(nonatomic,assign)CGFloat x;
@property(nonatomic,assign,readonly)CGFloat midx;
@property(nonatomic,assign,readonly)CGFloat maxx;
@property(nonatomic,assign)CGFloat y;
@property(nonatomic,assign,readonly)CGFloat midy;
@property(nonatomic,assign,readonly)CGFloat maxy;
@property(nonatomic,assign)CGFloat width;
@property(nonatomic,assign)CGFloat height;
@property(nonatomic,assign)CGSize size;
@property(nonatomic,assign)CGPoint origin;
@end

@interface UIView (GTShape)

/**
 设置圆角（按照UIView 高的比例）

 @param ratio 圆角的半径相对高的比例
 @param borderColor 边框颜色
 @param borderWidth 边框宽度
 */
- (void)gt_setCornerRadiusRatioToHeight:(CGFloat)ratio borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;
/**
 设置圆角（按照UIView 高的比例）
 
 @param ratio 圆角的半径相对高的比例
 */
- (void)gt_setCornerRadiusRatioToHeight:(CGFloat)ratio;
/**
 设置圆角（按照给定的圆角半径）

 @param radius 圆角的半径
 @param borderColor 边框颜色
 @param borderWidth 边框宽度
 */
- (void)gt_setCornerRadius:(CGFloat)radius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;

/**
 设置圆角（按照给定的圆角半径）

 @param radius 圆角的半径
 */
- (void)gt_setCornerRadius:(CGFloat)radius;
@end
