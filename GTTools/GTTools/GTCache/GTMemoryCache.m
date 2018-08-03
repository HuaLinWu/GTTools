//
//  GTMemoryCache.m
//  GTTools
//
//  Created by 吴华林 on 2018/6/21.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import "GTMemoryCache.h"
@interface _GTMemoryMapNode : NSObject

@property(nonatomic,weak)_GTMemoryMapNode *preNode;
@property(nonatomic,weak)_GTMemoryMapNode *nextNode;
@property(nonatomic,strong)id data;
@property(nonatomic,strong)id key;
@end
@implementation _GTMemoryMapNode
+ (instancetype)instanceWithData:(id)data key:(id)key {
    _GTMemoryMapNode *node = [[_GTMemoryMapNode alloc] init];
    if(node) {
        node.data = data;
        node.key = key;
    }
    return node;
}
@end
@interface _GTMemoryMap :NSObject
@property(nonatomic,weak)_GTMemoryMapNode *headNode;
@property(nonatomic,weak)_GTMemoryMapNode *footNode;
@property(nonatomic,assign)CFMutableDictionaryRef mapDict;
@end
@implementation _GTMemoryMap
- (_GTMemoryMapNode *)nodeForKey:(id)key {
    if(!key) {
        return nil;
    } else {
        _GTMemoryMapNode *node =CFDictionaryGetValue(self.mapDict, (__bridge const void *)(key));
        return node;
    }
}
- (BOOL)containsNode:(_GTMemoryMapNode *)node {
    if(!node) {
        return NO;
    } else {
        return CFDictionaryContainsValue(self.mapDict, (__bridge const void *)(node));
    }
}
- (void)addNewHeadNode:(_GTMemoryMapNode *)node {
    if(!node) {
        return;
    } else if(!self.headNode) {
        self.headNode = node;
        self.footNode = node;
        CFDictionaryAddValue(self.mapDict, (__bridge const void *)(node.key),(__bridge const void *)(node));
    } else {
        self.headNode.preNode = node;
        node.nextNode = self.headNode;
        node.preNode = nil;
        self.headNode = node;
        CFDictionaryAddValue(self.mapDict, (__bridge const void *)(node.key), (__bridge const void *)(node));
    }
   
}
- (void)moveExistedNodeToHead:(_GTMemoryMapNode *)node {
    //先移除
    if(self.footNode == node) {
        _GTMemoryMapNode *preNode = node.preNode;
        preNode.nextNode = nil;
        node.preNode = nil;
        self.footNode = preNode;
    } else {
        _GTMemoryMapNode *preNode = node.preNode;
        _GTMemoryMapNode *nextNode = node.nextNode;
        preNode.nextNode = nil;
        preNode.nextNode = nextNode;
        nextNode.preNode = nil;
        nextNode.preNode = preNode;
        node.preNode = nil;
        node.nextNode = nil;
    }
    //再将node 添加到头部
    self.headNode.preNode = node;
    node.nextNode = self.headNode;
    self.headNode = node;
}
#pragma mark set/get
- (CFMutableDictionaryRef)mapDict {
    if(!_mapDict) {
        _mapDict = CFDictionaryCreateMutable(kCFAllocatorDefault, 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    }
    return _mapDict;
}
- (void)dealloc {
    if(_mapDict) {
        CFDictionaryRemoveAllValues(_mapDict);
        CFRelease(_mapDict);
    }
}
@end
@interface GTMemoryCache()
@property(nonatomic,strong)_GTMemoryMap *map;
@end
@implementation GTMemoryCache
- (void)setObject:(id)anObject forKey:(NSString *)aKey {
    if(!anObject || !aKey) {
        return;
    } else {
        _GTMemoryMapNode *node = [_GTMemoryMapNode instanceWithData:anObject key:aKey];
        [self.map addNewHeadNode:node];
    }
}
- (id)objectForKey:(id)key {
    if(!key) {
        return nil;
    } else {
       _GTMemoryMapNode *node = [self.map nodeForKey:key];
        if(!node) {
            return nil;
        } else {
            [self.map moveExistedNodeToHead:node];
          return node.data;
        }
    }
    return nil;
}
- (BOOL)containObjectForKey:(id)key {
    _GTMemoryMapNode *node = [self.map nodeForKey:key];
    if(!node) {
        return NO;
    } else {
        return YES;
    }
}
- (void)removeObjectForKey:(NSString *)key {
    
}
#pragma mark set/get
- (_GTMemoryMap *)map {
    if(!_map) {
        _map = [[_GTMemoryMap alloc] init];
    }
    return _map;
}
@end





