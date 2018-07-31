//
//  HZRouteGlobalConstant.h
//  GeekRoute
//
//  Created by 吴华林 on 2017/10/31.
//  Copyright © 2017年 wuhualin. All rights reserved.
//

//这个是webURL 打开的方式key
extern NSString *const kWebURLOpenTypeQueryName;
//这个是webURL 用系统自带的webView 打开时候 kWebURLOpenTypeQueryName 对应的value
extern NSString *const kWebURLOpenWithBrowserValue;
//系统自带webview 的类名(这个随着APP 不同可以自定义设置)
extern NSString *const kWebViewClass;
//承载url 地址的key
extern NSString *const kWebViewURLName;
//初始化viewController的方法名，这个可以根据APP 不同设置不同的（不过请保证参数只有一个）
extern NSString *const kInitViewControllerMethod;
//表示当前的是一个页面跳转host
extern NSString *const kViewHost;
//表示调用APP 的一个服务的host(这个暂定)
extern NSString *const kServiceHost;
//表示页面打开的方式的(没有这个参数默认是尝试用push的方式打开)
extern NSString *const kPresentTypeName;
//表示希望新的页面是push 方式打开的
extern NSString *const kPresentTypePushValue;
//表示希望新的页面是present 方式打开的
extern NSString *const kPresentTypePresentValue;
//如果url 地址没有scheme 的时候我们需要设置一个默认的scheme
extern NSString *const kDefaultURLScheme;

