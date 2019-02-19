//
//  GTBusConnectorPrt.h
//  GTTools
//
//  Created by 吴华林 on 2019/2/18.
//  Copyright © 2019 吴华林. All rights reserved.
//
#import <Foundation/Foundation.h>
@protocol GTBusConnectorPrt <NSObject>
@required
/**
 判断是否能处理对应ID的消息
 
 @param messageID 消息的ID
 @return 返回YES 表示可以处理相应的消息，NO 表示不能处理
 */
- (BOOL)canHandleMessage:(NSUInteger)messageID;

/**
 处理对应ID 的消息
 
 @param messageID 消息ID
 @param params 消息携带的参数
 @param complete 完成消息处理以后的block
 */
- (void)handleMessage:(NSUInteger)messageID withParameters:(NSDictionary *)params complete:(id(^)(id responseData, NSError *error))complete;

@end
