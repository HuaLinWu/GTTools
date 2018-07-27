//
//  AObject.m
//  GTToolsTests
//
//  Created by 吴华林 on 2018/7/27.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import "AObject.h"

@implementation AObject
- (instancetype)init {
    self = [super init];
    if(self) {
        _b = [[BObject alloc] init];
        [_b setFatherNode:self];
        _c = [[CObject alloc] init];
        [_c setFatherNode:self];
        [self addChrildNodes:@[_b,_c]];
    }
    return self;
}
- (BOOL)canHandleEvent:(GTEvent *)event {
    if([event.eventName containsString:@"A"]) {
        return YES;
    } else {
        return NO;
    }
}
- (void)handleEvent:(GTEvent *)event completeHandle:(void(^)(id data))completeHandle {
   NSLog(@"---%s-事件名--->%@",__func__,event.eventName);
}
@end
