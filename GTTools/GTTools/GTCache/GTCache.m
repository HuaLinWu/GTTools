//
//  GTCache.m
//  GTTools
//
//  Created by 吴华林 on 2018/8/3.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import "GTCache.h"
#import "GTDiskCache.h"
#import "GTMemoryCache.h"
#import "GTFileManager.h"
#import "UICKeyChainStore.h"
#import "GTModelManager.h"
#import <objc/runtime.h>
static const NSString *kGTCacheData = @"GTCacheData";
static const NSString *kGTCacheDataClass= @"GTCacheDataClass";
@interface GTCache()
@property(nonatomic,strong,class)GTMemoryCache *memoryCache;
@end
@implementation GTCache
@dynamic memoryCache;
+ (id)objectForKey:(NSString *)key {
    return [self objectForKey:key fromDirectoire:GTCacheDocument];
}
+ (id)objectForKey:(NSString *)key fromDirectoire:(GTCacheDirectoire)cacheDirectoire {
    id object = [self.memoryCache objectForKey:key];
    if(!object) {
        switch (cacheDirectoire) {
            case GTCacheDocument: {
                GTDiskCache *diskCache = [[GTDiskCache alloc] initWithDirectoriePath:[self documentDiskCachePath]];
                object = [diskCache objectForKey:key];
                break;
            }
            case GTCacheCaches: {
                GTDiskCache *diskCache = [[GTDiskCache alloc] initWithDirectoriePath:[self cacheDiskCachePath]];
                object = [diskCache objectForKey:key];
                break;
            }
            case GTCacheTemp: {
                GTDiskCache *diskCache = [[GTDiskCache alloc] initWithDirectoriePath:[self tempDiskCachePath]];
                object = [diskCache objectForKey:key];
                break;
            }
            case GTCacheUserDefault: {
                NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:key];
                id tempObject= [NSKeyedUnarchiver unarchiveObjectWithData:data];
                if([tempObject isKindOfClass:[NSDictionary class]]) {
                    if([[tempObject allKeys] containsObject:kGTCacheDataClass]) {
                        Class objectClass = NSClassFromString([tempObject objectForKey:kGTCacheDataClass]);
                        id objectData = [tempObject objectForKey:kGTCacheData];
                       object = [GTModelManager gt_createModelWithClass:objectClass jsonObject:objectData];
                    } else {
                        object = tempObject;
                    }
                }else {
                    object = tempObject;
                }
                break;
            }
            case GTCacheKeyChain: {
                NSData *data = [UICKeyChainStore dataForKey:key];
                id tempObject= [NSKeyedUnarchiver unarchiveObjectWithData:data];
                if([tempObject isKindOfClass:[NSDictionary class]]) {
                    if([[tempObject allKeys] containsObject:kGTCacheDataClass]) {
                        Class objectClass = NSClassFromString([tempObject objectForKey:kGTCacheDataClass]);
                        id objectData = [tempObject objectForKey:kGTCacheData];
                        object = [GTModelManager gt_createModelWithClass:objectClass jsonObject:objectData];
                    } else {
                        object = tempObject;
                    }
                }else {
                    object = tempObject;
                }
                break;
            }
            default:{
                object = nil;
                break;
            }
        }
    }
   
    return object;
}
+ (void)saveObject:(id)object forKey:(NSString *)key {
    [self saveObject:object forKey:key toDirectoire:GTCacheDocument];
}
+ (void)removeObjectForKey:(NSString *)key {
    [self.memoryCache removeObjectForKey:key];
    [self removeObjectForKey:key inDirectoire:GTCacheDocument];
}
+ (void)saveObject:(id)object forKey:(NSString *)key toDirectoire:(GTCacheDirectoire)cacheDirectoire {
    switch (cacheDirectoire) {
        case GTCacheDocument: {
            [self.memoryCache setObject:object forKey:key];
            GTDiskCache *diskCache = [[GTDiskCache alloc] initWithDirectoriePath:[self documentDiskCachePath]];
            [diskCache setObject:object forKey:key];
            break;
        }
        case GTCacheCaches: {
            [self.memoryCache setObject:object forKey:key];
             GTDiskCache *diskCache = [[GTDiskCache alloc] initWithDirectoriePath:[self cacheDiskCachePath]];
             [diskCache setObject:object forKey:key];
            break;
        }
        case GTCacheTemp: {
            [self.memoryCache setObject:object forKey:key];
             GTDiskCache *diskCache = [[GTDiskCache alloc] initWithDirectoriePath:[self tempDiskCachePath]];
             [diskCache setObject:object forKey:key];
            break;
        }
        case GTCacheUserDefault: {
            [self.memoryCache setObject:object forKey:key];
            id tempObject = nil;
            if([object respondsToSelector:@selector(encodeWithCoder:)]) {
                //支持序列化
                tempObject = object;
            } else {
                //不支持序列化
                tempObject = [GTModelManager gt_jsonObjectFromModel:object];
                NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                if(tempObject) {
                    [dict setObject:tempObject forKey:kGTCacheData];
                    [dict setObject:NSStringFromClass([object class])  forKey:kGTCacheDataClass];
                    tempObject = dict;
                }
            }
            
            if(tempObject) {
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:tempObject];
                [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
                 [[NSUserDefaults standardUserDefaults] synchronize];
            }
           
            break;
        }
        case GTCacheKeyChain: {
            [self.memoryCache setObject:object forKey:key];
            id tempObject = nil;
            if([object respondsToSelector:@selector(encodeWithCoder:)]) {
                //支持序列化
                tempObject = object;
            } else {
                //不支持序列化
                tempObject = [GTModelManager gt_jsonObjectFromModel:object];
                NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                if(tempObject) {
                    [dict setObject:tempObject forKey:kGTCacheData];
                    [dict setObject:NSStringFromClass([object class])  forKey:kGTCacheDataClass];
                    tempObject = dict;
                }
            }
            if(tempObject) {
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:tempObject];
                [UICKeyChainStore setData:data forKey:key];
            }
            
            break;
        }
        case GTCacheMemory: {
            [self.memoryCache setObject:object forKey:key];
            break;
        }
        default: {
            [self.memoryCache setObject:object forKey:key];
            break;
        }
    }
}
+ (void)removeObjectForKey:(NSString *)key inDirectoire:(GTCacheDirectoire)cacheDirectoire {
    switch (cacheDirectoire) {
        case GTCacheDocument: {
            [self.memoryCache removeObjectForKey:key];
            GTDiskCache *diskCache = [[GTDiskCache alloc] initWithDirectoriePath:[self documentDiskCachePath]];
            [diskCache removeObjectForKey:key];
            break;
        }
        case GTCacheCaches: {
            [self.memoryCache removeObjectForKey:key];
            GTDiskCache *diskCache = [[GTDiskCache alloc] initWithDirectoriePath:[self cacheDiskCachePath]];
           [diskCache removeObjectForKey:key];
            break;
        }
        case GTCacheTemp: {
            [self.memoryCache removeObjectForKey:key];
            GTDiskCache *diskCache = [[GTDiskCache alloc] initWithDirectoriePath:[self tempDiskCachePath]];
           [diskCache removeObjectForKey:key];
            break;
        }
        case GTCacheUserDefault: {
            [self.memoryCache removeObjectForKey:key];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
            [[NSUserDefaults standardUserDefaults] synchronize];
            break;
        }
        case GTCacheKeyChain: {
            [self.memoryCache removeObjectForKey:key];
            [UICKeyChainStore removeItemForKey:key];
            
            break;
        }
        case GTCacheMemory: {
             [self.memoryCache removeObjectForKey:key];
            break;
        }
        default: {
             [self.memoryCache removeObjectForKey:key];
            break;
        }
    }
}
+ (void)removeAllObjectForKey:(NSString *)key {
     [self removeObjectForKey:key inDirectoire:GTCacheDocument];
     [self removeObjectForKey:key inDirectoire:GTCacheCaches];
     [self removeObjectForKey:key inDirectoire:GTCacheTemp];
     [self removeObjectForKey:key inDirectoire:GTCacheUserDefault];
     [self removeObjectForKey:key inDirectoire:GTCacheKeyChain];
}
+ (void)removeAllObjectInDirectoire:(GTCacheDirectoire)cacheDirectoire {
    switch (cacheDirectoire) {
        case GTCacheDocument: {
            
            GTDiskCache *diskCache = [[GTDiskCache alloc] initWithDirectoriePath:[self documentDiskCachePath]];
            [diskCache removeAllObject];
            break;
        }
        case GTCacheCaches: {
            GTDiskCache *diskCache = [[GTDiskCache alloc] initWithDirectoriePath:[self cacheDiskCachePath]];
            [diskCache removeAllObject];
            break;
        }
        case GTCacheTemp: {
            GTDiskCache *diskCache = [[GTDiskCache alloc] initWithDirectoriePath:[self tempDiskCachePath]];
           [diskCache removeAllObject];
            break;
        }
        case GTCacheUserDefault: {
            NSUserDefaults*userDefaults = [NSUserDefaults  standardUserDefaults];
            NSDictionary*dic = [userDefaults  dictionaryRepresentation];
            for(id key in dic) {
                [userDefaults  removeObjectForKey:key];
            }
            [userDefaults  synchronize];
            break;
        }
        case GTCacheKeyChain: {
            [UICKeyChainStore removeAllItems];
            break;
        }
        case GTCacheMemory: {
            [self.memoryCache removeAllObject];
            break;
        }
        default: {
            [self.memoryCache removeAllObject];
            break;
        }
    }
}
+ (void)removeAllObject {
    [self.memoryCache removeAllObject];
    [self removeAllObjectInDirectoire:GTCacheDocument];
    [self removeAllObjectInDirectoire:GTCacheCaches];
    [self removeAllObjectInDirectoire:GTCacheTemp];
    [self removeAllObjectInDirectoire:GTCacheUserDefault];
    [self removeAllObjectInDirectoire:GTCacheKeyChain];
    [self removeAllObjectInDirectoire:GTCacheMemory];
}

#pragma mark private_method

+ (NSString *)documentDiskCachePath {
   NSString *cacheDirectory = [[GTFileManager documentDirectoryPath] stringByAppendingPathComponent:@"GTCache"];
    if(![GTFileManager fileExistsAtPath:cacheDirectory]) {
        [GTFileManager createDirectoryInPath:cacheDirectory];
    }
    return cacheDirectory;
}
+ (NSString *)cacheDiskCachePath {
    NSString *cacheDirectory = [[GTFileManager cacheDirectoryPath] stringByAppendingPathComponent:@"GTCache"];
    if(![GTFileManager fileExistsAtPath:cacheDirectory]) {
        [GTFileManager createDirectoryInPath:cacheDirectory];
    }
    return cacheDirectory;
}
+ (NSString *)tempDiskCachePath {
    NSString *cacheDirectory = [[GTFileManager tempDirectoryPath] stringByAppendingPathComponent:@"GTCache"];
    if(![GTFileManager fileExistsAtPath:cacheDirectory]) {
        [GTFileManager createDirectoryInPath:cacheDirectory];
    }
    return cacheDirectory;
}

#pragma mark set/get
+ (GTMemoryCache *)memoryCache {
   GTMemoryCache *memoryCache = objc_getAssociatedObject(self, "memoryCache");
    if(!memoryCache) {
        memoryCache = [[GTMemoryCache alloc] init];
        objc_setAssociatedObject(self, "memoryCache", memoryCache,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return memoryCache;
}

@end
