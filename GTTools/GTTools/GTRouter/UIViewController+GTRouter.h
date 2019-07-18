//
//  UIViewController+GTRouter.h
//  GTTools
//
//  Created by 吴华林 on 2019/2/21.
//  Copyright © 2019 吴华林. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (GTRouter)
/**
 检查是否有权限跳转（默认所有的视图都是无权限的）

 @param parameter 外部携带的参数
 @return YES 表示有权限跳转，NO 表示无权限跳转（这时候会调用handleNoAccessToOpenWithParameter: 方法处理权限）
 */
+ (BOOL)validateTheAccessToOpenWithParameter:(NSDictionary *)parameter;

/**
 处理无权访问的方法
 @param parameter 外部传入的参数
 */
+ (void)handleNoAccessToOpenWithParameter:(NSDictionary *)parameter;

/**
 初始化当前视图的初始化方法

 @param parameter 外部携带的参数
 @return viewController 的对象
 */
- (instancetype)initWithQuery:(NSDictionary *)parameter;

/**
 接受之前页面回退到当前页面的携带参数的地方

 @param parameter 参数
 */
- (void)acceptPopParams:(NSDictionary *)parameter;

/**
 页面刷新
 */
- (void)routerRefresh;
@end

NS_ASSUME_NONNULL_END
