//
//  GTModuleBusMediator.h
//  GTTools
//
//  Created by 吴华林 on 2019/2/15.
//  Copyright © 2019 吴华林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GTBusConnectorPrt.h"
NS_ASSUME_NONNULL_BEGIN


@interface GTBusMediator : NSObject
+ (instancetype)shareInstance;
/**
 注册组件到总线上

 @param connector 组件对象
 */
- (void)registerConnector:(id<GTBusConnectorPrt>)connector;

/**
 移除组件从总线上

 @param connector 组件对象
 */
- (void)removeConnector:(id<GTBusConnectorPrt>)connector;

/**
 给总线发送一个指定消息ID的Message

 @param messageID 消息的ID（这个全局唯一）
 @param params 需要携带的参数
 @param complete 处理消息的回调
 */
- (void)sendMessage:(NSUInteger)messageID withParameters:(NSDictionary *)params complete:(id(^)(id responseData, NSError *error))complete;
@end

NS_ASSUME_NONNULL_END
