//
//  UIView+GTTools.m
//  GTTools
//
//  Created by 吴华林 on 2018/6/21.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import "UIView+GTTools.h"

@implementation UIView (Frame)
- (void)setX:(CGFloat)x {
    if(CGRectGetMinX(self.frame) == x) {
        return;
    } else {
        self.origin = CGPointMake(x, self.y);
    }
}
- (void)setY:(CGFloat)y {
    if(CGRectGetMinY(self.frame) == y) {
        return;
    } else {
        self.origin = CGPointMake(self.x, y);
    }
}
- (void)setSize:(CGSize)size {
    if(CGSizeEqualToSize(size, self.size)) {
        return;
    } else {
        self.frame = CGRectMake(self.x, self.y, size.width, size.height);
    }
}
- (void)setOrigin:(CGPoint)origin {
    
    if(CGPointEqualToPoint(self.origin, origin)) {
        return;
    } else {
        self.frame = CGRectMake(origin.x, origin.y, self.size.width, self.size.height);
    }
}
- (void)setWidth:(CGFloat)width {
    
    if(self.width == width) {
        return;
    } else {
        self.size = CGSizeMake(width, self.height);
    }
}
- (void)setHeight:(CGFloat)height {
    if(self.height == height) {
        return;
    } else {
        self.size = CGSizeMake(self.width, height);
    }
}
- (CGFloat)x {
    return CGRectGetMinX(self.frame);
}
- (CGFloat)y {
    return CGRectGetMinY(self.frame);
}
- (CGSize)size {
    return self.frame.size;
}
- (CGPoint)origin {
    return self.frame.origin;
}
- (CGFloat)width {
    return CGRectGetWidth(self.frame);
}
- (CGFloat)height {
    return CGRectGetHeight(self.frame);
}
@end

@implementation UIView (Shape)
- (void)setRadius:(CGFloat)radius {
    
}
- (void)setBorderColor:(UIColor *)borderColor {
    
}
- (void)setBorderWidth:(CGFloat)borderWidth {
    
}
#pragma mark private_method
- (void)gt_drawRectWithRoundeCorner:(CGFloat)radius borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor borderColor:(UIColor *)borderColor {
    
}
@end
