//
//  UITableViewSingleSctionAdapter.h
//  UITableViewDemo
//
//  Created by 吴华林 on 2017/10/30.
//  Copyright © 2017年 吴华林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UITableViewAdapterDelegate.h"
#import "UITableViewMultipleSectionAdapter.h"
#import "MJRefresh.h"

@class UITableViewAdapterDelegate,UITableViewSingleSctionBaseCelIItem;
@interface UITableViewSingleSctionAdapter : NSObject<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,copy,readonly)NSArray *tableViewCellItems;
@property(nonatomic,weak)id<UITableViewAdapterDelegate>delegate;
@property (nonatomic, strong) MJRefreshNormalHeader                 *refreshNormalHeader;
@property (nonatomic, strong) MJRefreshBackNormalFooter           *refreshNormalFooter;
@property (nonatomic, strong) MJRefreshGifHeader                       *refreshGIFHeader;
@property (nonatomic, strong) MJRefreshBackGifFooter                 *refreshGIFFooter;

- (void)addTableViewCellItems:(NSArray<UITableViewSingleSctionBaseCelIItem *> *)cellItems;
- (void)insertTableViewCellItems:(NSArray<UITableViewSingleSctionBaseCelIItem *> *)cellItems startIndex:(NSUInteger)index;
- (void)removeTableViewCellItemsAtRanage:(NSRange )range;
- (void)clearTableViewCellItems;
- (void)moveTableViewCellItemAtIndex:(NSUInteger)index toIndex:(NSUInteger)toIndex;

- (instancetype)initWithTableView:(UITableView *)tableView refreshType:(RefreshType)refreshType refreshHeaderBlock:(RefreshHeaderBlock)refreshHeaderBlock refreshFooterBlock:(RefreshFooterBlock)refreshFooterBlock;

- (instancetype)initWithGIFTableView:(UITableView *)tableView refreshType:(RefreshType)refreshType refreshHeaderBlock:(RefreshHeaderBlock)refreshHeaderBlock refreshFooterBlock:(RefreshFooterBlock)refreshFooterBlock;
@end
