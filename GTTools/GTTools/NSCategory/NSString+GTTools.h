//
//  NSString+GTTools.h
//  GTTools
//
//  Created by 吴华林 on 2018/6/23.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (GTEncipherment)

/**
 32位的md5 加密

 @return 加密过后的md5
 */
- (NSString *)gt_md5String;


/**
 url 加密
 常用的 NSCharacterSet
 URLHostAllowedCharacterSet      "#%/<>?@\^`{|}
 
 URLFragmentAllowedCharacterSet  "#%<>[\]^`{|}
 
 URLPasswordAllowedCharacterSet  "#%/:<>?@[\]^`{|}
 
 URLPathAllowedCharacterSet      "#%;<>?[\]^`{|}
 
 URLQueryAllowedCharacterSet     "#%<>[\]^`{|}
 
 URLUserAllowedCharacterSet      "#%/:<>?@[\]^`"
 
 @param characters 加密忽略的字符集(默认的值[NSCharacterSet characterSetWithCharactersInString:@"#%^{}\"[]|\\<> ="])
 @return url 加密过后的字符串
 */
- (NSString *)gt_urlEncodingAllowCharacters:(NSCharacterSet *)characters;

/**
 url 解密

 @return 解密过后的字符串
 */
- (NSString *)gt_urlDecoding;

@end

