//
//  GTDiskCacheTest.m
//  GTToolsTests
//
//  Created by 吴华林 on 2018/8/2.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GTDiskCache.h"
@interface Mode :NSObject
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSArray *modes;
@end
@implementation Mode
@end
@interface GTDiskCacheTest : XCTestCase

@end

@implementation GTDiskCacheTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    {
        GTDiskCache *diskCache =[[GTDiskCache alloc] initWithName:@"gtCacheTest"];
        [diskCache setObject:@"123344" forKey:@"a"];
        NSString *str = [diskCache objectForKey:@"a"];
        NSLog(@"------>%@",str);
    }
    {
        GTDiskCache *diskCache =[[GTDiskCache alloc] initWithName:@"gtCacheTest"];
        [diskCache setObject:@(1) forKey:@"a"];
        NSString *str = [diskCache objectForKey:@"a"];
        NSLog(@"------>%@",str);
    }
    {
        GTDiskCache *diskCache =[[GTDiskCache alloc] initWithName:@"gtCacheTest"];
        Mode *mode1 = [[Mode alloc] init];
        mode1.name = @"华林";
        Mode *mode2 = [[Mode alloc] init];
        mode1.modes = @[mode2];
        [diskCache setObject:mode1 forKey:@"a"];
        Mode *obj = [diskCache objectForKey:@"a"];
        NSLog(@"---%@--->%@",obj.name,mode1.modes);
    }
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
