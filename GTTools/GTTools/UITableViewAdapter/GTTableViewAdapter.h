//
//  GTTableViewAdapter.h
//  GTTools
//
//  Created by 吴华林 on 2018/8/22.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GTTableViewAdapterSectionItem.h"
@interface GTTableViewAdapter : NSObject
- (void)addSectionItem:(GTTableViewAdapterSectionItem *)sectionItem;
- (void)addSectionItems:(NSArray<GTTableViewAdapterSectionItem *> *)sectionItems;
@end
