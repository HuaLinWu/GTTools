//
//  NSString+GTTools.m
//  GTTools
//
//  Created by 吴华林 on 2018/6/23.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import "NSString+GTTools.h"
#import<CommonCrypto/CommonDigest.h>
@implementation NSString (GTEncipherment)
- (NSString *)md5String {
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return  output;
}
@end
