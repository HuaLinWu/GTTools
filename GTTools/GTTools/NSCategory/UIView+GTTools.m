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

@implementation UIView (GTFrame)

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
- (CGFloat)midx {
    return CGRectGetMinX(self.frame);
}
- (CGFloat)maxx {
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)y {
    return CGRectGetMinY(self.frame);
}
- (CGFloat)midy {
    return CGRectGetMidY(self.frame);
}
- (CGFloat)maxy {
    return CGRectGetMaxY(self.frame);
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
@interface UIView()
@property(nonatomic,assign)BOOL needCornerRadius;
@property(nonatomic,assign)NSString *cornerRadiusratioStr;
@end
@implementation UIView (GTShape)
+ (void)load {
    [self aspect_hookSelector:@selector(layoutSubviews) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo){
        [[aspectInfo instance] gt_uiview_shap_layoutSubviews];
    } error:nil];
}
- (void)gt_setCornerRadiusRatioToHeight:(CGFloat)ratio borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    if(borderColor) {
        self.layer.borderColor = borderColor.CGColor;
    }
    self.layer.borderWidth = borderWidth;
    self.needCornerRadius = YES;
    self.cornerRadiusratioStr = [NSString stringWithFormat:@"%f",ratio];
    [self setNeedsLayout];
}
- (void)gt_setCornerRadiusRatioToHeight:(CGFloat)ratio {
    [self gt_setCornerRadiusRatioToHeight:ratio borderColor:nil borderWidth:0];
}
- (void)gt_setCornerRadius:(CGFloat)radius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    if(borderColor) {
        self.layer.borderColor = borderColor.CGColor;
    }
    self.layer.cornerRadius = radius;
    self.layer.borderWidth = borderWidth;
    self.needCornerRadius = YES;
    [self setNeedsLayout];
}
- (void)gt_setCornerRadius:(CGFloat)radius {
    [self gt_setCornerRadius:radius borderColor:nil borderWidth:0];
}


#pragma mark private_method
- (void)gt_uiview_shap_layoutSubviews {
    if(self.needCornerRadius) {
        for(UIView *subView in [self subviews]) {
            //交集
            CGRect intersectionRect = CGRectIntersection(self.bounds, subView.frame);
            BOOL success1 = !CGRectEqualToRect(intersectionRect, subView.frame);
            BOOL success2 = CGRectEqualToRect(self.frame,subView.frame);
            BOOL success3 = CGRectEqualToRect(intersectionRect, subView.frame) &&(subView.x==0 || subView.y==0||CGRectGetMaxX(subView.frame)==self.width||CGRectGetMaxY(subView.frame)==self.height);
            if(success1||success2||success3) {
                CGFloat x = (subView.x<0)?0:subView.x;
                CGFloat y = (subView.y<0)?0:subView.y;
               subView.frame = CGRectIntersection(self.bounds, subView.frame);
                NSUInteger maskedCorners = 0;
                if(x==0 && y ==0) {
                    maskedCorners = maskedCorners|kCALayerMinXMinYCorner;
                   
                }
                if(x==0 &&(y+subView.height == self.height)) {
                    maskedCorners = maskedCorners|kCALayerMinXMaxYCorner;
                }
                if(y ==0 && (x+subView.width) == self.width) {
                    maskedCorners = maskedCorners|kCALayerMaxXMinYCorner;
                }
                if((x+subView.width) == self.width && (y+subView.height == self.height)) {
                    maskedCorners = maskedCorners|kCALayerMaxXMaxYCorner;
                }
                subView.layer.maskedCorners = maskedCorners;
                CGFloat ratio = [self.cornerRadiusratioStr floatValue];
                if(ratio!=0) {
                    self.layer.cornerRadius = self.height *ratio;
                }
                subView.layer.cornerRadius = self.layer.cornerRadius;
            }
        }
    }
    
}
#pragma mark set/get
- (void)setNeedCornerRadius:(BOOL)needSetCornerRadius {
    objc_setAssociatedObject(self, "gt_uiview_shape_corner", @(needSetCornerRadius), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)needCornerRadius {
   NSNumber *number = objc_getAssociatedObject(self, "gt_uiview_shape_corner");
    if(number) {
        return [number boolValue];
    } else {
        return NO;
    }
}
- (void)setCornerRadiusratioStr:(NSString *)cornerRadiusratio {
 
     objc_setAssociatedObject(self, "gt_uiview_shape_cornerRadiusratio", cornerRadiusratio, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)cornerRadiusratioStr {
    
    return objc_getAssociatedObject(self, "gt_uiview_shape_cornerRadiusratio");
}
@end
