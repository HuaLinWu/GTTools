//
//  GTModuleBusMediator.m
//  GTTools
//
//  Created by 吴华林 on 2019/2/15.
//  Copyright © 2019 吴华林. All rights reserved.
//

#import "GTBusMediator.h"
static GTBusMediator *busMediator;
@interface GTBusMediator()
@property(nonatomic,strong)NSMutableDictionary<NSString *,id<GTBusConnectorPrt>> *connectorDict;
@end
@implementation GTBusMediator
+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
            busMediator = [[super alloc] init];
        });
    return busMediator;
}
- (void)registerConnector:(id<GTBusConnectorPrt>)connector {
    if(connector) {
        NSString *connectorKey = NSStringFromClass([connector class]);
        if(connectorKey) {
             [self.connectorDict setObject:connector forKey:connectorKey];
        }
    }
}
- (void)removeConnector:(id<GTBusConnectorPrt>)connector {
    if(connector) {
        NSString *connectorKey = NSStringFromClass([connector class]);
        if(connectorKey) {
            [self.connectorDict removeObjectForKey:connectorKey];
        }
    }
}
- (void)sendMessage:(NSUInteger)messageID withParameters:(NSDictionary *)params complete:(id(^)(id responseData, NSError *error))complete {
    __block BOOL canHandle = NO;
    [self.connectorDict enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id<GTBusConnectorPrt>  _Nonnull obj, BOOL * _Nonnull stop) {
        if([obj canHandleMessage:messageID]) {
            *stop = YES;
            canHandle = YES;
            [obj handleMessage:messageID withParameters:params complete:complete];
        }
    }];
    if(!canHandle) {
        NSLog(@"Illegal messageID");
        if(complete) {
            NSError *error = [NSError errorWithDomain:NSMachErrorDomain code:404 userInfo:@{NSLocalizedDescriptionKey:@"Illegal messageID"}];
            complete(nil,error);
        }
    }
}
//MARK:private
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [GTBusMediator shareInstance];
}
- (instancetype)copy {
     return [GTBusMediator shareInstance];
}
- (instancetype)mutableCopy {
    return [GTBusMediator shareInstance];
}
//MARK:get
- (NSMutableDictionary<NSString *,id<GTBusConnectorPrt>> *)connectorDict {
    if(!_connectorDict) {
        _connectorDict = [[NSMutableDictionary alloc] init];
    }
    return _connectorDict;
}
@end
