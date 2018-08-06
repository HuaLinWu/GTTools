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

@interface GTTimerDTO :NSObject
{
    dispatch_source_t _timer;
}
@property(nonatomic,assign)BOOL repeats;
@property(nonatomic,copy)void(^eventHandler)(void);
@property(nonatomic,assign)uint64_t interval;
@property(nonatomic,strong,readonly)dispatch_source_t timer;
- (instancetype)initWithInterval:(uint64_t)interval repeats:(BOOL)repeats eventHandler:(void(^)(void))eventHandler;
@end
@implementation GTTimerDTO
- (instancetype)initWithInterval:(uint64_t)interval repeats:(BOOL)repeats eventHandler:(void(^)(void))eventHandler {
    self = [super init];
    if(self) {
        _interval = interval;
        _repeats = repeats;
        _eventHandler = [eventHandler copy];
    }
    return self;
}
- (dispatch_source_t)timer {
    if(!_timer && _repeats){
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, defaultQueue());
        dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, _interval, 0);
        dispatch_source_set_event_handler(_timer, _eventHandler);
    }
    return _timer;
}
@end
@interface GTTimer()
@property(nonatomic,strong,readonly,class)NSMutableDictionary *timerCacheDict;
@end
@implementation GTTimer
+ (void)gt_createSECTimerWithName:(NSString *)name period:(NSTimeInterval)period repeats:(BOOL)repeats eventHandler:(void(^)(void))eventHandler {
    
    GTTimerDTO *dto = [[GTTimerDTO alloc] initWithInterval:period*NSEC_PER_SEC repeats:repeats eventHandler:eventHandler];
    [self.timerCacheDict setObject:dto forKey:name];
    
}
+ (void)gt_createNSECTimerWithName:(NSString *)name period:(NSTimeInterval)period repeats:(BOOL)repeats eventHandler:(void(^)(void))eventHandler {
    GTTimerDTO *dto = [[GTTimerDTO alloc] initWithInterval:period*NSEC_PER_MSEC repeats:repeats eventHandler:eventHandler];
    [self.timerCacheDict setObject:dto forKey:name];
}
+ (void)gt_createUSECTimerWithName:(NSString *)name period:(NSTimeInterval)period repeats:(BOOL)repeats eventHandler:(void(^)(void))eventHandler {
    GTTimerDTO *dto = [[GTTimerDTO alloc] initWithInterval:period*USEC_PER_SEC repeats:repeats eventHandler:eventHandler];
    [self.timerCacheDict setObject:dto forKey:name];
}
+ (void)resumeTimerWithName:(NSString *)name {
    GTTimerDTO *dto = [self getTimerDTOWithName:name];
    if(dto) {
        if(dto.repeats) {
            //需要重复执行的
            dispatch_resume(dto.timer);
        } else {
            //只需要执行一次的
            dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW,  dto.interval);
            dispatch_after(time, defaultQueue(), dto.eventHandler);
            [self.timerCacheDict removeObjectForKey:name];
        }
    }
}
+ (void)suspendTimerWithName:(NSString *)name {
    GTTimerDTO *dto = [self getTimerDTOWithName:name];
    if(dto.timer) {
        dispatch_suspend(dto.timer);
    }
}
+ (void)releaseTimerWithName:(NSString *)name {
    GTTimerDTO *dto = [self getTimerDTOWithName:name];
    if(dto.timer) {
        dispatch_source_cancel(dto.timer);
        [self removeTimerDTOWithName:name];
    }
}
+ (void)resumeTimersWithNames:(NSArray *)names {
    if(names) {
        for(NSString *name in names) {
            [self resumeTimerWithName:name];
        }
    }
}
+ (void)suspendTimersWithNames:(NSArray *)names {
    if(names) {
        for(NSString *name in names) {
            [self suspendTimerWithName:name];
        }
    }
}
+ (void)releaseTimersWithNames:(NSArray *)names {
    if(names) {
        for(NSString *name in names) {
            [self releaseTimerWithName:name];
        }
    }
}
+ (void)resumeAllTimers {
    [self resumeTimersWithNames:[self.timerCacheDict allKeys]];
}
+ (void)suspendAllTimers {
    [self suspendTimersWithNames:[self.timerCacheDict allKeys]];
}
+ (void)releaseAllTimers {
     [self releaseTimersWithNames:[self.timerCacheDict allKeys]];
}
#pragma mark set/get
+ (NSMutableDictionary *)timerCacheDict {
    NSMutableDictionary*dict = objc_getAssociatedObject(self, "gtTimerCache");
    if(!dict) {
        dict = [[NSMutableDictionary alloc] init];
        objc_setAssociatedObject(self, "gtTimerCache", dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return dict;
}
+ (GTTimerDTO *)getTimerDTOWithName:(NSString *)name {
    if(name) {
        return [self.timerCacheDict objectForKey:name];
    }
    return nil;
}
+ (void)removeTimerDTOWithName:(NSString *)name {
    if(name) {
        return [self.timerCacheDict removeObjectForKey:name];
    }
}
@end
