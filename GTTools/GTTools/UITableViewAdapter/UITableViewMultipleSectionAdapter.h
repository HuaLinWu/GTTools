//
//  UITableViewMultipleSectionAdapter.h
//  AFNetworking
//
//  Created by 牟豪 on 2017/12/27.
//

#import <Foundation/Foundation.h>
#import "UITableViewAdapterDelegate.h"
#import "MJRefresh.h"
typedef NS_ENUM(NSInteger, RefreshType) {
    RefreshNone,              // 没有上下拉刷新
    RefreshOnlyHeader,     // 只有下拉刷新
    RefreshOnlyFooter,      // 只有上拉加载
    RefreshBoth               //  上拉刷新，下拉加载都有
};

typedef void(^RefreshHeaderBlock)(void);
typedef void(^RefreshFooterBlock)(void);

@class UITableViewAdapterDelegate,UITableViewSingleSctionBaseCelIItem;
@interface UITableViewMultipleSectionAdapter : NSObject<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,copy,readonly)NSArray*tableViewSectionItems;
@property(nonatomic,weak)id<UITableViewAdapterDelegate>delegate;

@property (nonatomic, strong) MJRefreshNormalHeader                 *refreshNormalHeader;
@property (nonatomic, strong) MJRefreshBackNormalFooter           *refreshNormalFooter;
@property (nonatomic, strong) MJRefreshGifHeader                       *refreshGIFHeader;
@property (nonatomic, strong) MJRefreshBackGifFooter                 *refreshGIFFooter;

- (void)addTableViewCellItems:(NSArray<NSArray<UITableViewSingleSctionBaseCelIItem *> *>*)cellItems;
- (void)insertTableViewCellItems:(NSArray<UITableViewSingleSctionBaseCelIItem *> *)cellItems startIndex:(NSUInteger)index section:(NSInteger)section;
- (void)removeTableViewCellItemsAtRanage:(NSRange )range section:(NSInteger)section;
- (void)clearTableViewCellItems;
- (void)moveTableViewCellItemAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)toIndexPath;


- (instancetype)initWithTableView:(UITableView *)tableView refreshType:(RefreshType)refreshType refreshHeaderBlock:(RefreshHeaderBlock)refreshHeaderBlock refreshFooterBlock:(RefreshFooterBlock)refreshFooterBlock;

- (instancetype)initWithGIFTableView:(UITableView *)tableView refreshType:(RefreshType)refreshType refreshHeaderBlock:(RefreshHeaderBlock)refreshHeaderBlock refreshFooterBlock:(RefreshFooterBlock)refreshFooterBlock;
@end
