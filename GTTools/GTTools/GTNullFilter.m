//
//  GTNullFilter.m
//  GTTools
//
//  Created by 吴华林 on 2018/6/20.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import "GTNullFilter.h"
@implementation GTNullFilter
+ (BOOL)isNullForObject:(id)object {
    static dispatch_once_t onceToken;
    static NSDictionary *dict;
    dispatch_once(&onceToken, ^{
        dict = @{@"NIL" :    (id)kCFNull,
                 @"Nil" :    (id)kCFNull,
                 @"nil" :    (id)kCFNull,
                 @"NULL" :   (id)kCFNull,
                 @"Null" :   (id)kCFNull,
                 @"null" :   (id)kCFNull,
                 @"(NULL)" : (id)kCFNull,
                 @"(Null)" : (id)kCFNull,
                 @"(null)" : (id)kCFNull,
                 @"<NULL>" : (id)kCFNull,
                 @"<Null>" : (id)kCFNull,
                 @"<null>" : (id)kCFNull};
    });
    if(!object || object==(id)kCFNull || [object isKindOfClass:[NSNull class]]) {
        return YES;
    } else if([object isKindOfClass:[NSString class]]) {
        id value = [dict objectForKey:(NSString *)object];
        if(value == (id)kCFNull) {
            return YES;
        } else {
            return NO;
        }
    } else {
        return NO;
    }
}

@end
