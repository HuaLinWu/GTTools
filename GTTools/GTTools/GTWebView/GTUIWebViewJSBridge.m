//
//  GTUIWebViewJSBridge.m
//  GTTools
//
//  Created by 吴华林 on 2018/6/26.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import "GTUIWebViewJSBridge.h"
@interface GTUIWebViewJSBridge()<GTBaseJSBridgeDelegate>
@property(nonatomic, strong)GTBaseJSBridge *baseJSBridge;
@property(nonatomic, weak)UIView *webView;
@end
@implementation GTUIWebViewJSBridge
+ (instancetype)bridgeForWebView:(UIView *)webView {
    if(!webView) {
        if([webView isKindOfClass:[UIWebView class]]) {
            GTUIWebViewJSBridge *bridge = [GTUIWebViewJSBridge new];
            ((UIWebView *)webView).delegate = bridge;
            bridge.webView = webView;
            return bridge;
        } else {
            return nil;
        }
    } else {
        return nil;
    }
}
- (void)callHandler:(NSString *)handlerName data:(id)data responseCallback:(WVJBResponseCallBack)responseCallback {
    
}
- (void)registerHandler:(NSString *)handlerName handler:(WVJBHandler)jbHandler {
    self.baseJSBridge.registerHandlerMDcit[handlerName] = [jbHandler copy];
}
#pragma mark UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if(self.webView!=webView) {
        return YES;
    } else if([self isMatchURL:request.URL]) {
        if([self isLoadMessage:request.URL]) {
            //刚开始记载方法执行
        } else if ([self isQueueMessage:request.URL]) {
            //执行方法队列的方法
            
        } else {
            //未知的方法
            return YES;
        }
        
        return NO;
    } else {
         return YES;
    }
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
}
#pragma mark GTBaseJSBridgeDelegate
- (void)evaluatingJavaScriptFromString:(NSString *)javaScriptStr {
    if([self.webView isKindOfClass:[UIWebView class]]) {
        [(UIWebView *)self.webView stringByEvaluatingJavaScriptFromString:javaScriptStr];
    }
}
#pragma mark private_method
- (BOOL)isMatchURL:(NSURL *)url {
    if(!url) {
        return NO;
    } else {
        if([[url.scheme lowercaseString] isEqualToString:kJSBridgeScheme]) {
            return YES;
        } else {
            return NO;
        }
    }
}
- (BOOL)isLoadMessage:(NSURL *)url {
    if([[url.host lowercaseString] isEqualToString:kBridgeLoaded]) {
        return YES;
    } else {
        return NO;
    }
}
- (BOOL)isQueueMessage:(NSURL *)url {
    if([[url.host lowercaseString] isEqualToString:kQueueHasMessage]) {
        return YES;
    } else {
        return NO;
    }
}
#pragma mark set/get
- (GTBaseJSBridge *)baseJSBridge {
    if(!_baseJSBridge) {
        _baseJSBridge = [[GTBaseJSBridge alloc] init];
        _baseJSBridge.delegate = self;
    }
    return _baseJSBridge;
}
@end
