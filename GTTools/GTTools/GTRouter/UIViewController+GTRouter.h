//
//  UIViewController+GTRouter.h
//  GTTools
//
//  Created by 吴华林 on 2018/7/10.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, GTRouterShowType) {
    GTRouterPush, //push 方式打开
    GTRouterPresent, //模态弹出
    GTRouterUnknown,//未知打开方式
};
@interface UIViewController (GTRouter)
@property(nonatomic,copy)NSString *viewControllerIdentifier;
@property(nonatomic,assign)GTRouterShowType showType;
@end
