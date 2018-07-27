//
//  NSObject+GTRouter.h
//  GTTools
//
//  Created by 吴华林 on 2018/7/27.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GTEvent :NSObject
@property(nonatomic,copy,readonly)NSString *eventName;
//这个参数必须是通用类型（OC 的存在的类型，不允许是自定义的数据类型）
@property(nonatomic,strong,readonly)id eventContent;
+ (GTEvent *)eventWithName:(NSString *)name eventContent:(id)content;
- (void)updateEventName:(NSString *)name;
- (void)updateEventContent:(id)content;
- (void)updateEventWithName:(NSString *)name eventContent:(id)content;
@end

@protocol GTRouterNodeProtocol<NSObject>
- (BOOL)canHandleEvent:(GTEvent *)event;
- (void)handleEvent:(GTEvent *)event completeHandle:(void(^)(id data))completeHandle;
@end

@interface NSObject (GTRouter)
- (void)setFatherNode:(id<GTRouterNodeProtocol>)fatherNode;
- (void)addChrildNodes:(NSArray<GTRouterNodeProtocol> *)chrildNodes;
- (void)addChrildNode:(id<GTRouterNodeProtocol>)chrildNode;
- (void)routerEvent:(GTEvent *)event completeHandle:(void(^)(id data))completeHandle;
@end
