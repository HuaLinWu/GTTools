//
//  DateFormatterManagerTest.m
//  GTToolsTests
//
//  Created by 吴华林 on 2018/6/20.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSDateFormatterManager.h"
@interface DateFormatterManagerTest : XCTestCase

@end

@implementation DateFormatterManagerTest

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
   NSString *dateStr = [NSDateFormatterManager stringFromDate:[NSDate date] dateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSLog(@"------%@",dateStr);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
