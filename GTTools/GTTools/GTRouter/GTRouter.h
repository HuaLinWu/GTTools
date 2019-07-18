//
//  GTRoute.h
//  GTTools
//
//  Created by 吴华林 on 2019/2/19.
//  Copyright © 2019 吴华林. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, GTRouterOpenType) {
    GTRouterOpenTypePush, //push 方式打开
    GTRouterOpenTypePresent, //模态弹出
    GTRouterOpenTypeOther //用户自定方式转场
};
typedef NS_ENUM(NSInteger, GTRouterCreateType) {
    GTRouterCreateTypeNew, //new 一个新的对象（VC数量加1）
    GTRouterCreateTypeReplace, //创建一个新的对象替换当前的对象(VC的数量不变)
    GTRouterCreateTypeRefresh//如果当前的堆中存在和目标一样的vc，移除vc 以后所有的vc，并且刷新vc
};
@interface GTRouter : NSObject
@property(nonatomic,weak)UINavigationController *topNavigationController;
+ (instancetype)shareRouter;
/**
 根据文件路径来更新页面路由表

 @param filePath 文件路径
 */
- (void)updateViewsConfigWithFilePath:(NSString *)filePath;

/**
 根据字典来更新页面路由表

 @param dict  固定格式的字典
 */
- (void)updateViewsConfigWithDict:(NSDictionary *)dict;
#pragma mark 打开指定的视图

/**
 通过push 方式打开视图（如果无法打开改用present 方法，默认带有动画的）
 @param viewController 即将被呈现的视图
 */
- (void)pushViewController:(UIViewController *)viewController;

/**
 通过push 方式打开视图（如果无法打开改用present 方法，默认带有动画的，创建视图采用的是GTRouterCreateTypeNew）
 @param className 需要跳转的类名
 @param parameter 需要携带的参数
 */
- (void)pushViewControllerWithClassName:(NSString *)className parameter:(NSDictionary *)parameter;

/**
 通过push 方式打开视图（如果无法打开改用present 方法，默认带有动画的，创建视图采用的是GTRouterCreateTypeNew）
 
 @param viewIdentifier 需要跳转的唯一标示
 @param parameter 需要携带的参数
 */
- (void)pushViewControllerWithViewIdentifier:(NSString *)viewIdentifier parameter:(NSDictionary *)parameter;
/**
 通过present 方式打开视图（默认带动画，）
 
 @param viewController 即将被呈现的视图
 */
- (void)presentViewController:(UIViewController *)viewController;

/**
 通过present 方式打开视图（默认带动画，创建视图采用的是GTRouterCreateTypeNew）
 
 @param className 需要跳转的类名
 @param parameter 需要携带的参数
 */
- (void)presentViewControllerWithClassName:(NSString *)className parameter:(NSDictionary *)parameter;

/**
 通过present 方式打开视图（默认带动画）
 
 @param viewIdentifier 需要跳转的唯一标示
 @param parameter 需要携带的参数
 */
- (void)presentViewControllerWithViewIdentifier:(NSString *)viewIdentifier parameter:(NSDictionary *)parameter;
/**
 尝试的用指定的方式去打开指定的页面
 
 @param viewController 即将被呈现的视图
 @param presentType 呈现的方式
@param createType 创建viewController的方式
 @param animated 是否需要带默认的动画
 @param completion 完成以后执行的block
 */
- (void)presentViewController:(UIViewController *)viewController tryPresentType:(GTRouterOpenType)presentType createType:(GTRouterCreateType)createType animated:(BOOL)animated completion:(void(^)(void))completion;
/**
 尝试的用指定的方式去打开指定的页面
 
 @param className 即将被呈现的视图的class
 @param parameter 需要传递的参数
 @param presentType 呈现的方式
 @param createType 创建viewController的方式
 @param animated 是否需要带默认的动画
 @param completion 完成以后执行的block
 */
- (void)presentViewControllerWithClassName:(NSString *)className parameter:(NSDictionary *)parameter tryPresentType:(GTRouterOpenType)presentType createType:(GTRouterCreateType)createType animated:(BOOL)animated completion:(void(^)(void))completion;
/**
 尝试的用指定的方式去打开指定的页面
 
 @param viewIdentifier 即将被呈现的视图的唯一标示
 @param parameter 需要传递的参数
 @param presentType 呈现的方式
 @param createType 创建viewController的方式
 @param animated 是否需要带默认的动画
 @param completion 完成以后执行的block
 */
- (void)presentViewControllerWithViewIdentifier:(NSString *)viewIdentifier parameter:(NSDictionary *)parameter tryPresentType:(GTRouterOpenType)presentType createType:(GTRouterCreateType)createType animated:(BOOL)animated completion:(void(^)(void))completion;
#pragma mark 回退到指定的视图
/**
 回退最近一个className 与给出的className 匹配的视图,默认是有动画并且没有后续操作的
 
 @param className 需要回退的视图className
 */
- (void)dismissToViewControllerWithClassName:(NSString *)className;
/**
 回退最近一个className 与给出的className 匹配的视图
 
 @param className 需要回退的视图的className
 @param animated  是否需要动画
 */
- (void)dismissToViewControllerWithClassName:(NSString *)className animated:(BOOL)animated;

/**
 回退最近一个className 与给出的className 匹配的视图

 @param className 需要回退的视图的className
 @param params 需要携带的参数
 @param animated 是否需要动画
 */
- (void)dismissToViewControllerWithClassName:(NSString *)className params:(NSDictionary *)params animated:(BOOL)animated;
/**
 根据页面唯一标示回退到对应的页面
 
 @param viewIdentifier 页面唯一标示
 */
- (void)dismissToViewControllerWithViewIdentifier:(NSString *)viewIdentifier;

/**
 根据页面唯一标示回退到对应的页面（带设置动画的）
 
 @param viewIdentifier 页面唯一标示
 @param animated 是否支持动画
 */
- (void)dismissToViewControllerWithViewIdentifier:(NSString *)viewIdentifier animated:(BOOL)animated;

/**
 根据页面唯一标示回退到对应的页面（带设置动画的）

 @param viewIdentifier 页面唯一标示
 @param params 返回需要携带的参数
 @param animated 是否支持动画
 */
- (void)dismissToViewControllerWithViewIdentifier:(NSString *)viewIdentifier params:(NSDictionary *)params animated:(BOOL)animated;
/**
 回退指定的页面数默认是默认的动画

 @param step 需要回退的页面数
 */
- (void)dismissWithStep:(NSUInteger)step;

/**
 回退指定的页面数指定是否带有动画

 @param step 需要回退的页面数
 @param animated 是否支持动画
 */
- (void)dismissWithStep:(NSUInteger)step animated:(BOOL)animated;

/**
 回退指定的页面数指定是否带有动画和携带参数到指定的页面
 @param step 需要回退的页面数
 @param params 携带的参数
 @param animated 是否支持动画
 */
- (void)dismissWithStep:(NSUInteger)step params:(NSDictionary *)params animated:(BOOL)animated;
#pragma mark 回退到上一个视图
/**
 回退当前的页面默认是带动画的，不带回退以后进行的操作
 
 @return 返回当前对象
 */
- (UIViewController *)dismissViewController;
/**
 回退当前的页面，不用考虑当前视图的呈现方式是模态弹出，还是push 弹出
 
 @param animated 是否需要动画
 @return 回退的页面
 */
- (UIViewController *)dismissViewControllerAnimated:(BOOL)animated;

/**
 回退当前的页面，不用考虑当前视图的呈现方式是模态弹出，还是push 弹出

 @param params 需要返回的参数
 @param animated 是否需要动画
 @return 回退的页面
 */
- (UIViewController *)dismissViewControllerWithParams:(NSDictionary *)params animated:(BOOL)animated;
#pragma mark 回退到根视图
/**
 默认回退到根视图是带动画的
 */
- (void)dismissToRootViewController;
/**
 回退到根视图，不用考虑当前视图的呈现方式是模态弹出，还是push 弹出
 
 @param animated 是否需要有默认的动画
 */
- (void)dismissToRootViewControllerAnimated:(BOOL)animated;

/**
 回退到根试图不用考虑当前视图的呈现方式是模态弹出，还是push 弹出

 @param params 需要携带的参数
 @param animated 是否需要有默认的动画
 */
- (void)dismissToRootViewControllerWithParams:(NSDictionary *)params animated:(BOOL)animated;
@end

NS_ASSUME_NONNULL_END
