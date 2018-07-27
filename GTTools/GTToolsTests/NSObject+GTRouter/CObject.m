//
//  AObject.m
//  GTToolsTests
//
//  Created by 吴华林 on 2018/7/27.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import "CObject.h"

@implementation CObject
- (instancetype)init {
    self = [super init];
    if(self) {
        _f = [[FObject alloc] init];
        [_f setFatherNode:self];
        _g = [[GObject alloc] init];
        [_g setFatherNode:self];
        _h = [[HObject alloc] init];
        [_h setFatherNode:self];
        [self addChrildNodes:@[_f,_g,_h]];
    }
    return self;
}

- (BOOL)canHandleEvent:(GTEvent *)event {
    if([event.eventName containsString:@"C"]) {
        return YES;
    } else {
        return NO;
    }
}
- (void)handleEvent:(GTEvent *)event completeHandle:(void(^)(id data))completeHandle {
    NSLog(@"---%s-事件名--->%@",__func__,event.eventName);
}
@end
