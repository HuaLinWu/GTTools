//
//  GTTableViewAdapter.h
//  GTTools
//
//  Created by 吴华林 on 2018/8/22.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GTTableViewAdapterSectionItem.h"
@class GTTableViewAdapter;
@protocol GTTableViewAdapterProtocol<NSObject>
@optional
- (void)adapter:(GTTableViewAdapter *)adapter didSelectRowAtIndexPath:(NSIndexPath *)indexPath didSelectRowData:(id)rowData;
- (void)adapter:(GTTableViewAdapter *)adapter didDeselectRowAtIndexPath:(NSIndexPath *)indexPath didSelectRowData:(id)rowData;
- (void)adapter:(GTTableViewAdapter *)adapter deleteRowAtIndexPath:(NSIndexPath *)indexPath deleteRowData:(id)data;
- (void)adapter:(GTTableViewAdapter *)adapter insertRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)adapter:(GTTableViewAdapter *)adapter moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath cellDataOfSourceIndexPath:(id)sourceCellData toIndexPath:(NSIndexPath *)destinationIndexPath  cellDataOfDestinationIndexPath:(id)destinationCellData;
@required

@end

@interface GTTableViewAdapter : NSObject<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak)id<GTTableViewAdapterProtocol>delegate;
- (void)addSectionItem:(GTTableViewAdapterSectionItem *)sectionItem;
- (void)addSectionItems:(NSArray<GTTableViewAdapterSectionItem *> *)sectionItems;
- (void)reload;
@end
