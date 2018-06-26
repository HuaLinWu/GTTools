//
//  GTDiskCache.h
//  GTTools
//
//  Created by 吴华林 on 2018/6/21.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, GTDiskCacheRootDirectories) {
    /**
     此目录用来保存应用程序运行时生成的需要持久化的数据，这些数据一般存储体积比较大，又不是十分重要，比如网络请求数据等。这些数据需要用户负责删除。iTunes同步设备时不会备份该目录。
     */
    GTCachesDirectories,
    /**
     Documents中一般保存应用程序本身产生文件数据，例如游戏进度，绘图软件的绘图等， iTunes备份和恢复的时候，会包括此目录，注意：在此目录下不要保存从网络上下载的文件，否则app无法上架！
     */
    GTDocumentsDirectories,
   /**
    此目录保存应用程序的所有偏好设置，iOS的Settings(设置)应用会在该目录中查找应用的设置信息。iTunes同步设备时会备份该目录
    在Preferences/下不能直接创建偏好设置文件，而是应该使用NSUserDefaults类来取得和设置应用程序的偏好.
    */
    GTPreferencesDirectories,
    /**
     此目录保存应用程序运行时所需的临时数据，使用完毕后再将相应的文件从该目录删除。应用没有运行时，系统也可能会清除该目录下的文件。iTunes同步设备时不会备份该目录
     */
    GTTmpDirectories
};
@interface GTDiskCache : NSObject
- (void)setObject:(id)anObject forKey:(nonnull id)aKey;
- (id)objectForKey:(id)key;
- (BOOL)containObjectForKey:(id)key;
- (void)setObject:(id)anObject forKey:(id)aKey directories:(GTDiskCacheRootDirectories)directories;
@end
