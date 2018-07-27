//
//  GTRouterViewControllerStacks.m
//  GTTools
//
//  Created by 吴华林 on 2018/7/9.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import "GTRouterViewControllerStack.h"
#import <UIKit/UIKit.h>
#import "Aspects.h"
#import "UIViewController+GTRouter.h"
@interface _GTRouterViewControllerNode :NSObject
@property(nonatomic,weak)_GTRouterViewControllerNode *preNode;
@property(nonatomic,weak)_GTRouterViewControllerNode *nextNode;
@property(nonatomic,weak)UIViewController *viewController;
@property(nonatomic,assign)Class viewControllerClass;
@property(nonatomic,strong)NSString *viewControllerIdentifier;
@property(nonatomic,assign)GTRouterShowType showType;
@end
@implementation _GTRouterViewControllerNode
+ (instancetype)createNodeWithViewController:(UIViewController *)viewController showType:(GTRouterShowType)showType {
    _GTRouterViewControllerNode *node = [[_GTRouterViewControllerNode alloc] init];
    node.viewController = viewController;
    node.showType = showType;
    return node;
}
@end
@interface _GTRouterViewControllerList :NSObject
@property(nonatomic,weak)_GTRouterViewControllerNode *headerNode;
@property(nonatomic,weak)_GTRouterViewControllerNode *footerNode;
@end
@implementation _GTRouterViewControllerList
- (void)insertNodeToHeader:(_GTRouterViewControllerNode *)node {
    if(!node) return;
    if(!self.headerNode) {
        self.headerNode = node;
        self.footerNode = node;
        node.preNode = nil;
    } else {
        self.headerNode.preNode = node;
        node.nextNode = self.headerNode;
        node.preNode = nil;
        self.headerNode = node;
    }
}
- (void)addNodeToFooter:(_GTRouterViewControllerNode *)node {
    if(!node) return;
    if(self.headerNode==nil) {
        self.headerNode = node;
        self.footerNode = node;
    } else {
        self.footerNode.nextNode = node;
        node.preNode = self.footerNode;
        node.nextNode = nil;
        self.footerNode = node;
    }
}
- (void)removeNode:(_GTRouterViewControllerNode *)node {
    if(!node) return;
    _GTRouterViewControllerNode *preNode = node.preNode;
    _GTRouterViewControllerNode *nextNode = node.nextNode;
    if(preNode) {
       preNode.nextNode = nextNode;
    }
    if(nextNode) {
        nextNode.preNode = preNode;
    }
}
- (void)removeAllNodeWithoutHeader {
    self.headerNode.nextNode = nil;
    self.footerNode = self.headerNode;
}
- (void)removeNodesToNode:(_GTRouterViewControllerNode *)node {
    if(node) {
        node.nextNode = nil;
    }
}
- (void)removeAllNodes {
    self.headerNode = nil;
    self.footerNode = nil;
}
- (_GTRouterViewControllerNode *)findNodeWithClass:(Class)class {
    return nil;
}
- (_GTRouterViewControllerNode *)findNodeWithIdentifier:(NSString *)identifier {
    return nil;
}
@end
/**
 */
@interface GTRouterViewControllerStack()
@property(nonatomic,strong)_GTRouterViewControllerList *currentList;
@end
@implementation GTRouterViewControllerStack
+ (void)load {
    [self aspectViewController];
    [self aspectNavigationController];
}
+ (instancetype)shareInstance {
    static GTRouterViewControllerStack *stack;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        stack = [[GTRouterViewControllerStack alloc] init];
    });
    return stack;
}
#pragma mark private_methods
+ (void)aspectWindow {
    [[UIWindow class] aspect_hookSelector:@selector(setRootViewController:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo>aspectInfo){
         _GTRouterViewControllerList *currentList = [GTRouterViewControllerStack shareInstance].currentList;
        [currentList removeAllNodes];
        NSArray *arguments = [aspectInfo arguments];
        if(arguments.count >0) {
           
            UIViewController *rootViewController = arguments[0];
           
        }
    } error:nil];
}
+ (void)aspectNavigationController {
    //pushViewController
    [[UINavigationController class] aspect_hookSelector:@selector(pushViewController:animated:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo>aspectInfo){
         NSArray *arguments = [aspectInfo arguments];
//        if()
        
    } error:nil];
    //popViewController
    [[UINavigationController class] aspect_hookSelector:@selector(popViewControllerAnimated:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo>aspectInfo){
        
    } error:nil];
    //popToViewController
    [[UINavigationController class] aspect_hookSelector:@selector(popToViewController:animated:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo>aspectInfo){
        
    } error:nil];
    //popToRootViewController
    [[UINavigationController class] aspect_hookSelector:@selector(popToRootViewControllerAnimated:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo>aspectInfo){
        
    } error:nil];
}
+ (void)aspectViewController {
    //presentViewController
    [[UIViewController class] aspect_hookSelector:@selector(presentViewController:animated:completion:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo>aspectInfo){
        
    } error:nil];
    //dismissViewControllerAnimated
    [[UIViewController class] aspect_hookSelector:@selector(dismissViewControllerAnimated:completion:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo>aspectInfo){
        
    } error:nil];
    /**
     支持老版本
    */
    //presentModalViewController
    [[UIViewController class] aspect_hookSelector:@selector(presentModalViewController:animated:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo>aspectInfo){
        
    } error:nil];
    //dismissModalViewController
    [[UIViewController class] aspect_hookSelector:@selector(dismissModalViewControllerAnimated:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo>aspectInfo){
        
    } error:nil];
    
    
}

#pragma mark set/get
- (_GTRouterViewControllerList *)currentList {
    if(!_currentList) {
         _currentList = [[_GTRouterViewControllerList alloc] init];
    }
    return _currentList;
}
@end
