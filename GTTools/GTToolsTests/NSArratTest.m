//
//  NSArratTest.m
//  GTToolsTests
//
//  Created by 吴华林 on 2018/6/20.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSArray+GTTools.h"
@interface NSArratTest : XCTestCase

@end

@implementation NSArratTest

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
- (void)testMutableArray {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array gt_addObject:@(1)];
//    [array gt_removeObjectsInRange:NSMakeRange(0, 1)];
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:1];
    [array gt_removeObjectsAtIndexes:indexSet];
   
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
