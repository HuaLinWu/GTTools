//
//  GTTimer.h
//  GTTools
//
//  Created by 吴华林 on 2018/8/5.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GTTimer : NSObject
+ (void)gt_createTimerWithName:(NSString *)name period:(NSTimeInterval)period repeats:(BOOL)repeats eventHandler:(void(^)(void))eventHandler;
+ (void)startTimerWithName:(NSString *)name;
+ (void)stopTimerWithName:(NSString *)name;
@end
