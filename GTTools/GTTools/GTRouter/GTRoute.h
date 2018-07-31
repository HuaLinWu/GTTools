//
//  HZRoute.h
//  HZRoute
//   
//  Created by 吴华林 on 2017/9/2.
//  Copyright © 2017年 吴华林. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, HZRPresentType) {
    HZRPush, //push 方式打开
    HZRPresent, //模态弹出
};
//跳转的页面不存在的通知
extern NSString *const kRouteViewError_404Notification;
@class UIViewController;
@interface GTRoute : NSObject
@property(nonatomic,readonly,strong)UIViewController *visibleViewController;

/**
 承载对应的视图plist 对应的内容
 */
@property(nonatomic, readonly, copy)NSDictionary *viewMap;

/**
 经过本路由推送的所有的视图堆栈
 */
@property(nonatomic,readonly, strong)NSHashTable *viewControllersStack;

/**
 路由常用的常量对象
 */
@property(nonatomic,readonly,copy)NSDictionary *routeGlobalConstantValueDict;
+ (instancetype)shareRoute;

/**
 将APP的页面注册到路由中来
 @param viewMap 页面集合
 viewMap 字典的格式应该如下:
 {
 @"page1" /这个页面唯一标示/ :{
 className://类名实际映射的类名(NSString)
 needReplace://是否需要用url替换原来的类的显示（BOOL）
 method://需要执行的方法（如果没有设置默认的是kInitViewControllerMethod 对应的方法）
 note://这个是阅读信息
 url://这个是http url地址，主要用来配合needReplace 来替换原生页面
 },
 @"page2":{
 className://类名实际映射的类名(NSString)
 needReplace://是否需要用url替换原来的类的显示（BOOL）
 note://这个是阅读信息
method://需要执行的方法（如果没有设置默认的是kInitViewControllerMethod 对应的方法）
 url://这个是http url地址，主要用来配合needReplace 来替换原生页面
 }
 }
 */
- (void)registerViewMap:(NSDictionary *)viewMap;

/**
  更文件HZRouteGlobalConstant.h常量的值

 @param dict 需要更改部分字段获取全部字段的值
 例子：
 @{kWebURLOpenTypeQueryName:@"openWith1"}
 */
- (void)updateRouteGlobalConstantValue:(NSDictionary *)dict;

/**
 根据类名获取初始化方法

 @param className 类名
 @return 获取初始化方法
 */
- (NSString *)getInitMethodForClass:(NSString *)className;

/**
 根据唯一标示获取初始化方法

 @param viewIdentifier 页面唯一标示
 @return 获取初始化方法
 */
-(NSString *)getInitMethodForIdentifier:(NSString *)viewIdentifier;

/**
 根据类名，和初始化方法名，初始化参数

 @param viewControllerClass 类名
 @param sel 初始化方法
 @param parameter 初始化参数
 @return 返回对应的viewController
 */
- (UIViewController *)generatorViewControllerWithClass:(Class)viewControllerClass method:(NSString *)sel parameter:(id)parameter;

/**
 获取常量对应的指

 @param source HZRouteGlobalConstant.h 里的常量
 @return 常量对应的值
 */
- (NSString *)getValidGlobalConstant:(NSString *)source;
/**
 根据用户信息获取
 
 @param identifier 页面唯一标示
 @param presentType 呈现的方式
 @return 返回页面的url
 */
- (NSString *)viewURLWithIdentifier:(NSString *)identifier presentType:(HZRPresentType)presentType;
@end
