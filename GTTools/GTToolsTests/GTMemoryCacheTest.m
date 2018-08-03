//
//  GTMemoryCacheTest.m
//  GTToolsTests
//
//  Created by 吴华林 on 2018/8/3.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GTMemoryCache.h"
@interface GTMemoryCacheTest : XCTestCase

@end

@implementation GTMemoryCacheTest

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
    GTMemoryCache *memoryCache = [[GTMemoryCache alloc] init];
    [memoryCache setObject:@"1" forKey:@"key1"];
     [memoryCache setObject:@"2" forKey:@"key2"];
     [memoryCache setObject:@"3" forKey:@"key3"];
     [memoryCache setObject:@"4" forKey:@"key4"];
     [memoryCache setObject:@"5" forKey:@"key5"];
    
    NSLog(@"----->%@",[memoryCache objectForKey:@"key1"]);
     NSLog(@"----->%@",[memoryCache objectForKey:@"key2"]);
     NSLog(@"----->%@",[memoryCache objectForKey:@"key3"]);
     NSLog(@"----->%@",[memoryCache objectForKey:@"key4"]);
     NSLog(@"----->%@",[memoryCache objectForKey:@"key5"]);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
