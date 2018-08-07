//
//  GTEventBusTest.m
//  GTToolsTests
//
//  Created by 吴华林 on 2018/8/3.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GTEventBus.h"
@interface GTEvent1 : NSObject<GTMessageSubscriberProtocol>
@end
@implementation GTEvent1
+ (void)load {
     [self subscribeMessagesWithNames:@[@"testMessgae1",@"testMessgae2"]];
}
- (instancetype)init {
    self = [super init];
    if(self) {
//        [self subscribeMessagesWithNames:@[@"testMessgae1",@"testMessgae2"]];
    }
    return self;
}
- (GTEventMessage *)handleEventMessage:(GTEventMessage *)eventMessage completion:(GTCallBackBlock)completion {
    NSLog(@"--GTEvent1-->%@",eventMessage.name);
    return nil;
}
+ (GTEventMessage *)handleEventMessage:(GTEventMessage *)eventMessage completion:(GTCallBackBlock)completion {
    NSLog(@"--GTEvent1-->%@",eventMessage.name);
    return nil;
}
@end

@interface GTEvent2 : NSObject
@end
@implementation GTEvent2
- (instancetype)init {
    self = [super init];
    if(self) {
//        [self subscribeMessageWithName:@"testMessgae2"];
//        [[self class] subscribeMessageWithName:@"testMessgae2"];
        
       
    }
    return self;
}
- (BOOL)handleEventMessage:(GTEventMessage *)eventMessage completion:(GTCallBackBlock)completion {
    NSLog(@"--GTEvent2-->%@--->%i----->%@",eventMessage.name,eventMessage.messageType,eventMessage.messageBody);
    completion(@"我已经收到消息了");
    return NO;
}
+ (BOOL)handleEventMessage:(GTEventMessage *)eventMessage completion:(GTCallBackBlock)completion {
    NSLog(@"-GTEvent2-class-->%@--->%i----->%@",eventMessage.name,eventMessage.messageType,eventMessage.messageBody);
    completion(@"我已经收到消息了");
    return YES;
}
@end
@interface GTEventBusTest : XCTestCase
@property(nonatomic,strong)GTEvent1 *event1;
@property(nonatomic,strong)GTEvent2 *event2;
@end

@implementation GTEventBusTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _event1 = [[GTEvent1 alloc] init];
    _event2 = [[GTEvent2 alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    {
        GTEventMessage *event1 = [GTEventMessage eventWithName:@"testMessgae2" messageType:GTDefaultEventMessage messageBody:@"123456"];
        [self sendMessage:event1 completion:^(id data) {
            NSLog(@"------>%@",data);
        }];
    }
//    {
//        GTEventMessage *event1 = [GTEventMessage eventWithName:@"testMessgae2" messageType:GTDefaultEventMessage messageBody:@"123456"];
//        _event2 = nil;
//        [self sendMessage:event1 completion:^(id data) {
//            NSLog(@"------>%@",data);
//        }];
//    }
//    {
//        GTEventMessage *event1 = [GTEventMessage eventWithName:@"testMessgae1" messageType:GTViscidEventMessage messageBody:@"123456"];
//        [self sendMessage:event1 completion:^(id data) {
//            NSLog(@"------>%@",data);
//        }];
//        [self.event1 subscribeMessageWithName:@"testMessgae3"];
//    }
//    {
//        GTEventMessage *event1 = [GTEventMessage eventWithName:@"testMessgae3" messageType:GTViscidEventMessage messageBody:@"123456"];
//        [self sendMessage:event1 completion:^(id data) {
//            NSLog(@"------>%@",data);
//        }];
//        [self.event1 subscribeMessageWithName:@"testMessgae3"];
//    }
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
