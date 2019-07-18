//
//  NSObject+GTKVO1.m
//  GTReactiveMap
//
//  Created by 吴华林 on 2019/7/17.
//  Copyright © 2019 吴华林. All rights reserved.
//

#import "NSObject+GTKVO.h"
#import <objc/runtime.h>
@interface GTObserver : NSObject;
@property(nonatomic, copy)void(^observeBlock)(NSDictionary<NSKeyValueChangeKey,id>*changeDict);
@end
@implementation GTObserver

- (instancetype)initWithObserveBlock:(void(^)(NSDictionary<NSKeyValueChangeKey,id>*changeDict))observeBlock {
    self = [super init];
    if (self) {
        _observeBlock = observeBlock;
    }
    return self;
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if(self.observeBlock) {
        self.observeBlock(change);
    }
}
@end
@interface NSObject()
@property(nonatomic, strong)NSMutableDictionary *gt_keyPathObservers;
@end
@implementation NSObject (GTKVO1)
- (id<NSObject>)gt_addObserve:(void(^)(NSDictionary<NSKeyValueChangeKey,id>*changeDict))observeBlock forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options {
    
    GTObserver *observer = [[GTObserver alloc] initWithObserveBlock:observeBlock];
    [self addObserver:observer forKeyPath:keyPath options:options context:(void *)observer];
    [self _addObserver:observer forKeyPath:keyPath];
    return observer;
}
- (void)gt_removeObserver:(id<NSObject>)observer forKeyPath:(NSString *)keyPath {
    
    [self removeObserver:observer  forKeyPath:keyPath context:(void *)observer];
    [self _removeObserver:observer forKeyPath:keyPath];
}
- (NSMutableDictionary *)gt_keyPathObservers {
    NSMutableDictionary*dict = objc_getAssociatedObject(self, "gt_keyPathObservers");
    if(!dict){
        @synchronized (self) {
            if(!dict) {
                dict = [[NSMutableDictionary alloc] init];
                objc_setAssociatedObject(self, "gt_keyPathObservers", dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
        }
    }
    return dict;
}
- (void)_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath {
    NSMutableArray *array = [self.gt_keyPathObservers objectForKey:keyPath];
    if(!array) {
        array = [[NSMutableArray alloc] init];
        [self.gt_keyPathObservers setObject:array forKey:keyPath];
    }
    @synchronized (array) {
        [array addObject:observer];
    }
    
}
- (void)_removeObserver:(id<NSObject>)observer forKeyPath:(NSString *)keyPath {
     NSMutableArray *array = [self.gt_keyPathObservers objectForKey:keyPath];
    if(array){
        @synchronized (array) {
            [array removeObject:observer];
        }
    }
}
@end
