//
//  GTDiskCache.m
//  GTTools
//
//  Created by 吴华林 on 2018/6/21.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import "GTDiskCache.h"
#import<CommonCrypto/CommonDigest.h>
#import "GTFileManager.h"
#import "GTModelManager.h"
#import <objc/runtime.h>
@interface GTDiskCache()
@property(nonatomic,strong)NSString *cacheDirectoriePath;
@property(nonatomic,strong)NSMutableDictionary *fileAttributeMap;
@end
@implementation GTDiskCache
- (instancetype)init {
    self = [super init];
    if(self) {
        _cacheDirectoriePath = [[GTFileManager cacheDirectoryPath] stringByAppendingPathComponent:@"GTCache"];
    }
    return self;
}
- (instancetype)initWithName:(NSString *)name {
    if(!name || name.length==0) {
        self = [self init];
        return self;
    } else {
        NSString *path = [[GTFileManager cacheDirectoryPath] stringByAppendingPathComponent:name];
        return [self initWithDirectoriePath:path];
    }
}
- (instancetype)initWithDirectoriePath:(NSString *)path {
    
    if(!path || path.length ==0) {
        self = [self init];
    } else {
        _cacheDirectoriePath = path;
        self = [super init];
    }
    return self;
}
- (void)setObject:(id)anObject forKey:(NSString *)aKey {
    if(anObject && aKey) {
        NSString *filePath = [self filePathForKey:aKey];
        id tempObject = nil;
        if([anObject respondsToSelector:@selector(encodeWithCoder:)]) {
            //支持序列化
            tempObject = anObject;
        } else {
            //不支持序列化
           tempObject = [GTModelManager gt_jsonObjectFromModel:anObject];
        }
        if(tempObject) {
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:tempObject];
            [GTFileManager writeData:data toFile:filePath];
            [self.fileAttributeMap setObject:NSStringFromClass([anObject classForKeyedArchiver]) forKey:aKey];
            [self.fileAttributeMap writeToFile:[self filesAttributeFilePath] atomically:YES];
        }
    }
}
- (id)objectForKey:(id)key {
    if([self containObjectForKey:key]) {
        Class objClass = NSClassFromString(self.fileAttributeMap[key]);
        id object = [NSKeyedUnarchiver unarchiveObjectWithFile:[self filePathForKey:key]];
        if([object isKindOfClass:objClass]) {
            return object;
        } else {
         return [GTModelManager gt_createModelWithClass:objClass jsonObject:object];
        }
    }
    return nil;
}
- (BOOL)containObjectForKey:(NSString *)key {
    if(key){
      return [[self.fileAttributeMap allKeys] containsObject:key];
    }
    return NO;
}

#pragma mark private_method
- (NSString *)md5String:(NSString *)inputStr {
    const char *cStr = [inputStr UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return  output;
}
- (NSString *)filePathForKey:(NSString *)key {
    NSString *path = [self.cacheDirectoriePath stringByAppendingPathComponent:[self md5String:key]];
    return path;
}
- (NSString *)filesAttributeFilePath {
    return [_cacheDirectoriePath stringByAppendingPathComponent:[self md5String:@"gt_filesAttributeFile"]];
}
#pragma mark private_method
- (NSMutableDictionary *)fileAttributeMap {
    if(!_fileAttributeMap) {
        NSString *filePath = [self filesAttributeFilePath];
        if([GTFileManager fileExistsAtPath:filePath]) {
            _fileAttributeMap = [NSMutableDictionary dictionaryWithContentsOfFile:[self filesAttributeFilePath]];
        } else {
            [GTFileManager createEmptyFileInPath:filePath];
            _fileAttributeMap = [[NSMutableDictionary alloc] init];
        }
        
    }
    return _fileAttributeMap;
}
@end
