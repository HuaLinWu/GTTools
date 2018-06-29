//
//  StringTest.m
//  GTToolsTests
//
//  Created by 吴华林 on 2018/6/29.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+GTTools.h"
@interface StringTest : XCTestCase

@end

@implementation StringTest

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
}
- (void)testEncoding {
    NSString *sourceStr = @"https://www.baidu.com?a=1&b=2#iframe=1";
    NSLog(@"---md5String--->%@",[sourceStr gt_md5String]);
    NSString *urlEncodingStr = [sourceStr gt_urlEncodingAllowCharacters:nil];
    NSLog(@"---defaultURLEncoding--->%@",urlEncodingStr);
    NSString *decodingStr = [urlEncodingStr gt_urlDecoding];
    NSLog(@"---decodingStr---->%@",decodingStr);
}
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
