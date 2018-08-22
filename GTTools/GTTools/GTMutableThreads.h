//
//  GTMutableThreads.h
//  GTTools
//
//  Created by 吴华林 on 2018/8/17.
//  Copyright © 2018年 吴华林. All rights reserved.
//
#ifndef GTMutableThreads
typedef void(^GTMutableThreadBlock)(void);

/**
 主程调用（如果当前是主程直接执行，如果不是主程，会切换到主程异步调用，不会出现循环引用的问题）

 @param block 需要执行的block
 */
void GTRunInMainThread(GTMutableThreadBlock block);

/**
 非主程调用(如果当前不是主程就直接调用，如果主程会用会将block 放入到默认全局队列进行调用，异步执行，不会出现循环引用的问题)

 @param block 需要执行的block
 */
void GTRunInOtherThread(GTMutableThreadBlock block);

/**
 非主程调用（将任务放入到指定级别的全局队列中，异步执行，不会出现循环引用的问题）

 @param identifier 队列级别
 @param block 需要执行的block
 */
void GTRunInOtherThreadWithPriority(dispatch_queue_priority_t identifier,GTMutableThreadBlock block);
#endif
