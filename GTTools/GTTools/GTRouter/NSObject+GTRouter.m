//
//  NSObject+GTRouter.m
//  GTTools
//
//  Created by 吴华林 on 2018/7/27.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import "NSObject+GTRouter.h"
#import "GTNullFilter.h"
#import <objc/message.h>
id (*gtRouter_sendMessage)(id, SEL,...) = (id (*)(id, SEL,...))objc_msgSend;
BOOL (*gtRouter_sendBOOLMessage)(id, SEL, ...) = (BOOL (*)(id, SEL,...))objc_msgSend;
void (*gtRouter_sendVoidMessage)(id, SEL, ...) = (void (*)(id, SEL,...))objc_msgSend;


@interface GTEvent()
@property(nonatomic,copy)NSString *eventName;
//这个参数必须是通用类型（OC 的存在的类型，不允许是自定义的数据类型）
@property(nonatomic,strong)id eventContent;
@end
@implementation GTEvent
+ (GTEvent *)eventWithName:(NSString *)name  eventContent:(id)content {
    GTEvent *event = [[GTEvent alloc] init];
    [event updateEventWithName:name  eventContent:content];
    return event;
}
- (void)updateEventName:(NSString *)name {
    if(![GTNullFilter isNullForObject:name]) {
        _eventName = name;
    }
}
- (void)updateEventContent:(id)content {
    if(![GTNullFilter isNullForObject:content]) {
        _eventContent = content;
    }
}

- (void)updateEventWithName:(NSString *)name  eventContent:(id)content {
    [self updateEventName:name];
    [self updateEventContent:content];
}
@end
@interface NSObject()
@property(nonatomic,weak)NSObject<GTRouterNodeProtocol> *fatherNode;
@property(nonatomic,strong)NSHashTable<GTRouterNodeProtocol> *chrildNodes;
@end
@implementation NSObject (GTRouter)
//MARK:public_methods
- (void)routerEvent:(GTEvent *)event completeHandle:(void(^)(id data))completeHandle {
    
    if(event) {
       id responser = [[self responserMapForEvents] objectForKey:event.eventName];
        if(responser==nil) {
          //没有查找过
           responser = [self findEventResponser:event];
            if(!responser) {
                [[self responserMapForEvents] setObject:[NSNull null] forKey:event.eventName];
                gtRouter_sendVoidMessage(self.fatherNode,@selector(routerEvent:completeHandle:),event,completeHandle);
            } else {
                 [[self responserMapForEvents] setObject:responser forKey:event.eventName];
                gtRouter_sendVoidMessage(responser,@selector(handleEvent:completeHandle:),event,completeHandle);
            }
        } else if(responser != [NSNull null]){
            //表示当前responser 可以响应事件
            gtRouter_sendVoidMessage(responser,@selector(handleEvent:completeHandle:),event,completeHandle);
        } else {
            //表示自身和子类都无法响应，将事件交回给父节点
            gtRouter_sendVoidMessage(self.fatherNode,@selector(routerEvent:completeHandle:),event,completeHandle);
        }
    }
}
- (void)addChrildNodes:(NSArray<GTRouterNodeProtocol> *)chrildNodes {
    for(id<GTRouterNodeProtocol>chrildNode in chrildNodes) {
        [self addChrildNode:chrildNode];
    }
}
- (void)addChrildNode:(__strong id<GTRouterNodeProtocol>)chrildNode {

    [self.chrildNodes addObject:chrildNode];
   
}
//MARK:private_methods
- (id)findEventResponser:(GTEvent *)event {
   
    if([self respondsToSelector:@selector(canHandleEvent:)]) {
        double success = gtRouter_sendBOOLMessage(self,@selector(canHandleEvent:),event);
        if(success) {
            return self;
        }
    }
    if(self.chrildNodes && self.chrildNodes.count>0) {
        NSArray *chrildNodeAry = [self.chrildNodes allObjects];
        for(id<GTRouterNodeProtocol>chrild in chrildNodeAry) {
           id responser = gtRouter_sendMessage(chrild,@selector(findEventResponser:),event);
            if(responser) {
                return responser;
            }
        }
    }
    return nil;
}
#pragma mark set/get
- (NSMapTable *)responserMapForEvents {
    
   NSMapTable *mapTable = objc_getAssociatedObject(self, "GTRouter_responserMapForEvents");
    if(!mapTable) {
         mapTable = [NSMapTable strongToWeakObjectsMapTable];
        objc_setAssociatedObject(self, "GTRouter_responserMapForEvents", mapTable,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return mapTable;
}
- (void)setFatherNode:(id<GTRouterNodeProtocol>)fatherNode {
    if(fatherNode) {
        objc_setAssociatedObject(self,"GTRouter_fatherNode",fatherNode,OBJC_ASSOCIATION_ASSIGN);
    }
}
- (id<GTRouterNodeProtocol>)fatherNode {
    return objc_getAssociatedObject(self, "GTRouter_fatherNode");
}
- (NSHashTable<GTRouterNodeProtocol> *)chrildNodes {
    NSHashTable<GTRouterNodeProtocol> *haseTable = objc_getAssociatedObject(self, "GTRouter_chrildNodes");
    if(!haseTable) {
        haseTable = (NSHashTable<GTRouterNodeProtocol> *)[NSHashTable weakObjectsHashTable];
        objc_setAssociatedObject(self, "GTRouter_chrildNodes", haseTable,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return haseTable;
}
@end
