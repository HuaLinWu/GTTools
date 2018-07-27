//
//  RouterObjectTest.m
//  GTToolsTests
//
//  Created by 吴华林 on 2018/7/27.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AObject.h"
@interface RouterObjectTest : XCTestCase

@end

@implementation RouterObjectTest

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
    AObject *a = [AObject new];
    GTEvent *a_cEvent = [GTEvent eventWithName:@"bctionI" eventContent:nil];
  
    [a.b routerEvent:a_cEvent completeHandle:^(id data) {
        
    }];
    
    
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
