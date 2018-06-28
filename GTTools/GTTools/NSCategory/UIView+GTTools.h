//
//  UIView+GTTools.h
//  GTTools
//
//  Created by 吴华林 on 2018/6/21.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)
@property(nonatomic,assign)CGFloat x;
@property(nonatomic,assign)CGFloat y;
@property(nonatomic,assign)CGFloat width;
@property(nonatomic,assign)CGFloat height;
@property(nonatomic,assign)CGSize size;
@property(nonatomic,assign)CGPoint origin;
@end

@interface UIView (Shape)
- (void)gt_setCornerRadius:(CGFloat)radius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;
- (void)gt_setCornerRadius:(CGFloat)radius;
@end
