//
//  UIResponder+GSCategory.h
//  GSUtils
//
//  Created by 张大宗 on 2017/11/3.
//  Copyright © 2017年 张大宗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (GSCategory)

- (void)routerEventWithName:(NSString *const)eventName userInfo:(NSDictionary *)userInfo;

- (NSInvocation *)createInvocationWithSelector:(SEL)selector;

@end
