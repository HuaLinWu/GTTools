//
//  GTEventBus.h
//  GTTools
//
//  Created by 吴华林 on 2018/7/30.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger,GTEventMessageType) {
    GTDefaultEventMessage,//如果没有订阅者，消息一旦发送就会丢失
    GTViscidEventMessage//如果没有订阅者，消息会被缓存，直到有订阅者进行发送（发送过后消息会从消息池子移除）
};
@interface GTEventMessage : NSObject

/**
 事件名字（在GTEventBus 事件缓存池里面，同一名称的事件只会有一个，后面的事件会冲掉相同名字之前的事件）
 */
@property(nonatomic,copy)NSString *name;

/**
 时间类型决定了是否在没有订阅者时候消息会被缓存
 */
@property(nonatomic,assign)GTEventMessageType messageType;

/**
 消息搭载的数据（这个只能是OC 数据类型）
 */
@property(nonatomic,strong)id messageBody;
@end

typedef void(^GTCallBackBlock)(id data);


@protocol GTMessageSubscriberProtocol

/**
 订阅者统一处理自己观察的消息的方法

 @param eventMessage 消息
 @param completion 回调函数
 */
- (void)handleEventMessage:(GTEventMessage *)eventMessage completion:(GTCallBackBlock)completion;
@end

@interface NSObject (GTEventBus)
/**
 订阅消息
 
 @param name 消息名字
 */
- (void)subscribeMessageWithName:(NSString *)name;

/**
 订阅一系列的消息
 
 @param messageNames 消息名字
 */
- (void)subscribeMessagesWithNames:(NSArray *)messageNames;
@end

@interface GTEventBus : NSObject

/**
 消息主线的共用对象

 @return 返回消息主线
 */
+ (instancetype)shareInstance;

/**
 根据消息名字来移除消息

 @param name 消息名字
 */
- (void)removeMessageWithName:(NSString *)name;

/**
 发送消息

 @param message 消息
 @param callBack 订阅者处理完成后回调方法
 */
- (void)sendMessage:(GTEventMessage *)message completion:(GTCallBackBlock)callBack;

@end
