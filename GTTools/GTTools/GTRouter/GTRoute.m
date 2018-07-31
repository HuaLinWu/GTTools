//
//  HZRoute.m
//  HZRoute
//
//  Created by 吴华林 on 2017/9/2.
//  Copyright © 2017年 吴华林. All rights reserved.
//

#import "GTRoute.h"
#import <UIKit/UIKit.h>
#import "GTRouteGlobalConstant.h"
NSString *const kRouteViewError_404Notification=@"kRouteViewError_404Notification";
#import <objc/runtime.h>
@interface GTRoute()
@property(nonatomic,strong)UIViewController *visibleViewController;
@property(nonatomic,copy)NSDictionary *routeGlobalConstantValueDict;
@property(nonatomic,copy)NSDictionary *viewMap;
@property(nonatomic,strong)NSHashTable *viewControllersStack;
@end
@implementation GTRoute
static GTRoute *_route;
+ (instancetype)shareRoute {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _route = [[GTRoute alloc] init];
    });
    return _route;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    if(!_route) {
        _route = [super allocWithZone:zone];
    }
    return _route;
}
- (instancetype)copy {
    return [GTRoute shareRoute];
}
- (instancetype)mutableCopy {
    return [GTRoute shareRoute];
}

- (void)registerViewMap:(NSDictionary *)viewMap {
    if(viewMap) {
        NSMutableDictionary *tempDict = [NSMutableDictionary dictionaryWithDictionary:self.viewMap];
        [tempDict setValuesForKeysWithDictionary:viewMap];
        self.viewMap = tempDict;
        tempDict = nil;
    }
}
- (void)updateRouteGlobalConstantValue:(NSDictionary *)dict {
    if(dict) {
        NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] init];
        if(self.routeGlobalConstantValueDict) {
            [tempDict setValuesForKeysWithDictionary:self.routeGlobalConstantValueDict];
        }
        [tempDict setValuesForKeysWithDictionary:dict];
        self.routeGlobalConstantValueDict = tempDict;
    }
}
- (UIViewController *)visibleViewController {
    return [self topViewController];
}
- (NSString *)viewURLWithIdentifier:(NSString *)identifier presentType:(HZRPresentType)presentType {
    NSString *tempScheme =@"";
    NSArray *bundleURLTypes = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleURLTypes"];
    for(NSDictionary *bundleURLTypeDict in bundleURLTypes) {
        NSArray *schemes = bundleURLTypeDict[@"CFBundleURLSchemes"];
        if(schemes.count >0) {
            tempScheme =schemes[0];
        }
    }
    NSString *prsentType = @"";
    if(presentType == HZRPush) {
        prsentType = [self getValidGlobalConstant:kPresentTypePushValue];
    } else {
        prsentType = [self getValidGlobalConstant:kPresentTypePresentValue];
    }
    NSString *url = [NSString stringWithFormat:@"%@://%@/%@?%@=%@",tempScheme,[self getValidGlobalConstant:kViewHost],identifier,[self getValidGlobalConstant:kPresentTypeName],prsentType];
    return url;
}
#pragma mark private
- (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}
/**
 安全的给你UIViewController 对象赋值（防止对象赋值的属性不存在的时候，进行赋值的时候出现闪退）
 
 @param viewController 对象
 @param value 属性的值
 @param key 属性（优先会从property 中key 对应的，如果property 中不存在，再Ivar 中找，如果Ivar 还是不存在，那么会查找Ivar 是否存在_key 如果存在进行赋值，如果以上都没有就会丢掉当前的值）
 */
- (void)safeSetValueToViewController:(UIViewController *)viewController value:(NSString *)value key:(NSString *)key {
    //从property 查找
    unsigned int propertyCount = 0;
    objc_property_t *propertyList = class_copyPropertyList([viewController class], &propertyCount);
    for(int i =0; i <propertyCount ; i++) {
        objc_property_t property = propertyList[i];
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        if([propertyName isEqualToString:key]) {
            [viewController setValue:value forKey:key];
            return;
        }
    }
    //从Ivar 中查找key
    unsigned int ivarCount = 0;
    Ivar *ivarList = class_copyIvarList([viewController class], &ivarCount);
    for(int i=0; i<ivarCount; i++) {
        Ivar ivar = ivarList[i];
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        if([ivarName isEqualToString:key]) {
            object_setIvar(viewController, ivar, value);
            return;
        }
    }
    //从Ivar 中查找_key（这个有时候可能会不准确）
    NSString *_key = [@"_" stringByAppendingString:key];
    for(int i=0; i<ivarCount; i++) {
        Ivar ivar = ivarList[i];
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        if([ivarName isEqualToString:_key]) {
            object_setIvar(viewController, ivar, value);
            return;
        }
    }
}
#pragma mark set/get
- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}
- (NSString *)getInitMethodForClass:(NSString *)className {
    for(NSDictionary *viewValue in self.viewMap.allValues) {
        NSString *tempViewClassName = viewValue[@"className"];
        if([tempViewClassName isEqualToString:className]) {
            NSString *method = viewValue[@"method"];
            if(method && method.length) {
                return method;
            }
            break;
        }
    }
    return [self getValidGlobalConstant:kInitViewControllerMethod];
}
-(NSString *)getInitMethodForIdentifier:(NSString *)viewIdentifier {
    if(viewIdentifier && viewIdentifier.length) {
        NSDictionary *viewDict = [self.viewMap objectForKey:viewIdentifier];
        NSString *method = [viewDict objectForKey:@"method"];
        if(method && method.length) {
            return method;
        }
    }
    return [self getValidGlobalConstant:kInitViewControllerMethod];
}
- (UIViewController *)generatorViewControllerWithClass:(Class)viewControllerClass method:(NSString *)sel parameter:(id)parameter {
    
    UIViewController *viewController = nil;
    if(sel){
        SEL selMethod = NSSelectorFromString(sel);
        //先查找是否类方法存在指定的方法就执行
        viewController  = [viewControllerClass alloc];
        if([viewController respondsToSelector:selMethod]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            viewController = [viewController performSelector:selMethod withObject:parameter];
#pragma clang diagnostic pop
            
        } else {
            viewController = [[viewControllerClass alloc] init];
            //如果对象没有实现指定的初始化方法时（这个将参数当成property 进行赋值）
            if(parameter && [parameter isKindOfClass:[NSDictionary class]]) {
                for(NSString *key in [parameter allKeys]) {
                    [self safeSetValueToViewController:viewController value:parameter[key] key:key];
                }
            }
        }
    }
    return  viewController;
}
- (NSString *)getValidGlobalConstant:(NSString *)source {
    NSString *returnValue = source;
    if([self.routeGlobalConstantValueDict isKindOfClass:[NSDictionary class]]) {
        if([[self.routeGlobalConstantValueDict allKeys] containsObject:source]) {
            returnValue = self.routeGlobalConstantValueDict[source];
            if(!returnValue || !returnValue.length) {
                returnValue = source;
            }
        }
    }
    return returnValue;
}
- (NSHashTable *)viewControllersStack {
    
    if(!_viewControllersStack) {
        _viewControllersStack = [NSHashTable weakObjectsHashTable];
    }
    return _viewControllersStack;
}
@end
