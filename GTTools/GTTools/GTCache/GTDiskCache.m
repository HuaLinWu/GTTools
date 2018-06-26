//
//  GTDiskCache.m
//  GTTools
//
//  Created by 吴华林 on 2018/6/21.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import "GTDiskCache.h"
#import<CommonCrypto/CommonDigest.h>
@implementation GTDiskCache
- (void)setObject:(id)anObject forKey:(nonnull id)aKey {
    
}
- (id)objectForKey:(id)key {
    return nil;
}
- (BOOL)containObjectForKey:(id)key {
    return NO;
}
- (void)setObject:(id)anObject forKey:(id)aKey directories:(GTDiskCacheRootDirectories)directories {
    
}
#pragma mark private_method
- (NSString *)pathWithKey:(id)aKey directories:(GTDiskCacheRootDirectories)directories {
    NSString *rootPath = @"";
    switch (directories) {
        case GTCachesDirectories: {
            
            break;
        }
        case GTDocumentsDirectories: {
            break;
        }
        case GTPreferencesDirectories: {
            break;
        }
        case GTTmpDirectories: {
            break;
        }
    }
    NSString *path = @"";
    return path;
}
- (NSString *)md5String:(NSString *)inputStr {
    const char *cStr = [inputStr UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return  output;
}
@end
