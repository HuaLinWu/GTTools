//
//  GTDiskCache.h
//  GTTools
//
//  Created by 吴华林 on 2018/6/21.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface GTDiskCache : NSObject

/**
 根据name 在Library/Caches 目录下创建对应的缓存文件

 @param name 文件名
 */
- (instancetype)initWithName:(NSString *)name;

/**
 根据路径创建缓存的文件夹

 @param path 缓存路径
 */
- (instancetype)initWithDirectoriePath:(NSString *)path;
/**
 存储对象到沙盒硬盘中（默认是存储在Library/Caches 中）

 @param anObject 需要存储的对象
 @param aKey 对应关键key
 */
- (void)setObject:(id)anObject forKey:(NSString *)aKey;

/**
 从沙盒中读取对象

 @param key 对应的存储时候的key
 @return 返回之前存入的对象
 */
- (id)objectForKey:(NSString *)key;

/**
 判断沙盒中是否有对应的key 所存在对象

 @param key 缓存对应的key
 @return 如果存在key 对应的缓存返回YES，否则返回NO
 */
- (BOOL)containObjectForKey:(NSString *)key;

/**
 移除key 对应的object

 @param key 缓存对应的key
 */
- (void)removeObjectForKey:(NSString *)key;

/**
 移除所有的缓存
 */
- (void)removeAllObject;
@end
