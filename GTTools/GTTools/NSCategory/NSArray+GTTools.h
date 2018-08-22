//
//  NSArray+GTTools.h
//  GTTools
//
//  Created by 吴华林 on 2018/6/20.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface NSArray(GTSafe)
- (NSUInteger)gtSafeCount;
- (id)gtSafeObjectAtIndex:(NSUInteger)index;
@end
@interface NSMutableArray(GTSafe)
- (void)gtSafeAddObject:(id)anObject;
- (void)gtSafeInsertObject:(id)anObject atIndex:(NSUInteger)index;
- (void)gtSafeRemoveLastObject;
- (void)gtSafeRemoveObjectAtIndex:(NSUInteger)index;
- (void)gtSafeReplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;
@end
@interface GTSafeMutableArray : NSMutableArray
- (void)addObject:(id)anObject;
- (void)insertObject:(id)anObject atIndex:(NSUInteger)index;
- (void)removeLastObject;
- (void)removeObjectAtIndex:(NSUInteger)index;
- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;
@end
