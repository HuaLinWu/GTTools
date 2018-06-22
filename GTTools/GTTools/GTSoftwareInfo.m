//
//  GTDevice.m
//  GTTools
//
//  Created by 吴华林 on 2018/6/20.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import "GTSoftwareInfo.h"
#import <UIKit/UIDevice.h>
@implementation GTSoftwareInfo
+ (NSString *)name {
    return [UIDevice currentDevice].name;
}
+ (NSString *)model {
     return [UIDevice currentDevice].model;
}
+ (NSString *)localizedModel {
    return [UIDevice currentDevice].localizedModel;
}
+ (NSString *)systemName {
    return [UIDevice currentDevice].systemName;
}
+ (NSString *)systemVersion {
     return [UIDevice currentDevice].systemVersion;
}
+ (NSString *)identifierForVendor {
    
    return [[UIDevice currentDevice].identifierForVendor UUIDString];
}
+ (NSString *)appName {
    
    static NSString *appName;
    if(!appName) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
        });
    }
    return appName;
}

+ (NSString *)appBuild {
    
    static NSString *appBuild;
    if(!appBuild) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
        });
    }
    return appBuild;
}

+ (NSString *)appVersion {
    static NSString *appVersion;
    if(!appVersion) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        });
    }
    return appVersion;
}

@end
