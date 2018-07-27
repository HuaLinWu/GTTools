//
//  UIViewController+GTRouter.m
//  GTTools
//
//  Created by 吴华林 on 2018/7/10.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import "UIViewController+GTRouter.h"
#import <objc/runtime.h>
@implementation UIViewController (GTRouter)
- (void)setShowType:(GTRouterShowType)showType {
    objc_setAssociatedObject(self, "GTRouter_showType", @(showType), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (GTRouterShowType)showType {
   NSNumber *number = objc_getAssociatedObject(self, "GTRouter_showType");
    if(!number) {
        return GTRouterUnknown;
    } else {
        return [number unsignedIntegerValue];
    }
}
- (void)setViewControllerIdentifier:(NSString *)viewControllerIdentifier {
    if(viewControllerIdentifier) {
        objc_setAssociatedObject(self, "GTRouter_viewControllerIdentifier", viewControllerIdentifier, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    
    
}
- (NSString *)viewControllerIdentifier {
    
    NSString *viewControllerIdentifier = objc_getAssociatedObject(self, "GTRouter_viewControllerIdentifier");
    return viewControllerIdentifier;
}
@end
