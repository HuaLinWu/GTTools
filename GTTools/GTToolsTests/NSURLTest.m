//
//  NSURLTest.m
//  GTToolsTests
//
//  Created by 吴华林 on 2018/7/31.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSURL+GTTools.h"
@interface NSURLTest : XCTestCase

@end

@implementation NSURLTest

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
- (void)testAddScheme {
    {
        NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
        url = [url addScheme:@"http" needReplace:NO];
        NSLog(@"------>%@",url);
    }
    {
        NSURL *url = [NSURL URLWithString:@"://www.baidu.com"];
        url = [url addScheme:@"http" needReplace:NO];
        NSLog(@"------>%@",url);
    }
    {
        NSURL *url = [NSURL URLWithString:@"//www.baidu.com"];
        url = [url addScheme:@"http" needReplace:NO];
        NSLog(@"------>%@",url);
    }
    {
        NSURL *url = [NSURL URLWithString:@"/www.baidu.com"];
        url = [url addScheme:@"http" needReplace:NO];
        NSLog(@"------>%@",url);
    }
    {
        NSURL *url = [NSURL URLWithString:@"www.baidu.com"];
        url = [url addScheme:@"http" needReplace:NO];
        NSLog(@"------>%@",url);
    }
    {
        NSURL *url = [NSURL URLWithString:@":www.baidu.com"];
        url = [url addScheme:@"http" needReplace:NO];
        NSLog(@"------>%@",url);
    }
    {
        NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
        url = [url addScheme:@"https" needReplace:YES];
        NSLog(@"------>%@",url);
    }
}
- (void)testRepalceParamKeyAndValue {
    {
        NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
        url = [url replaceURLParamWithKey:@"a" value:@"122344"];
        NSLog(@"------>%@",url);
    }
    {
        NSURL *url = [NSURL URLWithString:@"http://www.baidu.com?a=123"];
        url = [url replaceURLParamWithKey:@"a" value:@"122344"];
        NSLog(@"------>%@",url);
    }
    {
        NSURL *url = [NSURL URLWithString:@"http://www.baidu.com?a=123"];
        url = [url replaceURLParamWithKey:@"b" value:@"122344"];
        NSLog(@"------>%@",url);
    }
  
}
- (void)testRemovekey {
    {
        NSURL *url = [NSURL URLWithString:@"http://www.baidu.com?a=123"];
        url = [url removeURLParamWithParamKey:@"a"];
        NSLog(@"------>%@",url);
    }
    {
        NSURL *url = [NSURL URLWithString:@"http://www.baidu.com?a=123"];
        url = [url removeURLParamWithParamKey:@"b"];
        NSLog(@"------>%@",url);
    }
    {
        NSURL *url = [NSURL URLWithString:@"http://www.baidu.com?a=123&b=123444"];
        url = [url removeURLParamWithParamKey:@"b"];
        NSLog(@"------>%@",url);
    }
    {
        NSURL *url = [NSURL URLWithString:@"http://www.baidu.com?a=123&b=123444"];
        url = [url removeURLParamWithParamKeys:@[@"b",@"a"]];
        NSLog(@"------>%@",url);
    }
}
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
