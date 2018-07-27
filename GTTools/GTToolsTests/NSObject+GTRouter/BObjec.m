//
//  AObject.m
//  GTToolsTests
//
//  Created by 吴华林 on 2018/7/27.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import "BObject.h"

@implementation BObject
- (instancetype)init {
    self = [super init];
    if(self) {
        _d = [[DObject alloc] init];
        [_d setFatherNode:self];
        _e = [[EObject alloc] init];
        [_e setFatherNode:self];
        [self addChrildNodes:@[_d,_e]];
    }
    return self;
}
- (BOOL)canHandleEvent:(GTEvent *)event {
    if([event.eventName containsString:@"B"]) {
        return YES;
    } else {
        return NO;
    }
}

- (void)handleEvent:(GTEvent *)event completeHandle:(void(^)(id data))completeHandle {
    NSLog(@"---%s-事件名--->%@",__func__,event.eventName);
}
@end
