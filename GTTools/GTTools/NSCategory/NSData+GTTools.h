//
//  NSData+GTTools.h
//  GTTools
//
//  Created by 吴华林 on 2018/6/29.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (GTEncrypt)

/**
 AES加密(256位)

 @param key  密钥
 @return 加密过后的数据
 */
- (NSData *)aesEncrypt:(NSString *)key;

/**
 AES解密(256位)

 @param key 密钥
 @return 解密过后的数据
 */
- (NSData *)aesDecrypt:(NSString *)key;

/**
 base64 加密

 @return 加密过后的NSData
 */
- (NSData *)base64Encode;

/**
 base64 解密

 @return 解密过后的NSData
 */
- (NSData *)base64Decode;
@end
