//
//  UIViewControllerRouteProtocol.h
//  GeekRoute
//  本协议主要是来约束通过路由跳转的视图
//  Created by 吴华林 on 2017/11/2.
//

#import <Foundation/Foundation.h>

@protocol UIViewControllerRouteProtocol <NSObject>
@optional
- (instancetype)initWithQuery:(id)parameter;
@end
