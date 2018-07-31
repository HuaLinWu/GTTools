//
//  UITableViewCell+FCLineTableViewCell.h
//  Riot
//
//  Created by 吴华林 on 2017/7/11.
//  Copyright © 2017年 finogeeks.com. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, FCLineTableViewCellStyle) {
    FCLineTableViewCellStyleNoneLine,//没有边线
    FCLineTableViewCellStyleTopLine,//上边线
    FCLineTableViewCellStyleBottomLine,//下边线
    FCLineTableViewCellStyleBothLine//上下边线都有
};
@interface UITableViewCell (Line)

/**
 初始化cell(这个方法会将UITableViewCellStyle 设置为UITableViewCellStyleDefault, 如果有边线会设置EdgeInsets 设置为UIEdgeInsetsZero)

 @param lineStyle 横线所在的位置
 @param reuseIdentifier cell 重用的标示
 @return cell
 */
- (instancetype)initWithLineStyle:(FCLineTableViewCellStyle)lineStyle reuseIdentifier:(NSString *)reuseIdentifier;

/**
 初始化cell 可以设置是横线所在的位置(如果有边线会设置EdgeInsets 设置为UIEdgeInsetsMake(0, 0, self.contentView.frame.size.height -1, 0))

 @param style 系统自带的cell 样式
 @param lineStyle 横线所在的位置
 @param reuseIdentifier 重用的标示
 @return cell
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style lineStyle:(FCLineTableViewCellStyle)lineStyle reuseIdentifier:(NSString *)reuseIdentifier;

/**
 初始化cell（可以设置是否上下边线，以及边线的位置）

 @param style 系统自带的cell 样式
 @param lineStyle 横线所在的位置
 @param topLineEdgeInsets 上边线的与cell 的内边距
 @param bottomLineEdgeInsets 下边线与cell 的内边距
 @param reuseIdentifier 重用的标示
 @return UITableViewCell
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style lineStyle:(FCLineTableViewCellStyle)lineStyle topLineEdgeInsets:(UIEdgeInsets)topLineEdgeInsets bottomLineEdgeInsets:(UIEdgeInsets)bottomLineEdgeInsets reuseIdentifier:(NSString *)reuseIdentifier;

/**
 初始化cell （可以设置是否上下边线，以及边线的位置，以及边线的颜色）

 @param style 系统自带的cell 样式
 @param lineStyle 横线所在的位置
 @param topLineEdgeInsets  上横线的边距
 @param bottomLineEdgeInsets 下横线的边距
 @param topLineColor 上横线的颜色
 @param bottomLineColor 下横线的颜色
 @param reuseIdentifier 重用标示
 @return UITableViewCell
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style lineStyle:(FCLineTableViewCellStyle)lineStyle topLineEdgeInsets:(UIEdgeInsets)topLineEdgeInsets bottomLineEdgeInsets:(UIEdgeInsets)bottomLineEdgeInsets topLineColor:(UIColor *)topLineColor bottomLineColor:(UIColor *)bottomLineColor reuseIdentifier:(NSString *)reuseIdentifier;

/**
 初始化cell（可以自己在block 设置边线的约束和位置）

 @param style 系统自带的cell 样式
 @param lineStyle 横线所在的位置
 @param topLineColor 上横线的颜色
 @param bottomLineColor 下横线的颜色
 @param reuseIdentifier 重用标示
 @param block 自定义的block
 @return UITableViewCell
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style lineStyle:(FCLineTableViewCellStyle)lineStyle topLineColor:(UIColor *)topLineColor bottomLineColor:(UIColor *)bottomLineColor reuseIdentifier:(NSString *)reuseIdentifier layoutBlock:(void(^)(UIView *topLineView,UIView*bottomLineView))block;
@end
