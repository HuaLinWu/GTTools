//
//  HZRoute+OpenURL.m
//  HZRoute
//
//  Created by 吴华林 on 2017/10/24.
//  Copyright © 2017年 吴华林. All rights reserved.
//

#import "GTRoute+OpenURL.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "GTRoute+PresentViewController.h"
#import "GTRouteGlobalConstant.h"
typedef NS_ENUM(NSInteger,URLType) {
    isAPPURL,//表示APP 的url
    isWebURL,//表示是webURL 的url
    isSystemURL// 打开系统的url
};
@implementation GTRoute (OpenURL)
void openURL(NSString *url) {
    openURLWithParameter(url, nil);
}
void openURLWithParameter(NSString *url,NSDictionary *extendParameter) {
    if(!url) return;
    static GTRoute *route = nil;
    route = [GTRoute shareRoute];
    NSURL *routeURL = nil;
    if([url isKindOfClass:[NSString class]]) {
        routeURL = [NSURL URLWithString:[route URLEncodedString:url]];
    } else if([url isKindOfClass:[NSURL class]]) {
        routeURL = (NSURL *)url;
    }
    [route openURL:routeURL parameter:extendParameter];
}
#pragma mark private_method
- (void)openURL:(NSURL *)url parameter:(NSDictionary *)parameterDict {
    URLType urlType = [self getURLType:url];
    switch (urlType) {
        case isAPPURL:{
            [self openAPPURL:url parameter:parameterDict];
            break;
        }
        case isWebURL: {
            [self openWebURL:url parameter:parameterDict];
            break;
        }
        case isSystemURL: {
            [self openSystemURL:url];
            break;
        }
    }
}
- (void)openWebURL:(NSURL *)url parameter:(NSDictionary *)parameterDict{
    
    NSDictionary *queryDict = [self getQueryForURL:url];
    NSString *webURLOpenTypeQueryName = [self getValidGlobalConstant:kWebURLOpenTypeQueryName];
    NSString *webURLOpenWithBrowserValue = [self getValidGlobalConstant:kWebURLOpenWithBrowserValue];
    if(queryDict[webURLOpenTypeQueryName] && [queryDict[webURLOpenTypeQueryName] isEqualToString:webURLOpenWithBrowserValue]) {
        //表示用自带的浏览器打开
        [self openSystemURL:url];
    } else {
        //创建webView
        Class webViewClass = NSClassFromString([self getValidGlobalConstant:kWebViewClass]);
        NSString *method = [self getInitMethodForClass:kWebViewClass];
        if(webViewClass) {
            id webView = nil;
            NSString *urlStr = [url absoluteString];
            if(!url.scheme){
                NSString *urlScheme = [self getValidGlobalConstant:kDefaultURLScheme];
                urlStr = [NSString stringWithFormat:@"%@://%@",urlScheme,urlStr];
            }
             NSString *tempWebViewURLName = [self getValidGlobalConstant:kWebViewURLName];
            NSMutableDictionary *lastDict = [[NSMutableDictionary alloc] init];
            if(urlStr) {
                 [lastDict setObject:urlStr forKey:tempWebViewURLName];
            }
            if(queryDict) {
                [lastDict setValuesForKeysWithDictionary:queryDict];
            }
            if(parameterDict) {
                [lastDict setValuesForKeysWithDictionary:parameterDict];
            }
            webView = [self generatorViewControllerWithClass:webViewClass method:method parameter:lastDict];
            //呈现方式
            HZRPresentType presentType = HZRPush;
             NSString *tempPresentTypeName = [self getValidGlobalConstant:kPresentTypeName];
            NSString *tempPresentTypePresentValue = [self getValidGlobalConstant:kPresentTypePresentValue];
            if(queryDict[tempPresentTypeName] && [queryDict[tempPresentTypeName] isEqualToString:tempPresentTypePresentValue]) {
                presentType = HZRPresent;
            }
#pragma mark 页面跳转逻辑(本地页面跳转)
            [self presentViewController:webView tryPresentType:presentType animated:YES completion:nil];
        }
    }
}
- (void)openSystemURL:(NSURL *)url {
    if([[UIApplication sharedApplication] canOpenURL:url]) {
        
#ifdef __IPHONE_10_0
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        
#else
        [[UIApplication sharedApplication] openURL:url];
#endif
        
    }
}
- (void)openAPPURL:(NSURL *)url parameter:(NSDictionary *)parameterDict {
    NSString *host = url.host;
    NSString *path = url.path;
    NSString *viewHost = [self getValidGlobalConstant:kViewHost];
    NSString *serviceHost = [self getValidGlobalConstant:kServiceHost];
    if([host isEqualToString:viewHost]) {
        //表明是一个页面跳转
        if(path) {
            NSArray *paths = [path componentsSeparatedByString:@"/"];
            path = paths[paths.count -1];
            NSString*classUrl =[self needReplaceByURLFromIdentifier:path];
            if(classUrl && classUrl.length>0){
                //如果存在替换的URL的时候
                [self openURL:[NSURL URLWithString:[self URLEncodedString:classUrl]] parameter:parameterDict];
                return;
            }
            NSString *className = [self classNameFromIdentifier:path];
            NSString *method = [self getInitMethodForIdentifier:path];
            Class viewControllerClass = NSClassFromString(className);
            if(viewControllerClass) {
                NSDictionary *queryDict = [self getQueryForURL:url];
                NSMutableDictionary *lastDict = [[NSMutableDictionary alloc] init];
                if(queryDict) {
                    [lastDict setValuesForKeysWithDictionary:queryDict];
                }
                if(parameterDict) {
                    [lastDict setValuesForKeysWithDictionary:parameterDict];
                }
                id viewController = [self generatorViewControllerWithClass:viewControllerClass method:method parameter:lastDict];
                //呈现方式
                HZRPresentType presentType = HZRPush;
                NSString *tempPresentTypeName = [self getValidGlobalConstant:kPresentTypeName];
                NSString *tempPresentTypePresentValue = [self getValidGlobalConstant:kPresentTypePresentValue];
                if(queryDict[tempPresentTypeName] && [queryDict[tempPresentTypeName] isEqualToString:tempPresentTypePresentValue]) {
                    presentType = HZRPresent;
                }
#pragma mark 页面跳转逻辑(本地页面跳转)
                [self presentViewController:viewController tryPresentType:presentType animated:YES completion:nil];
                
            }
        }
    } else if([serviceHost isEqualToString:host]) {
        //表明名是一个方法调用
#pragma mark 表明名是一个方法调用
        NSArray *paths = [path componentsSeparatedByString:@"/"];
        NSString *className = nil;
        NSString *method = nil;
        if(paths.count >1) {
            className = paths[1];
            method = paths[2];
        }
        Class viewControllerClass = NSClassFromString(className);
        if(viewControllerClass) {
            id viewController = [[viewControllerClass alloc] init];
            SEL methodSel = NSSelectorFromString(method);
            if(methodSel && [viewController respondsToSelector:methodSel]) {
                Method method = class_getInstanceMethod(viewControllerClass, methodSel);
                int  numberArguments =  method_getNumberOfArguments(method);
                NSDictionary *queryDict = [self getQueryForURL:url];
                if(numberArguments ==2) {
                    //表示方法没有参数
                    IMP imp = [viewController methodForSelector:methodSel];
                    void *(*func)(id,SEL) = (void *)imp;
                    func(viewController,methodSel);
                }else  {
                    //表示至少有一个参数，不过我们只会对第一个参数赋queryDict 的参数
                    IMP imp = [viewController methodForSelector:methodSel];
                    void *(*func)(id,SEL,id) = (void *)imp;
                    func(viewController,methodSel,queryDict);
                }
            }
        }
    }
}

- (NSString *)URLEncodedString:(NSString *)url
{
    NSCharacterSet *allowedCharacters = [NSCharacterSet URLFragmentAllowedCharacterSet];
    NSString*encodedString = [url stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    return encodedString;
}
-(NSString *)URLDecodedString:(NSString *)url
{
    return url.stringByRemovingPercentEncoding;
}
#pragma mark set/get
- (URLType)getURLType:(NSURL *)url {
    NSString *scheme = [url.scheme lowercaseString];
    //获取系统scheme
    NSArray *bundleURLTypes = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleURLTypes"];
    for(NSDictionary *bundleURLTypeDict in bundleURLTypes) {
        NSArray *schemes = bundleURLTypeDict[@"CFBundleURLSchemes"];
        for(NSString *tempScheme in schemes) {
            if([[tempScheme lowercaseString] isEqualToString:scheme]) return isAPPURL;
        }
    }
    //表示为webView的链接
    NSString *regulaStr = @"((http[s]?|ftp|news|gopher|mailto)://)?[a-zA-Z0-9]+\\.[a-zA-Z0-9]+\\.[a-zA-Z0-9]+(\\.[a-zA-Z0-9]+)?(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *urlStr = [url absoluteString];
    NSTextCheckingResult *checkingResult = [regex firstMatchInString:urlStr options:NSMatchingReportProgress range:NSMakeRange(0, urlStr.length)];
    if(checkingResult) return isWebURL;
    
    
    //默认的是系统的url
    return isSystemURL;
}

- (NSDictionary *)getQueryForURL:(NSURL *)url {
    
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:NO];
    NSArray <NSURLQueryItem *>*items = urlComponents.queryItems;
    NSMutableDictionary *queryDict = [[NSMutableDictionary alloc] init];
    for(NSURLQueryItem *queryItem in items) {
        if(queryItem.value) {
            [queryDict setObject:queryItem.value forKey:queryItem.name];
        }
    }
    return [queryDict copy];
}
- (NSString *)needReplaceByURLFromIdentifier:(NSString *)pageIdentifier {
    NSDictionary *pageDict = [self.viewMap objectForKey:pageIdentifier];
    BOOL needReplace = [[pageDict objectForKey:@"needReplace"] boolValue];
    if(needReplace) {
        return [pageDict objectForKey:@"url"];
    }
    return nil;
}
- (NSString *)classNameFromIdentifier:(NSString *)pageIdentifier {
     NSDictionary *pageDict = [self.viewMap objectForKey:pageIdentifier];
    return [pageDict objectForKey:@"className"];
}

@end
