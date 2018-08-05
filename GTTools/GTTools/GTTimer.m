//
//  GTTimer.m
//  GTTools
//
//  Created by 吴华林 on 2018/8/5.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import "GTTimer.h"
@interface GTTimerDTO : NSObject

@end
@implementation GTTimerDTO
@end
@implementation GTTimer
+ (void)gt_createTimerWithName:(NSString *)name period:(NSTimeInterval)period repeats:(BOOL)repeats eventHandler:(void(^)(void))eventHandler {
    dispatch_time_t timer = dispatch_time(DISPATCH_TIME_NOW, period*NSEC_PER_SEC);
    if(repeats) {
        
    } else {
//       dispatch_after(timer, <#dispatch_queue_t  _Nonnull queue#>, eventHandler)
    }
//    dispatch_s
}
@end
