//
//  NSDictionary+GTTool.h
//  GTTools
//
//  Created by 吴华林 on 2018/6/20.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (GTTools)
- (id)gt_objectForKeyPath:(NSString *)keyPath;
- (BOOL)gt_containsObject:(id)object;
- (BOOL)gt_containsKey:(id<NSCopying>)key;
- (void)gt_setObject:(id)anObject forKeyPath:(NSString *)keyPath;
@end
@interface NSMutableDictionary (GTTool)
- (void)gt_setObject:(id)anObject forKey:(id <NSCopying>)aKey;
@end
