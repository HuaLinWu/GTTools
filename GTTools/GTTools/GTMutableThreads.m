//
//  GTMutableThreads.m
//  GTTools
//
//  Created by 吴华林 on 2018/8/17.
//  Copyright © 2018年 吴华林. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "GTMutableThreads.h"
void GTRunInMainThread(GTMutableThreadBlock block) {
    if(block) {
        if([NSThread currentThread].isMainThread) {
            block();
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                block();
            });
        }
    }
   
}
void GTRunInOtherThread(GTMutableThreadBlock block) {
    if(![NSThread currentThread].isMainThread) {
        block();
    } else {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
    }
}
void GTRunInOtherThreadWithPriority(dispatch_queue_priority_t identifier,GTMutableThreadBlock block) {
    dispatch_async(dispatch_get_global_queue(identifier, 0), block);
}
