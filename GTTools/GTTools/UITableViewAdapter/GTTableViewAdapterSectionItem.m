//
//  GTTableViewAdapterSectionItem.m
//  GTTools
//
//  Created by 吴华林 on 2018/8/23.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import "GTTableViewAdapterSectionItem.h"

/**
 cell高度计算枚举
 */
NS_ENUM(NSUInteger,_GTRowStatus) {
    GTEndCalculate,//计算结束
    GTBeginCalculate,//开始计算
    GTCalculateing//正在计算中
};
@interface GTTableViewAdapterCellItem()
@property(nonatomic,assign) enum _GTRowStatus rowHeightCalculateStatus;
@end
@implementation GTTableViewAdapterCellItem
- (instancetype)init {
    self = [super init];
    if(self) {
        [self addObserver:self forKeyPath:@"rowHeight" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}
//MARK: public
- (void)setNeedUpdateRowHeight {
    if(self.calculateRowHeightBlock) {
        self.rowHeightCalculateStatus = GTBeginCalculate;
        self.calculateRowHeightBlock();
    }
}
//MARK:Observer
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
}
@end
@interface GTTableViewAdapterSectionItem()
@property(nonatomic, strong)NSMutableArray *gtCellItems;
@end
@implementation GTTableViewAdapterSectionItem

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
#pragma mark set/get
- (GTTableViewAdapterCellItem *)getValidCellItem:(GTTableViewAdapterCellItem *)cellItem {
    if(!cellItem.cellClass ||![cellItem.cellClass isKindOfClass:[NSString class]] || !NSClassFromString(cellItem.cellClass)) {
#ifdef DEBUG
        NSString *messgae = [NSString stringWithFormat:@"%@的cellClass不存在",cellItem];
        NSAssert(1,messgae);
#endif
        return nil;
    } else if (![NSClassFromString(cellItem.cellClass) isKindOfClass:[UITableViewCell class]]) {
#ifdef DEBUG
        NSString *messgae = [NSString stringWithFormat:@"%@的cellClass 不是UITableViewCell 的子类",cellItem];
        NSAssert(1,messgae);
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
    if(!_cellItems){
        _cellItems = [self.gtCellItems copy];
    }
    return _cellItems;
}
- (NSMutableArray *)gtCellItems {
    if(!_gtCellItems){
        _gtCellItems = [[NSMutableArray alloc] init];
    }
    return _gtCellItems;
}
@end
