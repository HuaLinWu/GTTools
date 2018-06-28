//
//  UIView+GTTools.m
//  GTTools
//
//  Created by 吴华林 on 2018/6/21.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import "UIView+GTTools.h"
#import <objc/runtime.h>

#import "Aspects.h"

void exchangeMethod(Class aClass, SEL oldSEL, SEL newSEL)
{
    Method oldMethod = class_getInstanceMethod(aClass, oldSEL);
    assert(oldMethod);
    Method newMethod = class_getInstanceMethod(aClass, newSEL);
    assert(newMethod);
    method_exchangeImplementations(oldMethod, newMethod);
}
@implementation UIView (Frame)
+ (void)load {
    exchangeMethod(self, @selector(layoutSubviews), @selector(hook_layoutSubviews));
}
- (void)hook_layoutSubviews {
    NSLog(@"000000");
}
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
+ (void)load {
    exchangeMethod(self, @selector(layoutSubviews), @selector(hook_layoutSubviews));
}
- (void)hook_layoutSubviews {
    NSLog(@"111111");
}
- (void)gt_setCornerRadius:(CGFloat)radius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    if(borderColor) {
        self.layer.borderColor = borderColor.CGColor;
    }
    self.layer.cornerRadius = radius;
    self.layer.borderWidth = borderWidth;
}
- (void)gt_setCornerRadius:(CGFloat)radius {
    [self gt_setCornerRadius:radius borderColor:nil borderWidth:0];
}
@end
