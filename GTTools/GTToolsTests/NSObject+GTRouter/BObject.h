//
//  AObject.h
//  GTToolsTests
//
//  Created by 吴华林 on 2018/7/27.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+GTRouter.h"
#import "DObject.h"
#import "EObject.h"
@interface BObject : NSObject
@property(nonatomic,strong)DObject *d;
@property(nonatomic,strong)EObject *e;
@end
