//
//  NSObject+GTKVO1.h
//  GTReactiveMap
//
//  Created by 吴华林 on 2019/7/17.
//  Copyright © 2019 吴华林. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (GTKVO)

/**
 以block 方式增加观察者

 @param observeBlock 观察执行的block
 @param keyPath 需要观察的keypath
 @param options NSKeyValueObservingOptions
 @return 观察者对象主要作用移除观察
 */
- (id<NSObject>)gt_addObserve:(void(^)(NSDictionary<NSKeyValueChangeKey,id>*changeDict))observeBlock forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options;

/**
 移除对应keypath 观察者

 @param observer （gt_addObserve:(void(^)(NSDictionary<NSKeyValueChangeKey,id>*changeDict))observeBlock forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options 返回的对象）
 @param keyPath keyPath
 */
- (void)gt_removeObserver:(id<NSObject>)observer forKeyPath:(NSString *)keyPath;
@end

NS_ASSUME_NONNULL_END
