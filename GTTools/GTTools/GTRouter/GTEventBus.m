//
//  GTEventBus.m
//  GTTools
//
//  Created by 吴华林 on 2018/7/30.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import "GTEventBus.h"
#import <objc/runtime.h>
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
 消息池信号量
 */
@property(nonatomic,strong)dispatch_semaphore_t messagesPoolSemaphore;

/**
 消息和观察者信号量
 */
@property(nonatomic,strong)dispatch_semaphore_t messageAndSubscribersMapSemaphore;
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
        bus.messagesPoolSemaphore = dispatch_semaphore_create(1);
        bus.messageAndSubscribersMapSemaphore = dispatch_semaphore_create(1);
    });
    return bus;
}

- (void)subscribeMessageWithName:(NSString *)messageName subscriber:(id<GTMessageSubscriberProtocol>)subscriber {
    
    if(messageName&&messageName.length>0&& subscriber) {
      dispatch_semaphore_wait(self.messageAndSubscribersMapSemaphore, DISPATCH_TIME_FOREVER);
      NSPointerArray *subscribersTable = [self.messageAndSubscribersMap objectForKey:messageName];
        dispatch_semaphore_signal(self.messageAndSubscribersMapSemaphore);
        if(subscribersTable) {
            
            if(![[subscribersTable allObjects] containsObject:subscriber]){
                [subscribersTable addPointer:(__bridge void * _Nullable)(subscriber)];
            } else {
                return;
            }
        } else {
            subscribersTable = [NSPointerArray weakObjectsPointerArray];
            [subscribersTable addPointer:(__bridge void * _Nullable)(subscriber)];
            dispatch_semaphore_wait(self.messageAndSubscribersMapSemaphore, DISPATCH_TIME_FOREVER);
            [self.messageAndSubscribersMap setObject:subscribersTable forKey:messageName];
             dispatch_semaphore_signal(self.messageAndSubscribersMapSemaphore);
        }
        //从以前缓存事件读取事件执行
        GTEventMessagesPoolElement *eventMessageElemet = [self getElementFromMessagesPool:messageName];
        
        if(eventMessageElemet) {
            Class subscriberClass = object_getClass(subscriber);
            Method method = nil;
            if(class_isMetaClass(subscriberClass)) {
              method = class_getClassMethod((Class)subscriber, @selector(handleEventMessage:completion:));
            } else {
                method = class_getInstanceMethod(subscriberClass, @selector(handleEventMessage:completion:));
            }
            if(method) {
                BOOL haveHandle = [subscriber handleEventMessage:eventMessageElemet.message completion:eventMessageElemet.callBack];
                if(haveHandle) {
                     [self removeMessageWithName:messageName];
                }
                
            }
        }
    }
}

- (void)subscribeMessagesWithNames:(NSArray *)messageNames subscriber:(id<GTMessageSubscriberProtocol> )subscriber {
    
    if(messageNames&&[messageNames isKindOfClass:[NSArray class]]&&messageNames.count>0) {
        for(int i=0;i<messageNames.count;i++) {
        NSString *messageName = messageNames[i];
            [self subscribeMessageWithName:messageName subscriber:subscriber];
        }
    }
}

- (void)removeMessageWithName:(NSString *)name {
    dispatch_semaphore_wait(self.messagesPoolSemaphore, DISPATCH_TIME_FOREVER);
    [self.eventMessagesPool removeObjectForKey:name];
    dispatch_semaphore_signal(self.messagesPoolSemaphore);
}

- (void)sendMessage:(GTEventMessage *)message completion:(GTCallBackBlock)callBack {
    if(message){
      NSPointerArray *subscribersTable = [self subscribersForMessage:message.name];
      if(subscribersTable) {
         //如果存在订阅者
          NSArray *subscribers = [subscribersTable allObjects];
          
          for(int i=(int)(subscribers.count-1);i>=0;i--) {
              id<GTMessageSubscriberProtocol>subscriber = subscribers[i];
              Class subscriberClass = object_getClass(subscriber);
              Method method = nil;
              if(class_isMetaClass(subscriberClass)) {
                  method = class_getClassMethod((Class)subscriber, @selector(handleEventMessage:completion:));
              } else {
                  method = class_getInstanceMethod(subscriberClass, @selector(handleEventMessage:completion:));
              }
              if(method) {
                  BOOL haveHandle = [subscriber handleEventMessage:message completion:callBack];
                  if(haveHandle) {
                      [self removeMessageWithName:message.name];
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
        dispatch_semaphore_wait(self.messageAndSubscribersMapSemaphore, DISPATCH_TIME_FOREVER);
        NSPointerArray *array = [self.messageAndSubscribersMap objectForKey:messageName];
        dispatch_semaphore_signal(self.messageAndSubscribersMapSemaphore);
        return array;
    } else {
        return nil;
    }
}
- (void)saveMessage:(GTEventMessage *)message callBack:(GTCallBackBlock)callBack {
    if(message.name) {
        //缓存消息
        dispatch_semaphore_wait(self.messagesPoolSemaphore, DISPATCH_TIME_FOREVER);
        if([[self.eventMessagesPool allKeys] containsObject:message.name]) {
            [self.eventMessagesPool removeObjectForKey:message.name];
        }
        GTEventMessagesPoolElement *element = [GTEventMessagesPoolElement createElementWithMessage:message callBack:callBack];
        [self.eventMessagesPool setObject:element forKey:message.name];
        dispatch_semaphore_signal(self.messagesPoolSemaphore);
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
        dispatch_semaphore_wait(self.messagesPoolSemaphore, DISPATCH_TIME_FOREVER);
        GTEventMessagesPoolElement *messagesPoolElement = [self.eventMessagesPool objectForKey:eventMessageName];
        dispatch_semaphore_signal(self.messagesPoolSemaphore);
        return messagesPoolElement;
    } else {
        return nil;
    }
}
@end
@implementation NSObject (GTEventBus)
+ (void)subscribeMessageWithName:(NSString *)name {
    if(name && name.length>0) {
        [[GTEventBus shareInstance] subscribeMessageWithName:name subscriber:(id<GTMessageSubscriberProtocol>)self];
    }
}
- (void)subscribeMessageWithName:(NSString *)name {
    if(name && name.length>0) {
          [[GTEventBus shareInstance] subscribeMessageWithName:name subscriber:(id<GTMessageSubscriberProtocol>)self];
    }
}

- (void)subscribeMessagesWithNames:(NSArray *)messageNames {
    if(messageNames && messageNames.count>0) {
        [[GTEventBus shareInstance] subscribeMessagesWithNames:messageNames subscriber:(id<GTMessageSubscriberProtocol>)self];
    }
}
+ (void)subscribeMessagesWithNames:(NSArray *)messageNames {
    if(messageNames && messageNames.count>0) {
         [[GTEventBus shareInstance] subscribeMessagesWithNames:messageNames subscriber:(id<GTMessageSubscriberProtocol>)self];
    }
}
- (void)sendMessage:(GTEventMessage *)message completion:(GTCallBackBlock)callBack {
    
    [[GTEventBus shareInstance] sendMessage:message completion:callBack];
}
+ (void)sendMessage:(GTEventMessage *)message completion:(GTCallBackBlock)callBack {
   [[GTEventBus shareInstance] sendMessage:message completion:callBack];
}
- (void)removeMessageWithName:(NSString *)name {
    [[GTEventBus shareInstance] removeMessageWithName:name];
}
+ (void)removeMessageWithName:(NSString *)name {
    [[GTEventBus shareInstance] removeMessageWithName:name];
}
@end
