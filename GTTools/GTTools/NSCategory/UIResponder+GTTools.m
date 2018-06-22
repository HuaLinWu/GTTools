//
//  UIResponder+GSCategory.m
//  GSUtils
//
//  Created by 张大宗 on 2017/11/3.
//  Copyright © 2017年 张大宗. All rights reserved.
//

#import "UIResponder+GTTools.h"
#import <objc/runtime.h>
@implementation UIResponder (GTTools)

- (void)gt_routerEventWithName:(NSString *const)eventName userInfo:(NSDictionary *)userInfo {
    if(eventName) {
        UIResponder *nextResponder = [self gt_nextResponder];
        if([nextResponder isKindOfClass:[UINavigationController class]]) {
            [nextResponder gt_routerEventWithName:eventName userInfo:userInfo];
            UIViewController *visibleViewController = ((UINavigationController *)nextResponder).visibleViewController;
            [visibleViewController gt_setNextResponder:nextResponder.nextResponder];
            nextResponder = visibleViewController;
        }
        [nextResponder gt_routerEventWithName:eventName userInfo:userInfo];
    }
}

- (NSInvocation *)gt_createInvocationWithSelector:(SEL)selector
{
    NSMethodSignature *signature = [self methodSignatureForSelector:selector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = self;
    invocation.selector = selector;
    return invocation;
}
- (UIResponder *)gt_nextResponder {
    UIResponder *nextResponder =objc_getAssociatedObject(self, "gt_nextResponder");
    if(!nextResponder) {
        nextResponder = [self nextResponder];
    }
    return nextResponder;
}
- (void)gt_setNextResponder:(UIResponder *)nextResponder {
    if(nextResponder){
        objc_setAssociatedObject(self, "gt_nextResponder", nextResponder, OBJC_ASSOCIATION_ASSIGN);
    }
}
@end
