//
//  GTTimer.m
//  GTTools
//
//  Created by 吴华林 on 2018/8/5.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import "GTTimer.h"
#import <objc/runtime.h>
static inline dispatch_queue_t defaultQueue(){
    return dispatch_queue_create("GTTimerQueue", DISPATCH_QUEUE_CONCURRENT);
}
@interface GTTimer()
@property(nonatomic,strong)dispatch_source_t timer;
@property(nonatomic,assign)dispatch_time_t noRepeatsTimer;
@property(nonatomic,assign)BOOL repeats;
@property (nonatomic, assign, getter=isValid) BOOL valid;
@end
@implementation GTTimer
+ (GTTimer *)timerWithTimeInterval:(NSTimeInterval)ti invocation:(NSInvocation *)invocation repeats:(BOOL)yesOrNo {
    GTTimer *object = [[GTTimer alloc] init];
    [object initTimerWithInvocation:invocation timeInterval:ti*NSEC_PER_SEC repeats:yesOrNo block:nil];
    return object;
}
+ (GTTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti invocation:(NSInvocation *)invocation repeats:(BOOL)yesOrNo {
    GTTimer *timer = [self timerWithTimeInterval:ti invocation:invocation repeats:yesOrNo];
    [timer fire];
    return timer;
}

+ (GTTimer *)timerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo {
    GTTimer *object = [[GTTimer alloc] init];
   NSMethodSignature *methodSignature = [aTarget methodSignatureForSelector:aSelector];
    if(methodSignature) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
        [object initTimerWithInvocation:invocation timeInterval:ti*NSEC_PER_SEC repeats:yesOrNo block:nil];
    }
    return object;
}
+ (GTTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo {
    
    GTTimer *timer = [self timerWithTimeInterval:ti target:aTarget selector:aSelector userInfo:userInfo repeats:yesOrNo];
    [timer fire];
    return timer;
}
+ (GTTimer *)timerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(GTTimer *timer))block {
    GTTimer *timer = [[GTTimer alloc] init];
    [timer initTimerWithInvocation:nil timeInterval:interval*NSEC_PER_SEC repeats:repeats block:block];
    return timer;
}
+ (GTTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(GTTimer *timer))block {
    
    GTTimer *timer = [self timerWithTimeInterval:interval repeats:repeats block:block];
    [timer fire];
    return timer;
}
- (void)fire {
    if(self.timer || self.noRepeatsTimer) {
        _valid = YES;
    }
    if(self.timer) {
        dispatch_resume(self.timer);
    }
}
- (void)invalidate {
    _valid = NO;
}
#pragma mark private_method
- (void)initTimerWithInvocation:(NSInvocation *)invocation timeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(GTTimer *timer))block {
     __weak typeof(self) weakSelf = self;
    if(repeats) {
        if(invocation || block) {
            dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, defaultQueue());
            dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, interval, 0);
            if(invocation) {
                dispatch_source_set_event_handler(timer,^{
                    [invocation invoke];
                });
            } else {
                dispatch_source_set_event_handler(timer,^{
                    block(weakSelf);
                });
            }
            self.timer = timer;
        }
       
    } else {
        if(invocation || block) {
            dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW,  interval);
            if(invocation) {
                dispatch_after(time, defaultQueue(),^{
                    [invocation invoke];
                });
            } else {
                dispatch_after(time, defaultQueue(),^{
                    block(weakSelf);
                });
            }
            
            self.noRepeatsTimer = time;
        }
    }
}
#pragma mark set/get
- (BOOL)isValid {
    return _valid;
}
@end
