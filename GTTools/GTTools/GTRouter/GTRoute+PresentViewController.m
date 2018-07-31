//
//  HZRoute+PresentViewController.m
//  HZRoute
//
//  Created by 吴华林 on 2017/9/3.
//  Copyright © 2017年 吴华林. All rights reserved.
//

#import "GTRoute+PresentViewController.h"
#import "GTRoute+OpenURL.h"
#import "GTRouteGlobalConstant.h"
#import <objc/runtime.h>
@implementation GTRoute (PresentViewController)

- (void)presentViewController:(UIViewController *)viewController tryPresentType:(HZRPresentType)presentType animated:(BOOL)animated completion:(void(^)(void))completion {
    //先过滤一遍是否需要跳转到url
    NSString *replaceURL = [self needReplaceWithViewController:viewController];
    if(replaceURL) {
        openURL(replaceURL);
    } else {
        [self.viewControllersStack addObject:viewController];
        if (self.viewControllersStack.count > 0)
        {
            viewController.hidesBottomBarWhenPushed = YES;
        }
        UIViewController *topViewController = [self visibleViewController];
        switch (presentType) {
            case HZRPush: {
                if((!topViewController.navigationController && ![topViewController isKindOfClass:[UINavigationController class]])||[viewController isKindOfClass:[UINavigationController class]]) {
                    //navigationController 不存在的时候，就会用present 去呈现
                    [topViewController presentViewController:viewController animated:animated completion:completion];
                } else {
                    if([topViewController isKindOfClass:[UINavigationController class]]) {
                        [(UINavigationController *)topViewController pushViewController:viewController animated:animated];
                        if(completion) {
                            completion();
                        }
                    } else {
                        [topViewController.navigationController pushViewController:viewController animated:animated];
                        if(completion) {
                            completion();
                        }
                    }
                    
                }
                break;
            }
            case HZRPresent: {
                [topViewController presentViewController:viewController animated:animated completion:completion];
                break;
            }
        }
    }
}

- (void)presentViewControllerWithClassName:(NSString *)className parameter:(id)parameter tryPresentType:(HZRPresentType)presentType animated:(BOOL)animated completion:(void(^)(void))completion {
    Class viewClass = [self viewControllerIsExistWithClassName:className];
    NSString *method = [self getInitMethodForClass:className];
    if(viewClass) {
        UIViewController *viewController = [self generatorViewControllerWithClass:viewClass method:method  parameter:parameter];
        [self presentViewController:viewController tryPresentType:presentType animated:animated completion:completion];
    }
}
- (void)presentViewControllerWithViewIdentifier:(NSString *)viewIdentifier parameter:(id)parameter tryPresentType:(HZRPresentType)presentType animated:(BOOL)animated completion:(void(^)(void))completion {
    Class viewClass = [self viewControllerIsExistWithIdentifier:viewIdentifier];
    NSString *method = [self getInitMethodForIdentifier:viewIdentifier];
    if(viewClass) {
        UIViewController *viewController = [self generatorViewControllerWithClass:viewClass method:method parameter:parameter];
        [self presentViewController:viewController tryPresentType:presentType animated:animated completion:completion];
    }
}
- (void)pushViewController:(UIViewController *)viewController {
    [self presentViewController:viewController tryPresentType:HZRPush animated:YES completion:nil];
}
- (void)pushViewControllerWithClassName:(NSString *)className parameter:(id)parameter {
    
    [self presentViewControllerWithClassName:className parameter:parameter tryPresentType:HZRPush animated:YES completion:nil];
    
    
}
- (void)pushViewControllerWithViewIdentifier:(NSString *)viewIdentifier parameter:(id)parameter {
    
    [self presentViewControllerWithViewIdentifier:viewIdentifier parameter:parameter tryPresentType:HZRPush animated:YES completion:nil];
}
- (void)presentViewController:(UIViewController *)viewController {
    [self presentViewController:viewController tryPresentType:HZRPresent animated:YES completion:nil];
}
- (void)presentViewControllerWithViewIdentifier:(NSString *)viewIdentifier parameter:(id)parameter {
    [self presentViewControllerWithViewIdentifier:viewIdentifier parameter:parameter tryPresentType:HZRPresent animated:YES completion:nil];
}
- (void)presentViewControllerWithClassName:(NSString *)className parameter:(id)parameter {
    [self presentViewControllerWithClassName:className parameter:parameter tryPresentType:HZRPresent animated:YES completion:nil];
}
#pragma 回退到指定的视图
- (void)dismissToViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void(^)(void))completion {
    
    if([viewController isKindOfClass:[UINavigationController class]]) {
        [(UINavigationController *)viewController popToRootViewControllerAnimated:animated];
        if(completion) {
            completion();
        }
    } else if(viewController.navigationController) {
        [viewController.navigationController popToViewController:viewController animated:animated];
        if(completion) {
            completion();
        }
    }
    if(viewController.presentedViewController) {
        [viewController dismissViewControllerAnimated:animated completion:completion];
    }
}
/**
 回退制定的viewControllerm,默认是带动画，并且不带后续操作的
 
 @param viewController 需要回退的视图
 */
- (void)dismissToViewController:(UIViewController *)viewController {
    [self dismissToViewController:viewController animated:YES completion:nil];
}
/**
 回退最近一个className 与给出的className 匹配的视图
 
 @param className 需要回退的视图的className
 @param animated  是否需要动画
 @param completion 回退成功以后执行的block
 */
- (void)dismissToViewControllerWithClassName:(NSString *)className animated:(BOOL)animated completion:(void (^)(void))completion {
    UIViewController *viewController = [self getViewControllerForClass:className];
    [self dismissToViewController:viewController animated:animated completion:completion];
}

/**
 回退最近一个className 与给出的className 匹配的视图,默认是有动画并且没有后续操作的
 
 @param className 需要回退的视图className
 */
- (void)dismissToViewControllerWithClassName:(NSString *)className {
    [self dismissToViewControllerWithClassName:className animated:YES completion:nil];
}
/**
 根据页面唯一标示回退到对应的页面
 
 @param viewIdentifier 页面唯一标示
 */
- (void)dismissToViewControllerWithViewIdentifier:(NSString *)viewIdentifier {
    [self dismissToViewControllerWithViewIdentifier:viewIdentifier animated:YES completion:nil];
}

/**
 根据页面唯一标示回退到对应的页面（带设置动画的）
 
 @param viewIdentifier 页面唯一标示
 @param animated 是否支持动画
 @param completion 完成执行的block
 */
- (void)dismissToViewControllerWithViewIdentifier:(NSString *)viewIdentifier animated:(BOOL)animated completion:(void (^)(void))completion {
    Class tagertClass =[self viewControllerIsExistWithIdentifier:viewIdentifier];
    [self dismissToViewControllerWithClassName:NSStringFromClass(tagertClass) animated:animated completion:completion];
}
#pragma mark 回退到上一个视图
- (UIViewController *)dismissViewControllerAnimated:(BOOL)animated completion:(void(^)(void))completion{
    UIViewController *visibleViewController = [self visibleViewController];
    if(visibleViewController.navigationController) {
        if(visibleViewController.navigationController.viewControllers.count ==1) {
            //如果是rootViewController
        if(visibleViewController.navigationController.presentingViewController) {
                [visibleViewController.navigationController dismissViewControllerAnimated:animated completion:completion];
            }
        } else {
            //如果是被push 出来的
            [visibleViewController.navigationController popViewControllerAnimated:animated];
            if(completion) {
                completion();
            }
            
        }
        
    } else if([visibleViewController presentingViewController]) {
        //是被presented 弹出的
        [visibleViewController dismissViewControllerAnimated:animated completion:completion];
    }
    return visibleViewController;
}
/**
 回退当前的页面默认是带动画的，不带回退以后进行的操作
 
 @return 返回当前对象
 */
- (UIViewController *)dismissViewController {
    return  [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 回退到根视图
- (void)dismissToRootViewControllerAnimated:(BOOL)animated completion:(void(^)(void))completion {
    UIViewController *viewController =  [[UIApplication sharedApplication] keyWindow].rootViewController;
    //如果根视图是UITabbarViewController 情况下
    if ([viewController isKindOfClass:[UITabBarController class]]) {
        viewController = [(UITabBarController *)viewController selectedViewController];
    }
    //如果根视图是UINavigationController 情况下
    if([viewController isKindOfClass:[UINavigationController class]]) {
        [(UINavigationController *)viewController popToRootViewControllerAnimated:animated];
        if(completion) {
            completion();
        }
    } else if(viewController.navigationController) {
        [viewController.navigationController popToRootViewControllerAnimated:animated];
        if(completion) {
            completion();
        }
    }
    //如果根视图是直接弹出下一个视图的
    if(viewController.presentedViewController) {
        [viewController dismissViewControllerAnimated:animated completion:completion];
    }
    
}
/**
 默认回退到根视图是带动画的
 */
- (void)dismissToRootViewController {
    [self dismissToRootViewControllerAnimated:YES completion:nil];
}

#pragma mark 自定义回退操作
- (void)dismissViewControllerWithCustomHandle:(id(^)(void))customHandle{
    if(customHandle) {
        customHandle();
    }
}
- (UIViewController *)viewControllerWithIdentifier:(NSString *)identifier parameter:(NSDictionary *)parameter {
    Class className = [self viewControllerIsExistWithIdentifier:identifier];
    NSString *method = [self getInitMethodForIdentifier:identifier];
    if(className) {
        return  [self generatorViewControllerWithClass:className method:method parameter:parameter];
    }
    return nil;
}
#pragma mark private
- (UIViewController *)getViewControllerForClass:(NSString *)className {
    UIViewController *viewController = nil;
    if(className){
        Class targetClass = NSClassFromString(className);
        NSArray *viewControllers = [self.viewControllersStack allObjects];
        for(int i =((int)viewControllers.count-1); i>=0;i--) {
            viewController = viewControllers[i];
            if([viewController isKindOfClass:targetClass]) {
                break;
            }
        }
    }
    if(!viewController) {
        viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    }
    return viewController;
}
- (Class)viewControllerIsExistWithClassName:(NSString *)className {
    if(className &&className.length) {
        Class class = NSClassFromString(className);
        if(class){
            return class;
        }
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:kRouteViewError_404Notification object:nil];
    return nil;
}
- (Class)viewControllerIsExistWithIdentifier:(NSString *)viewIdentifier {
    if(viewIdentifier && viewIdentifier.length) {
        NSDictionary *viewDict = [self.viewMap objectForKey:viewIdentifier];
        NSString *className = [viewDict objectForKey:@"className"];
        return [self viewControllerIsExistWithClassName:className];
    }
    return nil;
}

- (NSString *)needReplaceWithViewController:(UIViewController *)viewController {
    NSString *className = NSStringFromClass([viewController class]);
    for(NSDictionary *viewValue in self.viewMap.allValues) {
        NSString *tempViewClassName = viewValue[@"className"];
        if([tempViewClassName isEqualToString:className]) {
            BOOL needReplace = [viewValue[@"needReplace"] boolValue];
            if(needReplace) {
                return viewValue[@"url"];
            }
        }
    }
    return nil;
}
@end

