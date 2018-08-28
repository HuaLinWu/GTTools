//
//  GTTableViewAdapterDemoVM.h
//  GTToolsUI
//
//  Created by 吴华林 on 2018/8/28.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GTTools/GTTools.h>
@interface GTTableViewAdapterDemoVM : NSObject
@property(nonatomic,strong,readonly)GTTableViewAdapter *adapter;
- (void)fetchData;
@end
