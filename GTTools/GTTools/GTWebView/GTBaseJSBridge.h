//
//  GTJSBridge.h
//  GTTools
//
//  Created by 吴华林 on 2018/6/22.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
extern NSString *const kJSBridgeScheme;
extern NSString *const kBridgeLoaded;
extern  NSString *const kQueueHasMessage;
/**
 回调方法的block

 @param responseData 需要回传的参数
 */
typedef void (^WVJBResponseCallBack)(id responseData);

/**
 带回调的方法block（注册OC 方法给JS使用时候调用）

 @param data 传递给OC 方法的参数
 @param responseCallBack OC方法执行完成的回调
 */
typedef void(^WVJBHandler)(id data,WVJBResponseCallBack responseCallBack);
//消息的类型为NSMutableDictionary
typedef NSMutableDictionary WVJBMessgae;

@protocol GTBaseJSBridgeDelegate
- (NSString *)evaluatingJavaScriptFromString:(NSString *)javaScriptStr;
@end

@interface GTBaseJSBridge : NSObject
@property(nonatomic, strong,readonly)NSMutableDictionary *registerHandlerMDcit;
@property(nonatomic, weak)id<GTBaseJSBridgeDelegate>delegate;
/**
 注入js方法
 */
- (void)injectJavaScript;

/**
  将数据传递给H5

 @param data   需要传递数据
 @param handleName JavaScrpit 接受对象的名称（一般都是funcation）
 @param responseCallBack 回调的方法
 */
- (void)sendData:(id)data handleName:(NSString *)handleName responseCallback:(WVJBResponseCallBack)responseCallBack;
//获取h5 调用原生的消息队列
- (NSString *)fetchH5MessageQueue;
//处理从H5 调用的原生的消息队列
- (void)flushH5MessageQueueString:(NSString *)messageQueueString;
@end
