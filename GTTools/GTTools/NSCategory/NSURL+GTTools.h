//
//  NSURL+GTTools.h
//  GTTools
//
//  Created by 吴华林 on 2018/7/31.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (GTTools)

/**
 获取URL参数

 @return 参数字典
 */
- (NSDictionary *)getURLParamsDict;

/**
 移除URL的参数

 @param paramKey 需要参数的key
 @return 移除参数过后的URL
 */
- (NSURL *)removeURLParamWithParamKey:(NSString *)paramKey;

/**
 移除多个URL的参数

 @param paramKeys 需要移除参数的集合
 @return 移除参数过后的URL
 */
- (NSURL *)removeURLParamWithParamKeys:(NSArray *)paramKeys;

/**
 替换URL的参数的值（如果不存在对应key，则添加key/value 参数，如果存在则替换）

 @param paramKey 需要替换key
 @param paramValue 对应的value
 @return 返回替换过后的URL
 */
- (NSURL *)replaceURLParamWithKey:(NSString *)paramKey value:(NSString *)paramValue;
/**
 给URL 添加scheme

 @param scheme 需要添加的scheme (如果这个值为空，默认值为http)
 @param needReplace 如果设置YES,表示用新的scheme 替换老的scheme，NO表示如果URL 有scheme不变化，没有则添加
 */
- (NSURL *)addScheme:(NSString *)scheme needReplace:(BOOL)needReplace;

@end
