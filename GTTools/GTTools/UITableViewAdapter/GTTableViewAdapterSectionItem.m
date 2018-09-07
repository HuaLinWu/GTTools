//
//  GTTableViewAdapterSectionItem.m
//  GTTools
//
//  Created by 吴华林 on 2018/8/23.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import "GTTableViewAdapterSectionItem.h"
#import <objc/runtime.h>
@interface GTTableViewAdapterCellItem()
@property(nonatomic,assign)BOOL needUpdate;
@end
@implementation GTTableViewAdapterCellItem
- (instancetype)init {
    self =[super init];
    if(self) {
        _replaceCellClass = @"UITableViewCell";
        _replaceRowHeight = 44;
        _cellBindDataSeletor = NSSelectorFromString(@"bindData:");
        _shouldHighlight = YES;
    }
    return self;
}
//MARK: public
- (void)setNeedUpdate {
    self.needUpdate = YES;
}
- (void)setCellClass:(NSString *)cellClass {
    if(!_reuseIdentifier || _reuseIdentifier.length ==0) {
        _reuseIdentifier = cellClass;
    }
    _cellClass = cellClass;
}
@end
//_______________________________________________________________________________________________________________
@implementation GTTableViewAdapterSectionExtendViewItem
- (instancetype)init {
    self = [super init];
    if(self) {
        _bindDataSeletor = NSSelectorFromString(@"bindData:");
    }
    return self;
}
- (void)setViewClass:(NSString *)viewClass {
    if(!_reuseIdentifier || _reuseIdentifier.length ==0) {
        _reuseIdentifier = viewClass;
    }
    _viewClass = viewClass;
}
@end
//_______________________________________________________________________________________________________________
@interface GTTableViewAdapterSectionItem()
@property(nonatomic, strong)NSMutableArray *gtCellItems;
@property(nonatomic,copy)GTTableViewAdapterSectionExtendViewItem *headerItem;
@property(nonatomic,copy)GTTableViewAdapterSectionExtendViewItem *footerItem;
@end
@implementation GTTableViewAdapterSectionItem
- (void)addSectionHeaderItem:(GTTableViewAdapterSectionExtendViewItem *)headerItem {
    self.headerItem = headerItem;
}
- (void)addCellItem:(GTTableViewAdapterCellItem *)cellItem {
    GTTableViewAdapterCellItem *validCellItem = [self getValidCellItem:cellItem];
    if(validCellItem) {
        [self.gtCellItems addObject:validCellItem];
    }
}
- (void)removeCellItem:(GTTableViewAdapterCellItem *)cellItem {
    if(cellItem) {
        [self.gtCellItems removeObject:cellItem];
    }
   
}
- (void)removeCellItemAtRow:(NSInteger)row {
    if(0<=row && row<self.gtCellItems.count) {
        [self.gtCellItems removeObjectAtIndex:row];
    }
}
- (void)insertCellItem:(GTTableViewAdapterCellItem *)cellItem atRow:(NSInteger)row {
    
     GTTableViewAdapterCellItem *validCellItem = [self getValidCellItem:cellItem];
    if(validCellItem && 0<=row) {
         [self.gtCellItems insertObject:validCellItem atIndex:row];
    }
}
- (void)replaceCellItemAtRow:(NSInteger)row withCellItem:(GTTableViewAdapterCellItem *)cellItem {
    GTTableViewAdapterCellItem *validCellItem = [self getValidCellItem:cellItem];
    if(validCellItem && 0<=row && row<self.gtCellItems.count) {
        [self.gtCellItems replaceObjectAtIndex:row withObject:validCellItem];
    }
}
- (GTTableViewAdapterCellItem *)cellItemAtRow:(NSInteger)row {
    if(row<self.gtCellItems.count) {
        return self.gtCellItems[row];
    } else {
        return nil;
    }
}
- (void)addSectionFooterItem:(GTTableViewAdapterSectionExtendViewItem *)footerItem {
    self.footerItem = footerItem;
}
#pragma mark set/get
- (GTTableViewAdapterCellItem *)getValidCellItem:(GTTableViewAdapterCellItem *)cellItem {
    if(!cellItem.cellClass ||![cellItem.cellClass isKindOfClass:[NSString class]] || !NSClassFromString(cellItem.cellClass)) {
#ifdef DEBUG
        NSString *messgae = [NSString stringWithFormat:@"%@的cellClass不存在",cellItem];
        NSAssert(0,messgae);
#endif
        return nil;
    }
    return cellItem;
}
- (NSArray<GTTableViewAdapterCellItem *> *)cellItems {
    return [self.gtCellItems copy];
}
- (NSMutableArray *)gtCellItems {
    if(!_gtCellItems){
        _gtCellItems = [[NSMutableArray alloc] init];
    }
    return _gtCellItems;
}
@end
