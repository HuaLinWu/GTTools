//
//  NSData+GTTools.m
//  GTTools
//
//  Created by 吴华林 on 2018/6/29.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import "NSData+GTTools.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
@implementation NSData (GTEncrypt)
- (NSData *)aesEncrypt:(NSString *)key {
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [self length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeAES128,
                                          NULL,
                                          [self bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    NSData *returnData = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    free(buffer);
    if (cryptStatus == kCCSuccess) {
        return returnData;
    }
    return nil;
}
- (NSData *)aesDecrypt:(NSString *)key {
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [self length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeAES128,
                                          NULL,
                                          [self bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesDecrypted);
    NSData *returnData = [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    free(buffer);
    if (cryptStatus == kCCSuccess) {
        return returnData;
    }
    return nil;
}
- (NSData *)base64Encode {
    return [self base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
}
- (NSData *)base64Decode {
    return [[NSData alloc] initWithBase64EncodedData:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
}
@end
