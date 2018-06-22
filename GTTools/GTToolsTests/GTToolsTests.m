//
//  GTToolsTests.m
//  GTToolsTests
//
//  Created by 吴华林 on 2018/6/20.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface GTToolsTests : XCTestCase

@end

@implementation GTToolsTests

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
    NSMutableDictionary *mDict = [[NSMutableDictionary alloc] init];
    [mDict setObject:@"吴华林" forKey:@"name"];
    NSDictionary *dict = @{@"people":mDict};
    [dict setValue:@"1234" forKeyPath:@"people.name"];
    NSLog(@"----->%@",[dict valueForKeyPath:@"people.name"]);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
