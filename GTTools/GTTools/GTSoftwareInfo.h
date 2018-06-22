//
//  GTDevice.h
//  GTTools
//
//  Created by 吴华林 on 2018/6/20.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GTSoftwareInfo : NSObject
@property(nonatomic,readonly,class,strong)NSString *name;
@property(nonatomic,readonly,class,strong)NSString *model;
@property(nonatomic,readonly,class,strong)NSString *localizedModel;
@property(nonatomic,readonly,class,strong) NSString *systemName;
@property(nonatomic,readonly,class,strong) NSString *systemVersion;

/**
 The value of this property is the same for apps that come from the same vendor running on the same device. A different value is returned for apps on the same device that come from different vendors, and for apps on different devices regardless of vendor.
 如果满足这样的条件，那么获取到的这个属性值就不会变：相同的一个程序里面-相同的vindor-相同的设备。如果是这样的情况，那么这个值是不会相同的：相同的程序-相同的设备-不同的vindor，或者是相同的程序-不同的设备-无论是否相同的vindor。
 看完上面的内容，我有这样的一个疑问“vendor是什么”。我首先想到的是苹果开发者账号。但事实证明这是错误的。接着我想可能是有一个AppIdentifierPrefix东西，跟钥匙串访问一样，可以在多个程序间共享。同样，这个想法也是的。最后证明，vendor非常简单：一个Vendor是CFBundleIdentifier（反转DNS格式）的前两部分。例如，com.doubleencore.app1 和 com.doubleencore.app2 得到的identifierForVendor是相同的，因为它们的CFBundleIdentifier 前两部分是相同的。不过这样获得的identifierForVendor则完全不同：com.massivelyoverrated 或 net.doubleencore。
 在这里，还需要注意的一点就是：如果用户卸载了同一个vendor对应的所有程序，然后在重新安装同一个vendor提供的程序，此时identifierForVendor会被重置。
 */
@property(nonatomic,readonly,class,strong)NSString*  identifierForVendor;
@property(nonatomic,readonly,class,strong)NSString *appName;
@property(nonatomic,readonly,class,strong)NSString *appBuild;
@property(nonatomic,readonly,class,strong)NSString *appVersion;
@end
