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
- (void)configWithFilePath:(NSString *)filePath;
- (void)configWithViewsMap:(NSDictionary *)viewsConfig;
#pragma mark 打开指定的视图

#pragma mark 回退到指定的视图
/**
 回退最近一个className 与给出的className 匹配的视图
 
 @param className 需要回退的视图的className
 @param animated  是否需要动画
 */
- (void)dismissToViewControllerWithClassName:(NSString *)className animated:(BOOL)animated;
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
 */
- (void)dismissToViewControllerWithViewIdentifier:(NSString *)viewIdentifier animated:(BOOL)animated;

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
