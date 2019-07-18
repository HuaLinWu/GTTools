//
//  UIViewController+GTRouter.m
//  GTTools
//
//  Created by 吴华林 on 2019/2/21.
//  Copyright © 2019 吴华林. All rights reserved.
//

#import "UIViewController+GTRouter.h"

@implementation UIViewController (GTRouter)
+ (BOOL)validateTheAccessToOpenWithParameter:(NSDictionary *)parameter {
    return YES;
}
+ (void)handleNoAccessToOpenWithParameter:(NSDictionary *)parameter{
    
}
- (instancetype)initWithQuery:(NSDictionary *)parameter {
    self = [self init];
    
    return self;
}
- (void)acceptPopParams:(NSDictionary *)parameter {
    
}
- (void)routerRefresh {
    
}
@end
