//
//  GTCache.h
//  GTTools
//
//  Created by 吴华林 on 2018/8/3.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger,GTCacheDirectoire) {
    // Documents中一般保存应用程序本身产生文件数据，例如游戏进度，绘图软件的绘图等， iTunes备份和恢复的时候，会包括此目录，注意：在此目录下不要保存从网络上下载的文件，否则app无法上架！
    GTCacheDocument,
    //     Documents中一般保存应用程序本身产生文件数据，例如游戏进度，绘图软件的绘图等， iTunes备份和恢复的时候，会包括此目录，注意：在此目录下不要保存从网络上下载的文件，否则app无法上架！
    GTCacheCaches,
    // 此目录保存应用程序运行时所需的临时数据，使用完毕后再将相应的文件从该目录删除。应用没有运行时，系统也可能会清除该目录下的文件。iTunes同步设备时不会备份该目录
    GTCacheTemp,
   // 在Preferences/下不能直接创建偏好设置文件，而是应该使用NSUserDefaults类来取得和设置应用程序的偏好.
    GTCacheUserDefault,
    //存储到keychain 中
    GTCacheKeyChain,
    //存储到内存中不进入硬盘
    GTCacheMemory
};
@interface GTCache : NSObject

/**
 根据key 从document缓存目录下获取对象
 @param key key值
 */
+ (id)objectForKey:(NSString *)key;
/**
 存储object 到document 目录下的缓存中
 
 @param object 需要缓存的对象
 @param key 存储的key
 */
+ (void)saveObject:(id)object forKey:(NSString *)key;

/**
 删除key 在document 目录下的缓存

 @param key 需要删除的缓存
 */
+ (void)removeObjectForKey:(NSString *)key;
/**
 根据key 读取缓存 （如果内存中不存在，会从指定的文件下读取缓存）

 @param key key值
 @param cacheDirectoire 缓存的文件夹
 
 @return 返回缓存的里面的对象
 */
+ (id)objectForKey:(NSString *)key fromDirectoire:(GTCacheDirectoire)cacheDirectoire;

/**
 存储对应的对象，到指定的文件中

 @param object 需要缓存的对象
 @param key 缓存的key
 @param cacheDirectoire 缓存的文件
 */
+ (void)saveObject:(id)object forKey:(NSString *)key toDirectoire:(GTCacheDirectoire)cacheDirectoire;

/**
 删除对应的key 在相应的目录下的所有的缓存

 @param key 对应的key
 @param cacheDirectoire 缓存所在的目录
 */
+ (void)removeObjectForKey:(NSString *)key inDirectoire:(GTCacheDirectoire)cacheDirectoire;

/**
 移除key对应的所有的缓存

 @param key 对应的key
 */
+ (void)removeAllObjectForKey:(NSString *)key;

/**
 移除指定目录下的缓存的文件

 @param cacheDirectoire 缓存目录
 */
+ (void)removeAllObjectInDirectoire:(GTCacheDirectoire)cacheDirectoire;
/**
 移除所有的缓存
 */
+ (void)removeAllObject;

@end
