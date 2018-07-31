//
//  UITableViewMultipleSectionAdapter.m
//  AFNetworking
//
//  Created by 牟豪 on 2017/12/27.
//

#import "UITableViewMultipleSectionAdapter.h"
#import "UITableViewCellProtocol.h"
#import "UITableViewSingleSctionBaseCelIItem.h"
#import "UITableViewCell+GTTableViewAdapter.h"

@interface UITableViewMultipleSectionAdapter()
@property(nonatomic,copy)NSArray*tableViewSectionItems;
@property(nonatomic, strong)NSMutableArray *sectionItems;
@end

@implementation UITableViewMultipleSectionAdapter
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.tableViewSectionItems.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.delegate respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
        return [self.delegate tableView:tableView numberOfRowsInSection:section];
    }
    NSArray *cellItems = self.tableViewSectionItems[section];
    return cellItems.count;
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

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if ([self.delegate respondsToSelector:@selector(sectionIndexTitlesForTableView:)]) {
        return  [self.delegate sectionIndexTitlesForTableView:tableView];
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(tableView: sectionForSectionIndexTitle: atIndex:)]) {
        return  [self.delegate tableView:tableView sectionForSectionIndexTitle:title atIndex:index];
    }
    return index;
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
- (void)addTableViewCellItems:(NSArray<NSArray<UITableViewSingleSctionBaseCelIItem *> *>*)cellItems {
    if(cellItems && [cellItems isKindOfClass:[NSArray class]]) {
        [self.sectionItems addObjectsFromArray:cellItems];
    }
}
- (void)insertTableViewCellItems:(NSArray<UITableViewSingleSctionBaseCelIItem *> *)cellItems startIndex:(NSUInteger)index section:(NSInteger)section{
    NSMutableArray *tempCellItems = self.sectionItems[section];
    if(cellItems && [cellItems isKindOfClass:[NSArray class]]&&index<=tempCellItems.count) {
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(index, cellItems.count)];
        [tempCellItems insertObjects:cellItems atIndexes:indexSet];
    }
}

- (void)removeTableViewCellItemsAtRanage:(NSRange )range section:(NSInteger)section{
    NSMutableArray *tempCellItems = self.sectionItems[section];
    NSRange tempRanage = range;
    if(range.location+range.length>tempCellItems.count) {
        tempRanage = NSMakeRange(range.location, tempCellItems.count-range.location);
    }
    [tempCellItems removeObjectsInRange:tempRanage];
}
- (void)clearTableViewCellItems {
    [self.sectionItems removeAllObjects];
}
- (void)moveTableViewCellItemAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    if(indexPath.section>=self.sectionItems.count || toIndexPath>=self.sectionItems.count) {
        return;
    }
    NSObject *object = [NSIndexPath indexPathForItem:indexPath.item inSection:indexPath.section];
    [self.sectionItems removeObjectsAtIndexes:[NSIndexPath indexPathForItem:indexPath.item inSection:indexPath.section]];
    [self.sectionItems insertObject:object atIndex:[NSIndexPath indexPathForItem:toIndexPath.item inSection:toIndexPath.section]];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if([self.delegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.delegate scrollViewDidScroll:scrollView];
    }
}
#pragma mark private_method
- (UITableViewSingleSctionBaseCelIItem *)cellItemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *cellItems = self.tableViewSectionItems[indexPath.section];
    return [cellItems objectAtIndex:indexPath.row];
}
#pragma mark set/get

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

