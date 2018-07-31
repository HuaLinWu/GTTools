//
//  NSURL+GTTools.m
//  GTTools
//
//  Created by 吴华林 on 2018/7/31.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import "NSURL+GTTools.h"
#import "NSString+GTTools.h"
@implementation NSURL (GTTools)
- (NSDictionary *)getURLParamsDict {
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:self resolvingAgainstBaseURL:YES];
    if (!urlComponents) {
        return nil;
    }
    NSMutableDictionary<NSString *, NSString *> *queryParams = [NSMutableDictionary<NSString *, NSString *> new];
    for (NSURLQueryItem *queryItem in [urlComponents queryItems]) {
        if (queryItem.value == nil) {
            continue;
        }
        [queryParams setObject:queryItem.value forKey:queryItem.name];
    }
    return queryParams;
}
- (NSURL *)replaceURLParamWithKey:(NSString *)paramKey value:(NSString *)paramValue {
    
    NSURLComponents *urlComponent = [NSURLComponents componentsWithURL:self resolvingAgainstBaseURL:YES];
    NSMutableArray *newQueryItems = [[NSMutableArray alloc] init];
    BOOL hasParam = NO;
    for (NSURLQueryItem *itemOld in urlComponent.queryItems) {
        if ([itemOld.name isEqualToString:paramKey]) {
            NSURLQueryItem *newQueryItem = [[NSURLQueryItem alloc] initWithName:paramKey value:paramValue];
            [newQueryItems addObject:newQueryItem];
            hasParam = YES;
        } else {
            NSURLQueryItem *newQueryItem = [[NSURLQueryItem alloc] initWithName:itemOld.name value:itemOld.value];
            [newQueryItems addObject:newQueryItem];
        }
    }
    
    if (!hasParam) {
        NSURLQueryItem *codeItem = [[NSURLQueryItem alloc] initWithName:paramKey value:paramValue];
        [newQueryItems addObject:codeItem];
    }
    
   urlComponent.queryItems = newQueryItems.copy;
    return urlComponent.URL;
}
- (NSURL *)removeURLParamWithParamKey:(NSString *)paramKey {
    
    NSURLComponents *urlComponent = [NSURLComponents componentsWithURL:self resolvingAgainstBaseURL:YES];
    NSMutableArray *newQueryItems = urlComponent.queryItems.mutableCopy;
    
    for (NSURLQueryItem *itemOld in urlComponent.queryItems) {
        if ([itemOld.name isEqualToString:paramKey]) {
            [newQueryItems removeObject:itemOld];
        }
    }
    if(newQueryItems.count>0) {
        urlComponent.queryItems = newQueryItems.copy;
    } else {
        urlComponent.queryItems = nil;
    }
    
    return urlComponent.URL;
}
- (NSURL *)removeURLParamWithParamKeys:(NSArray *)paramKeys {
    
    NSURLComponents *urlComponent = [NSURLComponents componentsWithURL:self resolvingAgainstBaseURL:YES];
    NSMutableArray *newQueryItems = urlComponent.queryItems.mutableCopy;
    for (NSURLQueryItem *itemOld in urlComponent.queryItems) {
        for (NSString *urlKey in paramKeys) {
            if ([itemOld.name isEqualToString:urlKey]) {
                [newQueryItems removeObject:itemOld];
            }
        }
    }
    if(newQueryItems.count >0) {
        urlComponent.queryItems = newQueryItems.copy;
    } else {
        urlComponent.queryItems = nil;
    }
     return urlComponent.URL;
}
- (NSURL *)addScheme:(NSString *)scheme needReplace:(BOOL)needReplace {
    if(self.scheme && self.scheme.length>0) {
        if(needReplace) {
            NSURLComponents *urlComponent = [NSURLComponents componentsWithURL:self resolvingAgainstBaseURL:YES];
            urlComponent.scheme = scheme;
            return urlComponent.URL;
        } else {
            return self;
        }
    } else {
        if(!scheme || scheme.length==0) {
            scheme = @"http";
        }
        NSString *urlStr = [self absoluteString];
        NSError *error;
        NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:@"[a-zA-Z0-9]" options:NSRegularExpressionCaseInsensitive error:&error];
        if(!error) {
            NSRange range = [regularExpression rangeOfFirstMatchInString:urlStr options:NSMatchingReportProgress range:NSMakeRange(0, urlStr.length)];
            urlStr = [urlStr stringByReplacingCharactersInRange:NSMakeRange(0, range.length+range.location) withString:@"//"];
        }
        NSURLComponents *urlComponent = [NSURLComponents componentsWithString:urlStr];
        urlComponent.scheme = scheme;
        return urlComponent.URL;
    }
}
@end
