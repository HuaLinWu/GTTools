//
//  HZRoute+OpenURL.h
//  HZRoute
//
//  Created by 吴华林 on 2017/10/24.
//  Copyright © 2017年 吴华林. All rights reserved.
//

#import "GTRoute.h"

@interface GTRoute (OpenURL)
/**
 打开url
 
 @param url 需要打开的url
 */
void openURL(NSString *url);

/**
 打开url 携带参数（目前这个只对打开APP里面原生页面起作用，不包括打开系统功能的）

 @param url 即将要打开的url
 @param extendParameter 需要额外带的参数（主要是针对携带原生对象）
 */
void openURLWithParameter(NSString *url,NSDictionary *extendParameter);
@end
