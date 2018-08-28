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
 用户自定义的额外参数，GTTableViewAdapter 不会调用
 */
@property(nonatomic, strong)id extraParameters;

/**
 在cell 未准备好时候，需要展示的cell(默认UITableViewCell)
 */
@property(nonatomic, copy)NSString *replaceCellClass;

/**
 默认为44
 */
@property(nonatomic, assign)CGFloat replaceRowHeight;
/**
 重新刷新(当所有必要信息准备好了以后调用本方法进行刷新cell)
 */
- (void)setNeedUpdate;
@end

//_______________________________________________________________________________________________________________
@interface GTTableViewAdapterSectionExtendViewItem :NSObject

/**
 view 的class
 */
@property(nonatomic,copy)NSString *viewClass;

/**
 view 的高度
 */
@property(nonatomic,assign)CGFloat height;

/**
 view 需要的数据
 */
@property(nonatomic,strong)id data;

/**
 view 重用标示
 */
@property(nonatomic,copy)NSString *reuseIdentifier;
/**
 在view 未准备好时候，需要展示的view(默认UIView)
 */
@property(nonatomic, copy)NSString *replaceViewClass;

/**
 默认为44
 */
@property(nonatomic, assign)CGFloat replaceViewHeight;
- (void)setNeedUpdate;
@end

//_______________________________________________________________________________________________________________
@interface GTTableViewAdapterSectionItem :NSObject
@property(nonatomic,copy,readonly)NSArray<GTTableViewAdapterCellItem *> *cellItems;
@property(nonatomic,copy,readonly)GTTableViewAdapterSectionExtendViewItem *headerItem;
@property(nonatomic,copy,readonly)GTTableViewAdapterSectionExtendViewItem *footerItem;
/**
 添加section header
 */
- (void)addSectionHeaderItem:(GTTableViewAdapterSectionExtendViewItem *)headerItem;

/**
 cell 处理
 */
- (void)addCellItem:(GTTableViewAdapterCellItem *)cellItem;
- (void)removeCellItem:(GTTableViewAdapterCellItem *)cellItem;
- (void)removeCellItemAtRow:(NSInteger)row;
- (void)insertCellItem:(GTTableViewAdapterCellItem *)cellItem atRow:(NSInteger)row;
- (void)replaceCellItemAtRow:(NSInteger)row withCellItem:(GTTableViewAdapterCellItem *)cellItem;

/**
 添加section footer
 */
- (void)addSectionFooterItem:(GTTableViewAdapterSectionExtendViewItem *)footerItem;
@end
