//
//  UIResponder+GSCategory.h
//  GSUtils
//
//  Created by 张大宗 on 2017/11/3.
//  Copyright © 2017年 张大宗. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (GTTools)

- (void)gt_routerEventWithName:(NSString *const)eventName userInfo:(NSDictionary *)userInfo;

- (NSInvocation *)gt_createInvocationWithSelector:(SEL)selector;

@end
