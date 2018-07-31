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
- (NSString *)gt_md5String {
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return  output;
}
- (NSString *)gt_urlEncodingAllowCharacters:(NSCharacterSet *)characters {
    if(!characters) {
        characters = [NSCharacterSet characterSetWithCharactersInString:@"#%^{}\"[]|\\<> ="];
        return [self stringByAddingPercentEncodingWithAllowedCharacters:characters];
    } else {
         return [self stringByAddingPercentEncodingWithAllowedCharacters:characters];
    }
}
- (NSString *)gt_urlEncoding:(BOOL)flag {
    if(flag) {
       NSString *decodingStr = [self gt_urlDecoding:flag];
       return [decodingStr gt_urlEncodingAllowCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    } else {
        return [self gt_urlEncodingAllowCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    }
}

- (NSString *)gt_urlDecoding:(BOOL)cyclic {
    if(cyclic) {
        NSString *tempStr = self;
        NSString *decodeStr = [self stringByRemovingPercentEncoding];
        while (![tempStr isEqualToString:decodeStr]) {
            tempStr = decodeStr;
            decodeStr = [decodeStr stringByRemovingPercentEncoding];
        }
        return tempStr;
    } else {
       return [self stringByRemovingPercentEncoding];
    }
}
@end
