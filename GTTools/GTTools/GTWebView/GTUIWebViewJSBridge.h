//
//  GTUIWebViewJSBridge.h
//  GTTools
//
//  Created by 吴华林 on 2018/6/26.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIWebView.h>
#import "GTBaseJSBridge.h"
@interface GTUIWebViewJSBridge : NSObject<UIWebViewDelegate>

/**
 利用关联的webview 创建JSBridge

 @param webView 需要关联的webview
 @return GTUIWebViewJSBridge 实例
 */
+ (instancetype)bridgeForWebView:(UIView *)webView;
/**
 调用js的方法
 
 @param handlerName js 方法的唯一标示
 @param data 需要传给js 的数据
 @param responseCallback js执行完成的回调方法
 */
- (void)callHandler:(NSString *)handlerName data:(id)data responseCallback:(WVJBResponseCallBack)responseCallback;

/**
 注册方法被js调用
 
 @param handlerName 方法的唯一标示
 @param jbHandler 带js传过来的参数以及回调方法的block
 */
- (void)registerHandler:(NSString *)handlerName handler:(WVJBHandler)jbHandler;
@end
