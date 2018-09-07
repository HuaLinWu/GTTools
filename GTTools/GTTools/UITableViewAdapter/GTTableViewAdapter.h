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

/**
 当cell 被选中的时候，指定代理方法会被执行

 @param adapter  对应的adapter
 @param indexPath cell所在的indexPath
 @param rowData cell 绑定的数据
 */
- (void)adapter:(GTTableViewAdapter *)adapter didSelectRowAtIndexPath:(NSIndexPath *)indexPath didSelectRowData:(id)rowData;

/**
 当cell 取消选中的时候本方法会被执行

 @param adapter 对应的adapter
 @param indexPath cell所在的indexPath
 @param rowData cell 绑定的数据
 */
- (void)adapter:(GTTableViewAdapter *)adapter didDeselectRowAtIndexPath:(NSIndexPath *)indexPath didSelectRowData:(id)rowData;

/**
 当cell 被删除以后会触发本方法（对应- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath 的UITableViewCellEditingStyleDelete行为，adater 已经做了tableview cell 删除操作，只需要做业务相关逻辑，不需要重复做cell 删除逻辑）

 @param adapter 对应的adapter
 @param indexPath cell所在的indexPath
 @param data cell 绑定的数据
 */
- (void)adapter:(GTTableViewAdapter *)adapter deleteRowAtIndexPath:(NSIndexPath *)indexPath deleteRowData:(id)data;

/**
 插入cell 会触发本方法（对应- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath 的UITableViewCellEditingStyleDelete行为UITableViewCellEditingStyleInsert，adapter 没有执行任何UItableview 插入cell 任何逻辑）

 @param adapter 对应的adapter
 @param indexPath indexPath
 */
- (void)adapter:(GTTableViewAdapter *)adapter insertRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 当cell 被移动时候会触发本方法（adapter 已经处理了UITableiViewCell 视图相关逻辑，代理方只需实现业务逻辑就可以）

 @param adapter 对应的adapter
 @param sourceIndexPath 源cell所在的IndexPath
 @param sourceCellData 源cell绑定的数据源
 @param destinationIndexPath 目标IndexPath
 @param destinationCellData 目标IndexPath 目前cell 绑定的数据
 */
- (void)adapter:(GTTableViewAdapter *)adapter moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath cellDataOfSourceIndexPath:(id)sourceCellData toIndexPath:(NSIndexPath *)destinationIndexPath  cellDataOfDestinationIndexPath:(id)destinationCellData;
@required

@end

@interface GTTableViewAdapter : NSObject<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak)id<GTTableViewAdapterProtocol>delegate;

/**
 添加sectionItem 到Adapter 数组里面

 @param sectionItem 需要添加SectionItem 数据源构造对应UITableView 的UITableViewSection的构造
 */
- (void)addSectionItem:(GTTableViewAdapterSectionItem *)sectionItem;

/**
 添加多个sectionItem

 @param sectionItems 多个GTTableViewAdapterSectionItem 的数组
 */
- (void)addSectionItems:(NSArray<GTTableViewAdapterSectionItem *> *)sectionItems;

/**
 刷新对应的section （里面会执行UITableView 的reloadSection的方法）

 @param section 需要刷新的section
 @param rowAnimation 动画
 */
- (void)reloadSection:(NSInteger)section withRowAnimation:(UITableViewRowAnimation)rowAnimation;

/**
 刷新多行（里面会执行UITableView 的reloadRows的方法）

 @param indexPaths 需要刷新的rowIndexPaths 数组
 @param rowAnimation 动画
 */
- (void)reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)rowAnimation;

/**
 刷新多行在同一个section里面的（里面会执行UITableView 的reloadRows的方法）

 @param rows 需要刷新的row 的数组
 @param section 所有的row 所在的section
 @param rowAnimation 动画
 */
- (void)reloadRows:(NSArray<NSNumber *> *)rows inSection:(NSInteger)section withRowAnimation:(UITableViewRowAnimation)rowAnimation;

/**
 刷新整个tableView
 */
- (void)reload;
@end
