//
//  AObject.h
//  GTToolsTests
//
//  Created by 吴华林 on 2018/7/27.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+GTRouter.h"
#import "FObject.h"
#import "GObject.h"
#import "HObject.h"
@interface CObject : NSObject
@property(nonatomic,strong)FObject *f;
@property(nonatomic,strong)GObject *g;
@property(nonatomic,strong)HObject *h;
@end
