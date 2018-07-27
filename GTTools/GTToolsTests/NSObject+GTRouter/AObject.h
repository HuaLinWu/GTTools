//
//  AObject.h
//  GTToolsTests
//
//  Created by 吴华林 on 2018/7/27.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+GTRouter.h"
#import "BObject.h"
#import "CObject.h"
@interface AObject : NSObject<GTRouterNodeProtocol>
@property(nonatomic,strong)BObject *b;
@property(nonatomic,strong)CObject *c;
- (BOOL)canHandleEvent:(GTEvent *)event;
- (void)handleEvent:(GTEvent *)event completeHandle:(void(^)(id data))completeHandle;
@end
