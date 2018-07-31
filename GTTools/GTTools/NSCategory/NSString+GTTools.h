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
 对字符串进行URL加密（本方法会调用@link gt_urlEncodingAllowCharacters: 参数是URLQueryAllowedCharacterSet）
 @param flag YES 表示对本URL只加密一次，不循环加密，NO 表示多次调用了会对同一个URL多次加密
 @return 返回加密过后的URL字符串
 */
- (NSString *)gt_urlEncoding:(BOOL)flag;

/**
 解密URL字符串

 @param cyclic YES表示循环解密字符串，直到不再变化，NO，只解密一次
 @return 解密过后url
 */
- (NSString *)gt_urlDecoding:(BOOL)cyclic;

@end

