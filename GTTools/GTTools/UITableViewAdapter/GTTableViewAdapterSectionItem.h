//
//  GTTableViewAdapterSectionItem.h
//  GTTools
//
//  Created by 吴华林 on 2018/8/23.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UITableView.h>
#import <UIKit/UIMenuController.h>
@interface GTTableViewAdapterCellItem : NSObject
/**
 cell 重用标示(默认和cellClass 相同)
 */
@property(nonatomic, copy)NSString *reuseIdentifier;

/**
 cell class 类名字符串
 */
@property(nonatomic, copy,nonnull)NSString *cellClass;
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
 cell的accessoryType
 */
@property(nonatomic, assign)UITableViewCellAccessoryType accessoryType;

/**
 选中的时候是否需要高亮 YES,表示高亮，NO表示不高亮（默认YES）
 */
@property(nonatomic, assign)BOOL shouldHighlight;

/**
 cell背景色（16进制的）
 */
@property(nonatomic, strong)NSString *cellBackgroudColor;

/**
  cell高亮时候的背景的色（16进制的）
 */
@property(nonatomic, strong)NSString *cellHighlightBackgroudColor;

/**
 cell是否可编辑（YES 表示可以编辑，NO表示不可以编辑）
 */
@property(nonatomic, assign) BOOL cellCanEdit;
    
/**
 cell是否可以移动(YES 表示可以移动，NO表示不可以移动)
 */
@property(nonatomic,assign)BOOL cellCanMove;
    
/**
 长按是否会出现menu (YES 表示会出现，NO表示不会出现，默认为NO)
 */
@property(nonatomic,assign)BOOL needShowMenu;

/**
 长按钮显示的menu的menuItem
 */
@property(nonatomic,copy)NSArray<UIMenuItem *> *menuItems;
/**
 cell编辑样式默认是UITableViewCellEditingStyleNone
 */
@property(nonatomic,assign)UITableViewCellEditingStyle cellEditingStyle;
    
/**
 cell 侧滑出来的按钮数组
 */
@property(nonatomic,copy)NSArray<UITableViewRowAction *> *cellActions;
    
/**
 cell 分割线左边距
 */
@property(nonatomic, assign)CGFloat separatorLeftMargin;
    
/**
 cell 分割线右边距
 */
@property(nonatomic, assign)CGFloat separatorRightMargin;
    
/**
 是否隐藏分割线（默认为NO，设置为YES时候会隐藏分割线）
 */
@property(nonatomic, assign)BOOL hideSeparator;
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
 cell 绑定数据的对象方法默认是@selector(bindData:)
 */
@property(nonatomic, assign)SEL bindDataSeletor;
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
- (GTTableViewAdapterCellItem *)cellItemAtRow:(NSInteger)row;
/**
 添加section footer
 */
- (void)addSectionFooterItem:(GTTableViewAdapterSectionExtendViewItem *)footerItem;
@end
