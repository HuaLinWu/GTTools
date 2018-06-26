//
//  GTJSBridge.m
//  GTTools
//
//  Created by 吴华林 on 2018/6/22.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import "GTBaseJSBridge.h"
NSString *const kJSBridgeScheme = @"https";
NSString *const kBridgeLoaded = @"__bridge_loaded__";
NSString *const kQueueHasMessage = @"__wvjb_queue_message__";
@interface GTBaseJSBridge()
{
    NSMutableDictionary *_registerHandlerMDcit;
    NSMutableArray<WVJBMessgae *> *startUpMessageMarray;
    NSUInteger responseCallbackID;
}
@property(nonatomic, strong)  NSMutableDictionary *responseCallbackMdict;
@end
@implementation GTBaseJSBridge
- (instancetype)init {
    self = [super init];
    startUpMessageMarray = [[NSMutableArray alloc] init];
    return self;
}
#pragma mark public
- (void)injectJavaScript {
    //初始化
    
    //将需要执行js执行一遍
    if(startUpMessageMarray) {
        NSMutableArray<WVJBMessgae *> *tempMessageMarray = startUpMessageMarray;
        startUpMessageMarray = nil;
        for(WVJBMessgae *message in tempMessageMarray) {
            [self _dispatchMessage:message];
        }
    }
}
- (void)sendData:(id)data handleName:(NSString *)handleName responseCallback:(WVJBResponseCallBack)responseCallBack {
    WVJBMessgae *message = [WVJBMessgae new];
    if(handleName) {
        message[@"handleName"] = handleName;
    }
    if(data) {
        message[@"data"] = data;
    }
    if(responseCallBack) {
        NSString *responseCallbackKey = [NSString stringWithFormat:@"GTBridgeResponseCallback_%li",responseCallbackID];
        responseCallbackID ++;
        self.responseCallbackMdict[responseCallbackKey] = responseCallBack;
         message[@"responseID"] = responseCallbackKey;
    }
    [self _dispatchMessage:message];
}
#pragma mark private
- (void)_queueMessage:(WVJBMessgae *)message {
    if(startUpMessageMarray) {
        //没有完成JS注入放入到消息队列中等待调用
        [startUpMessageMarray addObject:message];
    } else {
        //已经完成了JS注入以后直接调用
        [self _dispatchMessage:message];
    }
}
- (void)_dispatchMessage:(WVJBMessgae *)message {
    if([message allValues].count == 0) {
        return;
    } else {
        NSString *messageJSON = [self _serializeMessage:message];
        if(messageJSON) {
            messageJSON = [messageJSON stringByReplacingOccurrencesOfString:@"\\" withString:@"\\\\"];
            messageJSON = [messageJSON stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
            messageJSON = [messageJSON stringByReplacingOccurrencesOfString:@"\'" withString:@"\\\'"];
            messageJSON = [messageJSON stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
            messageJSON = [messageJSON stringByReplacingOccurrencesOfString:@"\r" withString:@"\\r"];
            messageJSON = [messageJSON stringByReplacingOccurrencesOfString:@"\f" withString:@"\\f"];
            messageJSON = [messageJSON stringByReplacingOccurrencesOfString:@"\u2028" withString:@"\\u2028"];
            messageJSON = [messageJSON stringByReplacingOccurrencesOfString:@"\u2029" withString:@"\\u2029"];
            NSString *javaScriptStr = [NSString stringWithFormat:@"WebViewJavascriptBridge._handleMessageFromObjC(%@)",messageJSON];
            [self _evaluatingJavaScriptFromString:javaScriptStr];
        }
    }
}
- (void)_evaluatingJavaScriptFromString:(NSString *)javaScriptStr {
    [self.delegate evaluatingJavaScriptFromString:javaScriptStr];
}
- (NSString *)_serializeMessage:(WVJBMessgae *)message {
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:message options:NSJSONWritingPrettyPrinted error:&error];
    if(data) {
        NSString *jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if(jsonStr) {
            return jsonStr;
        } else {
            
            return nil;
        }
    } else {
        return nil;
    }
}
#pragma mark set/get
- (NSMutableDictionary *)registerHandlerMDcit {
    if(!_registerHandlerMDcit) {
        _registerHandlerMDcit = [[NSMutableDictionary alloc] init];
    }
    return _registerHandlerMDcit;
}
- (NSMutableDictionary *)responseCallbackMdict {
    if(!_responseCallbackMdict) {
        _responseCallbackMdict = [[NSMutableDictionary alloc] init];
    }
    return _responseCallbackMdict;
}
@end
