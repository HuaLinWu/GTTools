//
//  HZRoute+PresentViewController.h
//  HZRoute
//  本类主要配合HZRoute 做页面跳转
//  Created by 吴华林 on 2017/9/3.
//  Copyright © 2017年 吴华林. All rights reserved.
//

#import "GTRoute.h"
#import <UIKit/UIKit.h>

@interface GTRoute (PresentViewController)

/**
 尝试的用指定的方式去打开指定的页面

 @param viewController 即将被呈现的视图
 @param presentType 呈现的方式
 @param animated 是否需要带默认的动画
 @param completion 完成以后执行的block
 */
- (void)presentViewController:(UIViewController *)viewController tryPresentType:(HZRPresentType)presentType animated:(BOOL)animated completion:(void(^)(void))completion;

/**
 尝试的用指定的方式去打开指定的页面

 @param className 即将被呈现的视图的class
 @param parameter 需要传递的参数
 @param presentType 呈现的方式
 @param animated 是否需要带默认的动画
 @param completion 完成以后执行的block
 */
- (void)presentViewControllerWithClassName:(NSString *)className parameter:(id)parameter tryPresentType:(HZRPresentType)presentType animated:(BOOL)animated completion:(void(^)(void))completion;

/**
 尝试的用指定的方式去打开指定的页面

 @param viewIdentifier 即将被呈现的视图的唯一标示
 @param parameter 需要传递的参数
 @param presentType 呈现的方式
 @param animated 是否需要带默认的动画
 @param completion 完成以后执行的block
 */
- (void)presentViewControllerWithViewIdentifier:(NSString *)viewIdentifier parameter:(id)parameter tryPresentType:(HZRPresentType)presentType animated:(BOOL)animated completion:(void(^)(void))completion;
/**
 通过push 方式打开视图（如果无法打开改用present 方法，默认带有动画的）
 @param viewController 即将被呈现的视图
 */
- (void)pushViewController:(UIViewController *)viewController;

/**
 通过push 方式打开视图（如果无法打开改用present 方法，默认带有动画的）
 @param className 需要跳转的类名
 @param parameter 需要携带的参数
 */
- (void)pushViewControllerWithClassName:(NSString *)className parameter:(id)parameter;

/**
 通过push 方式打开视图（如果无法打开改用present 方法，默认带有动画的）

 @param viewIdentifier 需要跳转的唯一标示
 @param parameter 需要携带的参数
 */
- (void)pushViewControllerWithViewIdentifier:(NSString *)viewIdentifier parameter:(id)parameter;
/**
 通过present 方式打开视图（默认带动画）

 @param viewController 即将被呈现的视图
 */
- (void)presentViewController:(UIViewController *)viewController;

/**
 通过present 方式打开视图（默认带动画）

 @param className 需要跳转的类名
 @param parameter 需要携带的参数
 */
- (void)presentViewControllerWithClassName:(NSString *)className parameter:(id)parameter;

/**
  通过present 方式打开视图（默认带动画）

 @param viewIdentifier 需要跳转的唯一标示
 @param parameter 需要携带的参数
 */
- (void)presentViewControllerWithViewIdentifier:(NSString *)viewIdentifier parameter:(id)parameter;
#pragma mark 回退到指定的视图
/**
 回退到指定的ViewController，不用考虑当前呈现的ViewController 是present模态的弹出，还是通过push 方式出来的
 @param viewController 需要回退到的viewController
 @param animated 是否需要动画
  @param completion 回退结束以后执行的block
 */
- (void)dismissToViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void(^)(void))completion;

/**
 回退制定的viewControllerm,默认是带动画，并且不带后续操作的

 @param viewController 需要回退的视图
 */
- (void)dismissToViewController:(UIViewController *)viewController;
/**
 回退最近一个className 与给出的className 匹配的视图

 @param className 需要回退的视图的className
 @param animated  是否需要动画
 @param completion 回退成功以后执行的block
 */
- (void)dismissToViewControllerWithClassName:(NSString *)className animated:(BOOL)animated completion:(void (^)(void))completion;

/**
  回退最近一个className 与给出的className 匹配的视图,默认是有动画并且没有后续操作的

 @param className 需要回退的视图className
 */
- (void)dismissToViewControllerWithClassName:(NSString *)className;

/**
 根据页面唯一标示回退到对应的页面

 @param viewIdentifier 页面唯一标示
 */
- (void)dismissToViewControllerWithViewIdentifier:(NSString *)viewIdentifier;

/**
 根据页面唯一标示回退到对应的页面（带设置动画的）

 @param viewIdentifier 页面唯一标示
 @param animated 是否支持动画
 @param completion 完成执行的block
 */
- (void)dismissToViewControllerWithViewIdentifier:(NSString *)viewIdentifier animated:(BOOL)animated completion:(void (^)(void))completion;
#pragma mark 回退到上一个视图
/**
 回退当前的页面，不用考虑当前视图的呈现方式是模态弹出，还是push 弹出

 @param animated 是否需要动画
 @param completion 回退结束以后执行的block
 @return 回退的页面
 */
- (UIViewController *)dismissViewControllerAnimated:(BOOL)animated completion:(void(^)(void))completion;

/**
 回退当前的页面默认是带动画的，不带回退以后进行的操作

 @return 返回当前对象
 */
- (UIViewController *)dismissViewController;


#pragma mark 回退到根视图
/**
 回退到根视图，不用考虑当前视图的呈现方式是模态弹出，还是push 弹出

 @param animated 是否需要有默认的动画
 @param completion 回退结束以后执行的block
 */
- (void)dismissToRootViewControllerAnimated:(BOOL)animated completion:(void(^)(void))completion;

/**
 默认回退到根视图是带动画的
 */
- (void)dismissToRootViewController;


#pragma mark 自定义回退操作
/**
 自定义回退视图操作
 
 @param customHandle 自定义回退视图的操作
 */
- (void)dismissViewControllerWithCustomHandle:(id(^)(void))customHandle;

/**
 根据页面唯一标示获取一个UIViewController

 @param identifier 页面唯一标示
 @return 一个初始化完成的
 */
- (UIViewController *)viewControllerWithIdentifier:(NSString *)identifier parameter:(NSDictionary *)parameter;
@end
