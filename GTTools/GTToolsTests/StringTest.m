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
    {
         NSString *sourceStr = @"https://www.baidu.com?a=1&b=2#iframe=1";
        NSLog(@"------>%@",[sourceStr gt_urlEncoding:NO]);
    }
    {
        NSString *sourceStr = @"https://www.baidu.com?a=1&b=2&c=吴华林#iframe=1";
        NSLog(@"------>%@",[sourceStr gt_urlEncodingAllowCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]);
    }
    {
        NSString *sourceStr = @"https://www.baidu.com?a=1&b=2&c=吴华林#iframe=1";
        NSLog(@"------>%@",[sourceStr gt_urlEncodingAllowCharacters:nil]);
    }
    {
        NSString *sourceStr = @"https://www.baidu.com?a=1&b=2&c=吴华林#iframe=1";
        NSLog(@"------>%@",[sourceStr gt_urlEncodingAllowCharacters:[NSCharacterSet URLPathAllowedCharacterSet]]);
    }
    {
        NSString *sourceStr = @"https://www.baidu.com?a=1&b=2&c=吴华林#iframe=1";
        NSLog(@"------>%@",[sourceStr gt_urlEncoding:NO]);
    }
   
    
}
- (void)testDecoding {
    {
        NSString *sourceStr = @"https://www.baidu.com?a=1&b=2&c=吴华林#iframe=1";
        sourceStr= [sourceStr gt_urlEncoding:YES];
         NSLog(@"---encoding--->%@",sourceStr);
        sourceStr= [sourceStr gt_urlEncoding:YES];
        NSLog(@"---encoding--->%@",sourceStr);
        sourceStr= [sourceStr gt_urlEncoding:YES];
        NSLog(@"---encoding--->%@",sourceStr);
        sourceStr= [sourceStr gt_urlEncoding:YES];
        NSLog(@"---urlDecoding--->%@",[sourceStr gt_urlDecoding:YES]);
    }
}
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
