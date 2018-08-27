//
//  GTTableViewAdapterSectionItem.h
//  GTTools
//
//  Created by 吴华林 on 2018/8/23.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UITableView.h>
@interface GTTableViewAdapterCellItem : NSObject

/**
 cell 重用标示(默认和cellClass 相同)
 */
@property(nonatomic, copy)NSString *reuseIdentifier;

/**
 cell class 类名字符串
 */
@property(nonatomic, copy)NSString *cellClass;

/**
 cell 需要的数据
 */
@property(nonatomic, strong)id cellData;

/**
 cell 绑定数据的对象方法默认是@selector(bindData:)
 */
@property(nonatomic, assign)SEL cellBindDataSeletor;
/**
 cell 的行高，如果行高是固定的请用这个属性
 */
@property(nonatomic, assign)CGFloat rowHeight;
/**
 用户自定义计算行高，计算完成请给rowHeight赋值
 */
@property(nonatomic, copy)void(^calculateRowHeightBlock)(void);

/**
 用户自定义的额外参数，GTTableViewAdapter 不会调用
 */
@property(nonatomic, strong)id extraParameters;

/**
 会重新调用calculateRowHeight 来计算行高
 */
- (void)setNeedUpdateRowHeight;
@end

@interface GTTableViewAdapterSectionItem :NSObject
@property(nonatomic,copy)NSArray<GTTableViewAdapterCellItem *> *cellItems;
/**
 cell 处理
 */
- (void)addCellItem:(GTTableViewAdapterCellItem *)cellItem;
- (void)removeCellItem:(GTTableViewAdapterCellItem *)cellItem;
- (void)removeCellItemAtRow:(NSInteger)row;
- (void)insertCellItem:(GTTableViewAdapterCellItem *)cellItem atRow:(NSInteger)row;
- (void)replaceCellItemAtRow:(NSInteger)row withCellItem:(GTTableViewAdapterCellItem *)cellItem;
@end
