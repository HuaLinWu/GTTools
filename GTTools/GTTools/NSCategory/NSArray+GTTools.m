//
//  NSArray+GTTools.m
//  GTTools
//
//  Created by 吴华林 on 2018/6/20.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import "NSArray+GTTools.h"
#import "GTNullFilter.h"
@interface NSArray()
- (BOOL)gt_isBeyondRangeWithIndex:(NSUInteger)index;
- (BOOL)gt_isBeyondRangeWithRange:(NSRange )range;
@end
@implementation NSArray (GTTools)
- (nullable id)gt_objectAtIndex:(NSUInteger)index {
    if([self gt_isBeyondRangeWithIndex:index]) {
        return nil;
    } else {
       return [self objectAtIndex:index];
    }
}
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
- (BOOL)gt_isBeyondRangeWithIndex:(NSUInteger)index {
    if(index>=self.count) {
        return YES;
    } else {
        return NO;
    }
}
- (BOOL)gt_isBeyondRangeWithRange:(NSRange )range {
    if ((range.location + range.length)>self.count) {
        return YES;
    } else {
        return NO;
    }
}
#pragma clang diagnostic pop
@end
@implementation NSMutableArray (GTTools)
- (void)gt_addObject:(id)anObject {
    if([GTNullFilter isNullForObject:anObject]) {
        return;
    } else {
        [self addObject:anObject];
    }
}
- (void)gt_removeObjectAtIndex:(NSUInteger)index {
    if([self gt_isBeyondRangeWithIndex:index]) {
        return;
    } else {
        [self removeObjectAtIndex:index];
    }
}
- (void)gt_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    if([self gt_isBeyondRangeWithIndex:index] || [GTNullFilter isNullForObject:anObject]) {
        return;
    } else {
        [self replaceObjectAtIndex:index withObject:anObject];
    }
}
- (void)gt_insertObject:(id)anObject atIndex:(NSUInteger)index {
    
    if([self gt_isBeyondRangeWithIndex:index] || [GTNullFilter isNullForObject:anObject]) {
        return;
    } else {
        [self insertObject:anObject atIndex:index];
    }
}
- (void)gt_exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2 {
    if([self gt_isBeyondRangeWithIndex:idx1] || [self gt_isBeyondRangeWithIndex:idx2]) {
        return;
    } else {
        [self exchangeObjectAtIndex:idx1 withObjectAtIndex:idx2];
    }
}
- (void)gt_removeObjectsInRange:(NSRange)range {
    if([self gt_isBeyondRangeWithRange:range]) {
        return;
    } else {
        [self removeObjectsInRange:range];
    }
}
- (void)gt_removeObject:(id)anObject inRange:(NSRange)range {
    
    if([self gt_isBeyondRangeWithRange:range]) {
        return;
    } else {
        [self removeObject:anObject inRange:range];
    }
}
- (void)gt_removeObjectIdenticalTo:(id)anObject inRange:(NSRange)range {
    if([self gt_isBeyondRangeWithRange:range]) {
        return;
    } else {
        [self removeObjectIdenticalTo:anObject inRange:range];
    }
}
- (void)gt_replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray<id> *)otherArray range:(NSRange)otherRange {
    if([self gt_isBeyondRangeWithRange:range]||[otherArray gt_isBeyondRangeWithRange:otherRange]) {
        return;
    } else {
        [self replaceObjectsInRange:range withObjectsFromArray:otherArray range:otherRange];
    }
}
- (void)gt_replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray<id> *)otherArray {
    if([self gt_isBeyondRangeWithRange:range]) {
        return;
    } else {
        [self replaceObjectsInRange:range withObjectsFromArray:otherArray];
    }
}
- (void)gt_insertObjects:(NSArray<id> *)objects atIndexes:(NSIndexSet *)indexes {
    if([indexes indexGreaterThanOrEqualToIndex:self.count] >self.count) {
        return;
    } else {
        [self insertObjects:objects atIndexes:indexes];
    }
}
- (void)gt_removeObjectsAtIndexes:(NSIndexSet *)indexes {
    if([indexes indexGreaterThanOrEqualToIndex:self.count] >self.count) {
        return;
    } else {
        [self removeObjectsAtIndexes:indexes];
    }
}
- (void)gt_replaceObjectsAtIndexes:(NSIndexSet *)indexes withObjects:(NSArray<id> *)objects {
    if([indexes indexGreaterThanOrEqualToIndex:self.count] >self.count) {
        return;
    } else {
        [self replaceObjectsAtIndexes:indexes withObjects:objects];
    }
}
@end
