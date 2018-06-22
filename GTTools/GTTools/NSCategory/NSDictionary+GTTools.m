//
//  NSDictionary+GTTool.m
//  GTTools
//
//  Created by 吴华林 on 2018/6/20.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import "NSDictionary+GTTools.h"
#import "GTNullFilter.h"
@implementation NSDictionary (GTTools)
- (id)gt_objectForKeyPath:(NSString *)keyPath {
    if([GTNullFilter isNullForObject:keyPath]) {
        return nil;
    } else {
        return [self valueForKeyPath:keyPath];
    }
}
- (BOOL)gt_containsObject:(id)object {
    if([GTNullFilter isNullForObject:object]) {
        return NO;
    } else {
        return [[self allValues] containsObject:object];
    }
}
- (BOOL)gt_containsKey:(id<NSCopying>)key {
    
    if([GTNullFilter isNullForObject:key]) {
        return NO;
    } else {
        return [[self allKeys] containsObject:key];
    }
}
- (void)gt_setObject:(id)anObject forKeyPath:(NSString *)keyPath {
    
    if([GTNullFilter isNullForObject:anObject]) {
        return;
    }else if ([GTNullFilter isNullForObject:keyPath]) {
        return;
    } else {
        [self setValue:anObject forKey:keyPath];
    }
}
@end

@implementation NSMutableDictionary (GTTool)
- (void)gt_setObject:(id)anObject forKey:(id <NSCopying>)aKey {
    
    if([GTNullFilter isNullForObject:anObject]) {
        return;
    } else if([GTNullFilter isNullForObject:aKey]) {
        return;
    } else {
        [self setObject:anObject forKey:aKey];
    }
}

@end
