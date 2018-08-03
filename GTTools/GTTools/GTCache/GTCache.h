//
//  GTCache.h
//  GTTools
//
//  Created by 吴华林 on 2018/8/3.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GTCache : NSObject

/**
 保存对象到Document 文件下
 */
+ (void)saveObjectToDocument:(id)object forKey:(NSString *)key;

/**
 保存对象到Library/Caches 文件下
 */
+ (void)saveObjectToCache:(id)object forKey:(NSString *)key;

/**
 保存对象到temp 文件下
 */
+ (void)saveObjectToTemp:(id)object forKey:(NSString *)key;

/**
 保存对象到UserDefault 里面
 */
+ (void)saveObjectToUserDefault:(id)object forKey:(NSString *)key;

/**
 保存对象到keychain里面（对象不宜过大）
 */
+ (void)saveObjectToKeyChain:(id)object forKey:(NSString *)key;
/**
 保存对象到内存中，在内存不够的时候会丢失
 */
+ (void)saveObjectToMemory:(id)object forKey:(NSString *)key;

/**
 根据key 获取对象
 @param key key值
 */
+ (id)objectForKey:(NSString *)key;
@end
