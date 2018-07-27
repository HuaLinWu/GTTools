//
//  UIResponder+GSCategory.m
//  GSUtils
//
//  Created by 张大宗 on 2017/11/3.
//  Copyright © 2017年 张大宗. All rights reserved.
//

#import "UIResponder+GSCategory.h"

@implementation UIResponder (GSCategory)

- (void)routerEventWithName:(NSString *const)eventName userInfo:(NSDictionary *)userInfo {
    [[self nextResponder] routerEventWithName:eventName userInfo:userInfo];
}

- (NSInvocation *)createInvocationWithSelector:(SEL)selector
{
    NSMethodSignature *signature = [self methodSignatureForSelector:selector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = self;
    invocation.selector = selector;
    return invocation;
}

@end
