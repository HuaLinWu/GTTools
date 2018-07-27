//
//  FObject.m
//  GTToolsTests
//
//  Created by 吴华林 on 2018/7/27.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import "FObject.h"

@implementation FObject
- (BOOL)canHandleEvent:(GTEvent *)event {
    if([event.eventName containsString:@"F"]) {
        return YES;
    } else {
        return NO;
    }
}
- (void)handleEvent:(GTEvent *)event completeHandle:(void(^)(id data))completeHandle {
   NSLog(@"---%s-事件名--->%@",__func__,event.eventName);
}
@end
