//
//  GTModelManager.h
//  GTTools
// 在此声明本GTModelManager 只是基于YYModel 进行封装，知识产权依然是属于YYModel 的作者
//  Created by 吴华林 on 2018/6/20.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface GTModelManager : NSObject
+ (nullable id)gt_createModelWithClass:(nonnull id)modelClass jsonObject:(nonnull id)jsonObject;
+ (nullable id)gt_jsonObjectFromModel:(nonnull id)model;
+ (nullable NSData *)gt_jsonDataFromModel:(nonnull id)model;
+ (nullable NSString *)gt_jsonStringFromModel:(nonnull id)model;

@end

