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
    }
    return self;
}
//MARK: public
- (void)setNeedUpdate {
    self.needUpdate = YES;
}
@end
//_______________________________________________________________________________________________________________
@interface GTTableViewAdapterSectionExtendViewItem()
@property(nonatomic,assign)BOOL needUpdate;
@end
@implementation GTTableViewAdapterSectionExtendViewItem
- (instancetype)init {
    self =[super init];
    if(self) {
        _replaceViewClass = @"UIView";
        _replaceViewHeight = 44;
    }
    return self;
}
//MARK: public
- (void)setNeedUpdate {
    self.needUpdate = YES;
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
    if(validCellItem && 0<=row && row<self.gtCellItems.count) {
         [self.gtCellItems insertObject:validCellItem atIndex:row];
    }
}
- (void)replaceCellItemAtRow:(NSInteger)row withCellItem:(GTTableViewAdapterCellItem *)cellItem {
    GTTableViewAdapterCellItem *validCellItem = [self getValidCellItem:cellItem];
    if(validCellItem && 0<=row && row<self.gtCellItems.count) {
        [self.gtCellItems replaceObjectAtIndex:row withObject:validCellItem];
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
    if(!cellItem.reuseIdentifier ||![cellItem.reuseIdentifier isKindOfClass:[NSString class]]|| cellItem.reuseIdentifier.length==0) {
        cellItem.reuseIdentifier = cellItem.cellClass;
    }
    if(!cellItem.cellBindDataSeletor) {
        cellItem.cellBindDataSeletor = NSSelectorFromString(@"bindData:");
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
