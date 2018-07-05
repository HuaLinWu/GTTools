//
//  GTWebViewJSBridge_JS.m
//  GTTools
//
//  Created by 吴华林 on 2018/7/5.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import "GTWebViewJSBridge_JS.h"
NSString * webViewJavascriptBridge_js(void) {
#define __wvjb_js_func__(x) #x
static NSString *preprocessorJSCode = @__wvjb_js_func__(
;(function(){

        if(window.webViewJavascriptBridge) {
            return;
        }
        if(!window.onerror) {
            window.onerror = function (message,url,line,column,error) {
                console.log("webViewJavascriptBridge: ERROR:" + msg + "@" + url + ":" + line);
            }
        }
    
            //调用的用到的key
            const kMessageHandleName = "handleName";
            const kMessageCallBackId = "callBackId";
            const kMessageData = "data";
            //响应的方法key
            const kMessageResponseID = "responseID";
            
            const kJSBridgeScheme = "https";
            const kBridgeLoaded = "__bridge_loaded__";
            const kQueueHasMessage = "__wvjb_queue_message__";
            var messagingIframe;
            var uniqueId =1;
            
            window.webViewJavascriptBridge = {
            registerHandler:registerHandler,
                callHandler : callHandler,
            _handleMessageFromNavtive:_handleMessageFromNavtive,
                _fetchMessageQueue :_fetchMessageQueue
            }
            
            var registerHandlerDict ={};
            var responseCallBackDict={};
            var messageQueue = [];
            function registerHandler(handleName,handler) {
                if(handleName && handler) {
                    registerHandlerDict[handleName] = handler;
                }
            }
            function callHandler(handleName,data,responseCallBack) {
                var message = {};
                if(typeof(handleName) !='string') {
                    console.log("handleName 不是string 类型")
                } else {
                    message[kMessageHandleName]=handleName;
                    if(arguments.length ==2) {
                        //传入的只有两个参数的时候
                        if(typeof(data) == 'function') {
                            //传入的是function 的时候
                            responseCallBack = data;
                            message[kMessageData] = null;
                            _doSendMessage(message,responseCallBack);
                        } else {
                            message[kMessageData] = data;
                            _doSendMessage(message);
                        }
                    } else {
                        //传入的参数是三个的时候
                        message[kMessageData] = data;
                        _doSendMessage(message,responseCallBack);
                    }
                    messagingIframe.src = kJSBridgeScheme+"://"+kQueueHasMessage;
                }
            }
            function _handleMessageFromNavtive(messageJSon) {
                if(messageJSon) {
                    var dict = JSON.parse(messageJSon);
                    if(typeof(dict) == 'Object'){
                        var responseID = dict[kMessageResponseID];
                        var data = dict[kMessageData];
                        
                        if(responseID) {
                            //表示原生的回调
                            var responseCallBack = responseCallBackDict[responseID];
                            if(responseCallBack) {
                                responseCallBack(data);
                            }
                            delete responseCallBackDict[responseID];
                            return;
                        } else {
                            //表示原生直接调用H5的方法
                            var handleName = dict[kMessageHandleName];
                            if(handleName){
                                var handler = registerHandlerDict[handleName];
                                if(handler) {
                                    handler(data,function(responseData){
                                        var message = {}
                                        message[kMessageResponseID] = dict[kMessageCallBackId];
                                        if(responseData) {
                                            message[kMessageData] = responseData;
                                        } else {
                                            message[kMessageData] = "";
                                        }
                                        _doSendMessage(message);
                                    });
                                }
                            }
                        }
                    }
                }
            }
            function _fetchMessageQueue() {
                return JSON.stringify(messageQueue);
            }
            function _doSendMessage(message,responseCallBack) {
                if(responseCallBack) {
                    var date = new Date();
                    var responseCallBackID = "GTBridgeResponseCallback_"+uniqueId+"_"+date.getTime();
                    uniqueId++;
                    responseCallBackDict[responseCallBackID] = responseCallBack;
                    message[kMessageCallBackId] = responseCallBackID;
                }
                messageQueue.push(message);
            }
    widow.load = function() {
        messagingIframe = document.createElement('iframe');
        messagingIframe.style.display = 'none';
        document.documentElement.appendChild(messagingIframe);
        messagingIframe.src = kJSBridgeScheme+"://"+kQueueHasMessage;
    }
    })();
        );
#undef __wvjb_js_func__
    return preprocessorJSCode;
}
