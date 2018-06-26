//
//  GTMemoryCache.h
//  GTTools
//
//  Created by 吴华林 on 2018/6/21.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GTMemoryCache : NSObject
- (void)setObject:(id)anObject forKey:(nonnull id)aKey;
- (id)objectForKey:(id)key;
- (BOOL)containObjectForKey:(id)key;
@end
