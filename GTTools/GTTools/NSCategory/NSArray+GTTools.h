//
//  NSArray+GTTools.h
//  GTTools
//
//  Created by 吴华林 on 2018/6/20.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (GTTools)
- (nullable id)gt_objectAtIndex:(NSUInteger)index;
@end
@interface NSMutableArray (GTTools)
- (void)gt_addObject:(id)anObject;
- (void)gt_removeObjectAtIndex:(NSUInteger)index;
- (void)gt_removeObjectsInRange:(NSRange)range;
- (void)gt_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;
- (void)gt_insertObject:(id)anObject atIndex:(NSUInteger)index;
- (void)gt_exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2;
- (void)gt_removeObject:(id)anObject inRange:(NSRange)range;
- (void)gt_removeObjectIdenticalTo:(id)anObject inRange:(NSRange)range;
- (void)gt_replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray<id> *)otherArray range:(NSRange)otherRange;
- (void)gt_replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray<id> *)otherArray;
- (void)gt_insertObjects:(NSArray<id> *)objects atIndexes:(NSIndexSet *)indexes;
- (void)gt_removeObjectsAtIndexes:(NSIndexSet *)indexes;
- (void)gt_replaceObjectsAtIndexes:(NSIndexSet *)indexes withObjects:(NSArray<id> *)objects;
@end
