//
//  GTRoute.m
//  GTTools
//
//  Created by 吴华林 on 2019/2/19.
//  Copyright © 2019 吴华林. All rights reserved.
//

#import "GTRouter.h"
@interface GTRouter()
@end
@implementation GTRouter
+ (instancetype)shareRouter {
    static dispatch_once_t onceToken;
    static GTRouter *router;
    dispatch_once(&onceToken, ^{
        router = [[GTRouter alloc] init];
    });
    return router;
}
- (void)updateViewsConfigWithFilePath:(NSString *)filePath {
    
}
- (void)updateViewsConfigWithDict:(NSDictionary *)dict {
    
}
#pragma mark 打开指定的视图
- (void)pushViewController:(UIViewController *)viewController {
    
}

- (void)pushViewControllerWithClassName:(NSString *)className parameter:(NSDictionary *)parameter {
    
}

- (void)pushViewControllerWithViewIdentifier:(NSString *)viewIdentifier parameter:(NSDictionary *)parameter {
    
}
- (void)presentViewController:(UIViewController *)viewController {
    
}

- (void)presentViewControllerWithClassName:(NSString *)className parameter:(NSDictionary *)parameter {
    
}

- (void)presentViewControllerWithViewIdentifier:(NSString *)viewIdentifier parameter:(NSDictionary *)parameter {
    
}

- (void)presentViewController:(UIViewController *)viewController tryPresentType:(GTRouterOpenType)presentType createType:(GTRouterCreateType)createType animated:(BOOL)animated completion:(void(^)(void))completion {
    
}

- (void)presentViewControllerWithClassName:(NSString *)className parameter:(NSDictionary *)parameter tryPresentType:(GTRouterOpenType)presentType createType:(GTRouterCreateType)createType animated:(BOOL)animated completion:(void(^)(void))completion {
    
}

- (void)presentViewControllerWithViewIdentifier:(NSString *)viewIdentifier parameter:(NSDictionary *)parameter tryPresentType:(GTRouterOpenType)presentType createType:(GTRouterCreateType)createType animated:(BOOL)animated completion:(void(^)(void))completion {
    
}
#pragma mark 回退到指定的视图
- (void)dismissToViewControllerWithClassName:(NSString *)className {
    
}
- (void)dismissToViewControllerWithClassName:(NSString *)className animated:(BOOL)animated {
    
}

- (void)dismissToViewControllerWithClassName:(NSString *)className params:(NSDictionary *)params animated:(BOOL)animated {
    
}
- (void)dismissToViewControllerWithViewIdentifier:(NSString *)viewIdentifier {
    
}

- (void)dismissToViewControllerWithViewIdentifier:(NSString *)viewIdentifier animated:(BOOL)animated {
    
}
- (void)dismissToViewControllerWithViewIdentifier:(NSString *)viewIdentifier params:(NSDictionary *)params animated:(BOOL)animated {
    
}

- (void)dismissWithStep:(NSUInteger)step {
    
}

- (void)dismissWithStep:(NSUInteger)step animated:(BOOL)animated {
    
}

- (void)dismissWithStep:(NSUInteger)step params:(NSDictionary *)params animated:(BOOL)animated {
    
}
#pragma mark 回退到上一个视图
- (UIViewController *)dismissViewController {
    return nil;
}
- (UIViewController *)dismissViewControllerAnimated:(BOOL)animated {
    return nil;
}
- (UIViewController *)dismissViewControllerWithParams:(NSDictionary *)params animated:(BOOL)animated {
    return nil;
}
#pragma mark 回退到根视图
- (void)dismissToRootViewController {
    
}

- (void)dismissToRootViewControllerAnimated:(BOOL)animated {
    
}

- (void)dismissToRootViewControllerWithParams:(NSDictionary *)params animated:(BOOL)animated {
    
}
@end
