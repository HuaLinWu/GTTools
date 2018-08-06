//
//  GTTimer.h
//  GTTools
//
//  Created by 吴华林 on 2018/8/5.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GTTimer : NSObject

/**
 创建秒级的定时器（只是创建不会触发定时器的执行，如果想要执行需要调用@seleter(resumeTimerWithName:)）

 @param name 定时器的名字
 @param period 执行间隔（单位秒）
 @param repeats 是否重复执行（YES 表示重复执行，NO表示执行一次，执行完了定时器就会被释放）
 @param eventHandler 定时执行的动作
 */
+ (void)gt_createSECTimerWithName:(NSString *)name period:(NSTimeInterval)period repeats:(BOOL)repeats eventHandler:(void(^)(void))eventHandler;

/**
 创建纳秒级的定时器（只是创建不会触发定时器的执行，如果想要执行需要调用@seleter(resumeTimerWithName:)）

 @param name 定时器的名字
 @param period 执行间（单位纳秒）
 @param repeats 是否重复（YES 表示重复执行，NO表示执行一次，执行完了定时器就会被释放）
 @param eventHandler 定时执行的动作
 */
+ (void)gt_createNSECTimerWithName:(NSString *)name period:(NSTimeInterval)period repeats:(BOOL)repeats eventHandler:(void(^)(void))eventHandler;

/**
 创建微秒级的定时器（只是创建不会触发定时器的执行，如果想要执行需要调用@seleter(resumeTimerWithName:)）

 @param name 定时器的名字
 @param period 执行间隔（单位微秒）
 @param repeats 是否重复（YES 表示重复执行，NO表示执行一次，执行完了定时器就会被释放）
 @param eventHandler 定时执行的动作
 */
+ (void)gt_createUSECTimerWithName:(NSString *)name period:(NSTimeInterval)period repeats:(BOOL)repeats eventHandler:(void(^)(void))eventHandler;

/**
 根据定时器名字启动定时器

 @param name 定时器的名字
 */
+ (void)resumeTimerWithName:(NSString *)name;

/**
 根据定时器名字挂起定时器

 @param name 定时器的名字
 */
+ (void)suspendTimerWithName:(NSString *)name;

/**
 根据定时器名字停止并且释放定时器

 @param name 定时器的名字
 */
+ (void)releaseTimerWithName:(NSString *)name;
+ (void)resumeTimersWithNames:(NSArray *)names;
+ (void)suspendTimersWithNames:(NSArray *)names;
+ (void)releaseTimersWithNames:(NSArray *)names;
+ (void)resumeAllTimers;
+ (void)suspendAllTimers;
+ (void)releaseAllTimers;
@end
