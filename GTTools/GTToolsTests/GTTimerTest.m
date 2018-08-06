//
//  GTTimerTest.m
//  GTToolsTests
//
//  Created by 吴华林 on 2018/8/6.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GTTimer.h"
@interface GTTimerTest : XCTestCase

@end

@implementation GTTimerTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    [GTTimer gt_createSECTimerWithName:@"thread1" period:1 repeats:YES eventHandler:^{
        NSLog(@"----->%@",[NSThread currentThread]);
    }];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
