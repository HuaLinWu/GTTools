//
//  GTModelManager.m
//  GTTools
//
//  Created by 吴华林 on 2018/6/20.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import "GTModelManager.h"
#import "YYModel.h"
#import "GTNullFilter.h"
#import <objc/runtime.h>
@implementation GTModelManager
+ (nullable id)gt_createModelWithClass:(nonnull id)modelClass
                            jsonObject:(nonnull id)jsonObject {
    
    if([GTNullFilter isNullForObject:modelClass]) {
        return nil;
    } else {
        if(class_isMetaClass([modelClass class])) {
            return [modelClass yy_modelWithJSON:jsonObject];
        } else {
            if([modelClass isKindOfClass:[NSString class]]) {
                NSString *modelClassStr = (NSString *)modelClass;
                Class class = objc_getClass(modelClassStr.UTF8String);
                return [class yy_modelWithJSON:jsonObject];
            } else {
                return [modelClass yy_modelWithJSON:jsonObject];
            }
        }
    }
}
+ (id)gt_jsonObjectFromModel:(id)model {
    
    if([GTNullFilter isNullForObject:model]) {
        return nil;
    } else {
        return [model yy_modelToJSONObject];
    }
}
+ (NSData *)gt_jsonDataFromModel:(id)model {
    
    if([GTNullFilter isNullForObject:model]) {
        return nil;
    } else {
        return [model yy_modelToJSONData];
    }
}
+ (NSString *)gt_jsonStringFromModel:(id)model {
    if([GTNullFilter isNullForObject:model]) {
        return nil;
    } else {
        return [model yy_modelToJSONString];
    }
}
@end
