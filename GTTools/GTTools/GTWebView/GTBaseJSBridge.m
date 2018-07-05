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

NSString *const kFetchMessageQueueFunction = @"_fetchMessageQueue()";
NSString *const kWindowJavascriptBridge = @"webViewJavascriptBridge";
NSString *const kHandleMessageFromNavtive = @"_handleMessageFromNavtive";

//调用的用到的key
NSString *const kMessageHandleName = @"handleName";
NSString *const kMessageCallBackId = @"callBackId";
NSString *const kMessageData = @"data";
//响应的方法key
NSString *const kMessageResponseID = @"responseID";
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
        message[kMessageHandleName] = handleName;
    }
    if(data) {
        message[kMessageData] = data;
    } else {
        message[kMessageData] = @"";
    }
    if(responseCallBack) {
        NSString *responseCallbackKey = [NSString stringWithFormat:@"GTBridgeResponseCallback_%li",responseCallbackID];
        responseCallbackID ++;
        self.responseCallbackMdict[responseCallbackKey] = responseCallBack;
         message[kMessageCallBackId] = responseCallbackKey;
    }
    [self _queueMessage:message];
}
- (NSString *)fetchH5MessageQueue {
   return  [self _evaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@.%@",kWindowJavascriptBridge,kFetchMessageQueueFunction]];
}
- (void)flushH5MessageQueueString:(NSString *)messageQueueString  {
    if(!messageQueueString || messageQueueString.length == 0) {
        NSLog(@"WebViewJavascriptBridge: WARNING: ObjC got nil while fetching the message queue JSON from webview. This can happen if the WebViewJavascriptBridge JS is not currently present in the webview, e.g if the webview just loaded a new page.");
        return;
    } else {
        NSArray *queueMessages = [self _deserializeMessageJSON:messageQueueString];
        if([queueMessages isKindOfClass:[NSArray class]]) {
            for(WVJBMessgae *message in queueMessages) {
                if([message isKindOfClass:[NSDictionary class]]) {
                   NSString *responseID = message[kMessageResponseID];
                    if(responseID) {
                        //表示h5 的回调
                        WVJBResponseCallBack responseCallBack = self.responseCallbackMdict[responseID];
                         NSString *data = message[kMessageData];
                        responseCallBack(data);
                        [self.responseCallbackMdict removeObjectForKey:responseID];
                    } else {
                        //表示h5主动调用
                        NSString *handleName = message[kMessageHandleName];
                        NSString *data = message[kMessageData];
                        NSString *callBackID = message[kMessageCallBackId];
                        WVJBHandler handler = self.registerHandlerMDcit[handleName];
                        if(handler) {
                            WVJBResponseCallBack callBackBlock = ^(id responseData) {
                                if(callBackID) {
                                    WVJBMessgae *responseMessage = [[WVJBMessgae alloc] initWithObjectsAndKeys:callBackID,kMessageResponseID, nil];
                                    
                                    if(responseData) {
                                        responseMessage[kMessageData] = responseData;
                                    }
                                    [self _queueMessage:responseMessage];
                                }
                            };
                            handler(data,callBackBlock);
                        }
                    }
                    
                    
                }
                
            }
        }
    }
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
            NSString *javaScriptStr = [NSString stringWithFormat:@"%@.%@(%@)",kWindowJavascriptBridge,kHandleMessageFromNavtive,messageJSON];
            [self _evaluatingJavaScriptFromString:javaScriptStr];
        }
    }
}
- (NSString *)_evaluatingJavaScriptFromString:(NSString *)javaScriptStr {
   return [self.delegate evaluatingJavaScriptFromString:javaScriptStr];
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
- (id)_deserializeMessageJSON:(NSString *)messageQueueString {
    NSData *data = [messageQueueString dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *dictAry = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    return dictAry;
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
