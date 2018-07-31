//
//  UITableViewSingleSctionAdapter.m
//  UITableViewDemo
//
//  Created by 吴华林 on 2017/10/30.
//  Copyright © 2017年 吴华林. All rights reserved.
//

#import "UITableViewSingleSctionAdapter.h"
#import "UITableViewCellProtocol.h"
#import "UITableViewSingleSctionBaseCelIItem.h"
#import "UITableViewCell+GTTableViewAdapter.h"

@interface UITableViewSingleSctionAdapter()
@property(nonatomic,copy)NSArray*tableViewSectionItems;
@property(nonatomic, strong)NSMutableArray *sectionItems;
@property(nonatomic,copy)NSArray*tableViewCellItems;
@property(nonatomic, strong)NSMutableArray *cellItems;
@end
@implementation UITableViewSingleSctionAdapter
- (instancetype)initWithTableView:(UITableView *)tableView refreshType:(RefreshType)refreshType refreshHeaderBlock:(RefreshHeaderBlock)refreshHeaderBlock refreshFooterBlock:(RefreshFooterBlock)refreshFooterBlock
{
    self = [super init];
    if (self)
    {
        self.refreshNormalHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            if (refreshHeaderBlock)
            {
                refreshHeaderBlock();
            }
        }];
        self.refreshNormalFooter = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            if (refreshFooterBlock)
            {
                refreshFooterBlock();
            }
        }];
        switch (refreshType)
        {
            case RefreshNone:
                
                break;
            case RefreshOnlyHeader:
            {
                tableView.mj_header = self.refreshNormalHeader;
            }
                break;
            case RefreshOnlyFooter:
            {
                tableView.mj_footer =  self.refreshNormalFooter;
            }
                break;
            case RefreshBoth:
            {
                tableView.mj_header = self.refreshNormalHeader;
                tableView.mj_footer =  self.refreshNormalFooter;
            }
                break;
        }
    }
    return self;
}


- (instancetype)initWithGIFTableView:(UITableView *)tableView refreshType:(RefreshType)refreshType refreshHeaderBlock:(RefreshHeaderBlock)refreshHeaderBlock refreshFooterBlock:(RefreshFooterBlock)refreshFooterBlock
{
    self = [super init];
    if (self)
    {
        self.refreshGIFHeader = [MJRefreshGifHeader headerWithRefreshingBlock:^{
            if (refreshHeaderBlock)
            {
                refreshHeaderBlock();
            }
        }];
        
        self.refreshGIFFooter = [MJRefreshBackGifFooter footerWithRefreshingBlock:^{
            if (refreshFooterBlock)
            {
                refreshFooterBlock();
            }
        }];
        switch (refreshType)
        {
            case RefreshNone:
                
                break;
            case RefreshOnlyHeader:
            {
                tableView.mj_header = self.refreshGIFHeader;
            }
                break;
            case RefreshOnlyFooter:
            {
                tableView.mj_footer = self.refreshGIFFooter;
            }
                break;
            case RefreshBoth:
            {
                tableView.mj_header = self.refreshGIFHeader;
                tableView.mj_footer = self.refreshGIFFooter;
            }
                break;
        }
    }
    return self;
}
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewSingleSctionBaseCelIItem *cellItem = [self cellItemAtIndexPath:indexPath];
    UITableViewCell<UITableViewCellProtocol> *cell = [tableView dequeueReusableCellWithIdentifier:cellItem.cellReuseIdentifier];
    if(!cell) {
        cell = [[NSClassFromString(cellItem.cellClass) alloc] initCunstomWithStyle:cellItem.cellStyle lineStyle:cellItem.lineCellStyle topLineEdgeInsets:cellItem.topLineEdge bottomLineEdgeInsets:cellItem.bottomLineEdge topLineColor:cellItem.topLineColor bottomLineColor:cellItem.bottomLineColor reuseIdentifier:cellItem.cellReuseIdentifier];
    }
    cell.accessoryType = cellItem.cellAccesssoryType;
    cell.selectionStyle = cellItem.selectionStyle;
    [cell bindingData:cellItem.cellData];
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewSingleSctionBaseCelIItem *cellItem = [self cellItemAtIndexPath:indexPath];
    return cellItem.canEdit;
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewSingleSctionBaseCelIItem *cellItem = [self cellItemAtIndexPath:indexPath];
    return cellItem.canMove;
}
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewSingleSctionBaseCelIItem *cellItem = [self cellItemAtIndexPath:indexPath];
    if (cellItem.cellHeight == 0)
    {
        return UITableViewAutomaticDimension;
    }
    return cellItem.cellHeight;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewSingleSctionBaseCelIItem *cellItem = [self cellItemAtIndexPath:indexPath];
    return  cellItem.estimatedRowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([self.delegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)]) {
        return  [self.delegate tableView:tableView heightForHeaderInSection:section];
    }
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([self.delegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
        return  [self.delegate tableView:tableView viewForHeaderInSection:section];
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if ([self.delegate respondsToSelector:@selector(tableView:heightForFooterInSection:)]) {
        return  [self.delegate tableView:tableView heightForFooterInSection:section];
    }
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if ([self.delegate respondsToSelector:@selector(tableView:viewForFooterInSection:)]) {
        return  [self.delegate tableView:tableView viewForFooterInSection:section];
    }
    return nil;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewSingleSctionBaseCelIItem *cellItem = [self cellItemAtIndexPath:indexPath];
    return cellItem.cellEditingStyle;
}
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewSingleSctionBaseCelIItem *cellItem = [self cellItemAtIndexPath:indexPath];
    return cellItem.rowActions;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if([self.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:cellData:)]) {
        UITableViewSingleSctionBaseCelIItem *cellItem = [self cellItemAtIndexPath:indexPath];
        [self.delegate tableView:tableView didSelectRowAtIndexPath:indexPath cellData:cellItem.cellData];
    } else if([self.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}
#pragma mark public
- (void)addTableViewCellItems:(NSArray<UITableViewSingleSctionBaseCelIItem *> *)cellItems {
    if(cellItems && [cellItems isKindOfClass:[NSArray class]]) {
        [self.cellItems addObjectsFromArray:cellItems];
    }
}
- (void)insertTableViewCellItems:(NSArray<UITableViewSingleSctionBaseCelIItem *> *)cellItems startIndex:(NSUInteger)index {
    if(cellItems && [cellItems isKindOfClass:[NSArray class]]&&index<=self.cellItems.count) {
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(index, cellItems.count)];
        [self.cellItems insertObjects:cellItems atIndexes:indexSet];
    }
}
- (void)removeTableViewCellItemsAtRanage:(NSRange )range {
    NSRange tempRanage = range;
    if(range.location+range.length>self.cellItems.count) {
        tempRanage = NSMakeRange(range.location, self.cellItems.count-range.location);
    }
    [self.cellItems removeObjectsInRange:tempRanage];
}
- (void)clearTableViewCellItems {
    [self.cellItems removeAllObjects];
}
- (void)moveTableViewCellItemAtIndex:(NSUInteger)index toIndex:(NSUInteger)toIndex {
    if(index>=self.cellItems.count || toIndex>=self.cellItems.count) {
        return;
    }
    NSObject *object = self.cellItems[index];
    [self.cellItems removeObjectAtIndex:index];
    [self.cellItems insertObject:object atIndex:toIndex];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if([self.delegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.delegate scrollViewDidScroll:scrollView];
    }
}
#pragma mark private_method
- (UITableViewSingleSctionBaseCelIItem *)cellItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self.cellItems objectAtIndex:indexPath.row];
}
#pragma mark set/get
- (NSMutableArray *)cellItems {
    if(!_cellItems) {
        _cellItems = [[NSMutableArray alloc] init];
    }
    return _cellItems;
}
- (NSArray *)tableViewCellItems {
    return [_cellItems copy];
}

- (NSMutableArray *)sectionItems {
    if(!_sectionItems) {
        _sectionItems = [[NSMutableArray alloc] init];
    }
    return _sectionItems;
}
- (NSArray *)tableViewSectionItems {
    return [_sectionItems copy];
}

@end

