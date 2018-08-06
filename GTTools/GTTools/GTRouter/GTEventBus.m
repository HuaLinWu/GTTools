//
//  GTEventBus.m
//  GTTools
//
//  Created by 吴华林 on 2018/7/30.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import "GTEventBus.h"
#import <objc/message.h>
void (*gtRouter_sendVoidMessage)(id, SEL, ...) = (void (*)(id, SEL,...))objc_msgSend;
id (*gtRouter_sendMessage)(id, SEL,...) = (id (*)(id, SEL,...))objc_msgSend;
BOOL(*gtRouter_sendBOOLMessage)(id, SEL,...) = (BOOL (*)(id, SEL,...))objc_msgSend;
@interface GTEventMessage()
@property(nonatomic,copy)NSString *name;
@property(nonatomic,assign)GTEventMessageType messageType;
@property(nonatomic,strong)id messageBody;
@end
@implementation GTEventMessage
+ (instancetype)eventWithName:(NSString *)name messageType:(GTEventMessageType)messageType messageBody:(id)messageBody {
    GTEventMessage *instance = [[self alloc] init];
    if(instance) {
        instance.name = name;
        instance.messageType = messageType;
        instance.messageBody = messageBody;
    }
    return instance;
}
@end

@interface GTEventMessagesPoolElement : NSObject
@property(nonatomic, strong)GTEventMessage *message;
@property(nonatomic, copy)GTCallBackBlock callBack;
@end

@implementation GTEventMessagesPoolElement
+ (instancetype)createElementWithMessage:(GTEventMessage *)message callBack:(GTCallBackBlock)callBack {
    GTEventMessagesPoolElement *element = [[GTEventMessagesPoolElement alloc] init];
    element.message = message;
    element.callBack = callBack;
    return element;
}
@end
@interface GTEventBus : NSObject

/**
 消息主线的共用对象
 
 @return 返回消息主线
 */
+ (instancetype)shareInstance;
/**
 消息池子
 */
@property(nonatomic,strong)NSMutableDictionary<NSString *,GTEventMessagesPoolElement *> *eventMessagesPool;

/**
 消息和订阅者对应关系map
 */
@property(nonatomic,strong)NSMutableDictionary<NSString *,NSPointerArray *> *messageAndSubscribersMap;
@end
@implementation GTEventBus
+ (instancetype)shareInstance {
    static GTEventBus *bus;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        bus = [[GTEventBus alloc] init];
    });
    return bus;
}

- (void)subscribeMessageWithName:(NSString *)messageName subscriber:(NSObject<GTMessageSubscriberProtocol> *)subscriber {
    
    if(messageName&&messageName.length>0&& subscriber) {
    
      NSPointerArray *subscribersTable = [self.messageAndSubscribersMap objectForKey:messageName];
        if(subscribersTable) {
            
            if(![[subscribersTable allObjects] containsObject:subscriber]){
                [subscribersTable addPointer:(__bridge void * _Nullable)(subscriber)];
            } else {
                return;
            }
        } else {
            subscribersTable = [NSPointerArray weakObjectsPointerArray];
            [subscribersTable addPointer:(__bridge void * _Nullable)(subscriber)];
            [self.messageAndSubscribersMap setObject:subscribersTable forKey:messageName];
        }
        //从以前缓存事件读取事件执行
       GTEventMessagesPoolElement *eventMessageElemet = gtRouter_sendMessage(self,@selector(getElementFromMessagesPool:),messageName);
        if(eventMessageElemet) {
            if([subscriber respondsToSelector:@selector(handleEventMessage:completion:)]) {
                 BOOL haveHandle = gtRouter_sendBOOLMessage(subscriber,@selector(handleEventMessage:completion:),eventMessageElemet.message,eventMessageElemet.callBack);
                if(haveHandle) {
                     [self removeMessageWithName:messageName];
                }
                
            }
        }
    }
}

- (void)subscribeMessagesWithNames:(NSArray *)messageNames subscriber:(NSObject<GTMessageSubscriberProtocol> *)subscriber {
    
    if(messageNames&&[messageNames isKindOfClass:[NSArray class]]&&messageNames.count>0) {
        for(int i=0;i<messageNames.count;i++) {
        NSString *messageName = messageNames[i];
    gtRouter_sendVoidMessage(self,@selector(subscribeMessageWithName:subscriber:),messageName,subscriber);
        }
    }
}

- (void)removeMessageWithName:(NSString *)name {
    [self.eventMessagesPool removeObjectForKey:name];
}

- (void)sendMessage:(GTEventMessage *)message completion:(GTCallBackBlock)callBack {
    if(message){
      NSPointerArray *subscribersTable = gtRouter_sendMessage(self,@selector(subscribersForMessage:),message.name);
      if(subscribersTable) {
         //如果存在订阅者
          NSArray *subscribers = [subscribersTable allObjects];
          
          for(int i=(int)(subscribers.count-1);i>=0;i--) {
              NSObject<GTMessageSubscriberProtocol> *subscriber = subscribers[i];
              if(subscriber && [subscriber respondsToSelector:@selector(handleEventMessage:completion:)]){
                 BOOL haveHandle = gtRouter_sendBOOLMessage(subscriber,@selector(handleEventMessage:completion:),message,callBack);
                  if(haveHandle){
                      return;
                  }
              }
          }
      } else {
        //如果不存在订阅者
          if(message.messageType == GTViscidEventMessage) {
              if(message.name) {
                  //缓存消息
                  [self saveMessage:message callBack:callBack];
              }
          } else {
              return;
          }
      }
    }
    
   
}
#pragma mark private_method
- (NSPointerArray *)subscribersForMessage:(NSString *)messageName {
    if(messageName && messageName.length>0) {
        return [self.messageAndSubscribersMap objectForKey:messageName];
    } else {
        return nil;
    }
}
- (void)saveMessage:(GTEventMessage *)message callBack:(GTCallBackBlock)callBack {
    if(message.name) {
        //缓存消息
        if([[self.eventMessagesPool allKeys] containsObject:message.name]) {
            [self.eventMessagesPool removeObjectForKey:message.name];
        }
        GTEventMessagesPoolElement *element = [GTEventMessagesPoolElement createElementWithMessage:message callBack:callBack];
        [self.eventMessagesPool setObject:element forKey:message.name];
    }
}
#pragma mark set/get
- (NSMutableDictionary<NSString *, NSPointerArray*> *)messageAndSubscribersMap {
    if(!_messageAndSubscribersMap) {
        _messageAndSubscribersMap = (NSMutableDictionary<NSString *,NSPointerArray *> *)[NSMutableDictionary dictionary];
    }
    return _messageAndSubscribersMap;
}
- (NSMutableDictionary<NSString *,GTEventMessagesPoolElement *> *)eventMessagesPool {
    if(!_eventMessagesPool) {
        _eventMessagesPool = (NSMutableDictionary<NSString *,GTEventMessagesPoolElement *> *)[NSMutableDictionary dictionary];
    }
    return _eventMessagesPool;
}
- (GTEventMessagesPoolElement *)getElementFromMessagesPool:(NSString *)eventMessageName {
    if(eventMessageName && eventMessageName.length >0) {
        return [self.eventMessagesPool objectForKey:eventMessageName];
    } else {
        return nil;
    }
}
@end
@implementation NSObject (GTEventBus)
+ (void)subscribeMessageWithName:(NSString *)name {
    if(name && name.length>0) {
        gtRouter_sendVoidMessage([GTEventBus shareInstance],@selector(subscribeMessageWithName:subscriber:),name,self);
    }
}
- (void)subscribeMessageWithName:(NSString *)name {
    if(name && name.length>0) {
        gtRouter_sendVoidMessage([GTEventBus shareInstance],@selector(subscribeMessageWithName:subscriber:),name,self);
    }
}

- (void)subscribeMessagesWithNames:(NSArray *)messageNames {
    if(messageNames && messageNames.count>0) {
        gtRouter_sendVoidMessage([GTEventBus shareInstance],@selector(subscribeMessagesWithNames:subscriber:),messageNames,self);
    }
}
+ (void)subscribeMessagesWithNames:(NSArray *)messageNames {
    if(messageNames && messageNames.count>0) {
        gtRouter_sendVoidMessage([GTEventBus shareInstance],@selector(subscribeMessagesWithNames:subscriber:),messageNames,self);
    }
}
- (void)sendMessage:(GTEventMessage *)message completion:(GTCallBackBlock)callBack {
    gtRouter_sendVoidMessage([GTEventBus shareInstance],@selector(sendMessage:completion:),message,callBack);
}
+ (void)sendMessage:(GTEventMessage *)message completion:(GTCallBackBlock)callBack {
    gtRouter_sendVoidMessage([GTEventBus shareInstance],@selector(sendMessage:completion:),message,callBack);
}
- (void)removeMessageWithName:(NSString *)name {
    gtRouter_sendVoidMessage([GTEventBus shareInstance],@selector(removeMessageWithName:),name);
}
+ (void)removeMessageWithName:(NSString *)name {
    gtRouter_sendVoidMessage([GTEventBus shareInstance],@selector(removeMessageWithName:),name);
}
@end
