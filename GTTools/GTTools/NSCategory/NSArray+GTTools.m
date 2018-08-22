//
//  NSArray+GTTools.m
//  GTTools
//
//  Created by 吴华林 on 2018/6/20.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import "NSArray+GTTools.h"
#import <objc/runtime.h>

@implementation NSArray(GTSafe)
- (NSUInteger)gtSafeCount {
    return 0;
}
- (id)gtSafeObjectAtIndex:(NSUInteger)index {
    return nil;
}
@end
@implementation NSMutableArray(GTSafeMutableArray)
- (void)gtSafeAddObject:(id)anObject {
    
}
- (void)gtSafeInsertObject:(id)anObject atIndex:(NSUInteger)index {
    
}
- (void)gtSafeRemoveLastObject {
    
}
- (void)gtSafeRemoveObjectAtIndex:(NSUInteger)index {
    
}
- (void)gtSafeReplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    
}
- (dispatch_queue_t)GTSyncQueue {
   
    dispatch_queue_t queue = objc_getAssociatedObject(self, "GTSyncQueue");
    if(!queue) {
        queue = dispatch_queue_create("GTSafeQueue", DISPATCH_QUEUE_CONCURRENT);
        objc_setAssociatedObject(self, "GTSyncQueue", queue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return queue;
}
@end
@implementation GTSafeMutableArray
- (void)addObject:(id)anObject {
    
}
- (void)insertObject:(id)anObject atIndex:(NSUInteger)index {
    
}
- (void)removeLastObject {
    
}
- (void)removeObjectAtIndex:(NSUInteger)index {
    
}
- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    
}
- (instancetype)init {
    self = [super init];
    if(self) {
        
    }
    return self;
}
@end
