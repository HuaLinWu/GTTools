//
//  GTTableViewAdapter.m
//  GTTools
//
//  Created by 吴华林 on 2018/8/22.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import "GTTableViewAdapter.h"
#import <UIKit/UIKit.h>
#import <UIKit/UIApplication.h>
#import <objc/runtime.h>
@interface GTTableViewAdapter()
@property(nonatomic,strong)NSMutableArray *sectionItems;
@property(nonatomic,weak)UITableView *tableview;
@end
@implementation GTTableViewAdapter
#pragma mark public_methods
- (void)addSectionItem:(GTTableViewAdapterSectionItem *)sectionItem {
    if(sectionItem) {
        [self.sectionItems addObject:sectionItem];
    }
}
- (void)addSectionItems:(NSArray<GTTableViewAdapterSectionItem *> *)sectionItems {
    if(sectionItems && sectionItems.count >0) {
        [self.sectionItems addObjectsFromArray:sectionItems];
    }
}
- (void)reload {
    dispatch_async(dispatch_get_main_queue(), ^{
         [self.tableview reloadData];
    });
}
#pragma mark observe
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if([keyPath isEqualToString:@"needUpdate"] && [object isKindOfClass:[GTTableViewAdapterCellItem class]]) {
        GTTableViewAdapterCellItem *item = (GTTableViewAdapterCellItem *)object;
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%@",[NSRunLoop currentRunLoop].currentMode);
             if ([NSRunLoop currentRunLoop].currentMode ==(NSRunLoopMode)kCFRunLoopDefaultMode) {
                //在默认
                 NSArray<NSIndexPath *> *indexPaths = [self.tableview indexPathsForVisibleRows];
                 for(NSIndexPath *indexPath in indexPaths) {
                     GTTableViewAdapterCellItem *cellItem = cellItemAtIndexPath(self.sectionItems, indexPath);
                     if(cellItem == item) {
                         [self.tableview reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                         break;
                     }
                 }
            }
        });
    }
}
#pragma mark UITableViewDelegate
// Display customization

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    GTTableViewAdapterCellItem *cellItem = cellItemAtIndexPath(self.sectionItems, indexPath);
    [cellItem addObserver:self forKeyPath:@"needUpdate" options:NSKeyValueObservingOptionNew context:nil];
}
//- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0);
//- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0);
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath {
    GTTableViewAdapterCellItem *cellItem = cellItemAtIndexPath(self.sectionItems, indexPath);
    if(cellItem.observationInfo) {
         [cellItem removeObserver:self forKeyPath:@"needUpdate"];
    }
   
}
//- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0);
//- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0);

// Variable height support

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    GTTableViewAdapterCellItem *cellItem = cellItemAtIndexPath(self.sectionItems, indexPath);
    if(![[cellItem valueForKey:@"needUpdate"] boolValue]) {
        //cell未准备就绪
        return cellItem.replaceRowHeight;
    } else {
        //cell准备就绪了
        return cellItem.rowHeight;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    GTTableViewAdapterSectionExtendViewItem *headerItem = sectionItemAtSection(self.sectionItems, section).headerItem;
    if(headerItem) {
        return headerItem.height;
    } else {
        return 0;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    GTTableViewAdapterSectionExtendViewItem *footerItem = sectionItemAtSection(self.sectionItems, section).footerItem;
    if(footerItem) {
        return footerItem.height;
    } else {
        return 0;
    }
}


// Section header & footer information. Views are preferred over title should you decide to provide both

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    GTTableViewAdapterSectionExtendViewItem *headerItem = sectionItemAtSection(self.sectionItems, section).headerItem;
    if(headerItem) {
        UIView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerItem.reuseIdentifier];
        if(!headerView){
            headerView = [[NSClassFromString(headerItem.viewClass) alloc] init];
        }
        if([headerView respondsToSelector:headerItem.bindDataSeletor]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [headerView performSelector:headerItem.bindDataSeletor withObject:headerItem.data];
#pragma clang diagnostic pop
        }
        return headerView;
    }
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    GTTableViewAdapterSectionExtendViewItem *footerItem = sectionItemAtSection(self.sectionItems, section).footerItem;
    if(footerItem) {
        UIView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footerItem.reuseIdentifier];
        if(!footerView){
            footerView = [[NSClassFromString(footerItem.viewClass) alloc] init];
        }
        if([footerView respondsToSelector:footerItem.bindDataSeletor]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
             [footerView performSelector:footerItem.bindDataSeletor withObject:footerItem.data];
#pragma clang diagnostic pop
        }
       
        return footerView;
    }
    return nil;
}

//// Accessories (disclosures).
//- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath;
//
//// Selection
//
//// -tableView:shouldHighlightRowAtIndexPath: is called when a touch comes down on a row.
// Returning NO to that message halts the selection process and does not cause the currently selected row to lose its selected look while the touch is down.
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    GTTableViewAdapterCellItem *cellItem = cellItemAtIndexPath(self.sectionItems, indexPath);
    if(!cellIsReadyAtIndexPath(self.sectionItems, indexPath)) {
        //cell未准备就绪
        return NO;
    } else {
        //准备就绪
        return cellItem.shouldHighlight;
    }
  
}
- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    
     GTTableViewAdapterCellItem *cellItem = cellItemAtIndexPath(self.sectionItems, indexPath);
    if(cellIsReadyAtIndexPath(self.sectionItems, indexPath)) {
        if(cellItem.cellBackgroudColor){
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            if(cell.backgroundView && !cell.backgroundView.hidden) {
                cell.backgroundView.backgroundColor = [self gt_colorWithHexString:cellItem.cellHighlightBackgroudColor];
            }
        }
    }
}
- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    GTTableViewAdapterCellItem *cellItem = cellItemAtIndexPath(self.sectionItems, indexPath);
    if(cellIsReadyAtIndexPath(self.sectionItems, indexPath)) {
        if(cellItem.cellBackgroudColor){
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            if(cell.backgroundView && !cell.backgroundView.hidden) {
                cell.backgroundView.backgroundColor = [self gt_colorWithHexString:cellItem.cellBackgroudColor];
            }
        }
    }
}
//
//// Called before the user changes the selection. Return a new indexPath, or nil, to change the proposed selection.
//- (nullable NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath;
//- (nullable NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0);
//// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GTTableViewAdapterCellItem *cellItem = cellItemAtIndexPath(self.sectionItems, indexPath);
    if(![[cellItem valueForKey:@"needUpdate"] boolValue]) {
        //cell未准备就绪
        return;
    } else {
        //准备就绪
        if(self.delegate && [self.delegate respondsToSelector:@selector(adapter:didSelectRowAtIndexPath:didSelectRowData:)]) {
            [self.delegate adapter:self didSelectRowAtIndexPath:indexPath didSelectRowData:cellItem.cellData];
        }
    }
    
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    GTTableViewAdapterCellItem *cellItem = cellItemAtIndexPath(self.sectionItems, indexPath);
    if(![[cellItem valueForKey:@"needUpdate"] boolValue]) {
        //cell未准备就绪
        return;
    } else {
        //cell准备就绪
        if(self.delegate && [self.delegate respondsToSelector:@selector(adapter:didDeselectRowAtIndexPath:didSelectRowData:)]) {
            [self.delegate adapter:self didDeselectRowAtIndexPath:indexPath didSelectRowData:cellItem.cellData];
        }
    }
    
}
//
//// Editing
//
//// Allows customization of the editingStyle for a particular cell located at 'indexPath'. If not implemented, all editable cells will have UITableViewCellEditingStyleDelete set for them when the table has editing property set to YES.
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(cellIsReadyAtIndexPath(self.sectionItems, indexPath)) {
         GTTableViewAdapterCellItem *cellItem = cellItemAtIndexPath(self.sectionItems, indexPath);
        return cellItem.cellEditingStyle;
    }
    return UITableViewCellEditingStyleNone;
}
//- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0) __TVOS_PROHIBITED;
//
//// Use -tableView:trailingSwipeActionsConfigurationForRowAtIndexPath: instead of this method, which will be deprecated in a future release.
//// This method supersedes -tableView:titleForDeleteConfirmationButtonForRowAtIndexPath: if return value is non-nil
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(cellIsReadyAtIndexPath(self.sectionItems, indexPath)) {
        GTTableViewAdapterCellItem *cellItem = cellItemAtIndexPath(self.sectionItems, indexPath);
        return cellItem.cellActions;
    }
    return nil;
}
//
//// Swipe actions
//// These methods supersede -editActionsForRowAtIndexPath: if implemented
//// return nil to get the default swipe actions
//- (nullable UISwipeActionsConfiguration *)tableView:(UITableView *)tableView leadingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos);
//- (nullable UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos);
//
//// Controls whether the background is indented while editing.  If not implemented, the default is YES.  This is unrelated to the indentation level below.  This method only applies to grouped style table views.
//- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath;


//
//// Moving/reordering
//
//// Allows customization of the target row for a particular row as it is being moved/reordered
//- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath;
//
//// Indentation
//
//- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath; // return 'depth' of row for hierarchies
//
//
//// Focus
//
//- (BOOL)tableView:(UITableView *)tableView canFocusRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(9_0);
//- (BOOL)tableView:(UITableView *)tableView shouldUpdateFocusInContext:(UITableViewFocusUpdateContext *)context NS_AVAILABLE_IOS(9_0);
//- (void)tableView:(UITableView *)tableView didUpdateFocusInContext:(UITableViewFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator NS_AVAILABLE_IOS(9_0);
//- (nullable NSIndexPath *)indexPathForPreferredFocusedViewInTableView:(UITableView *)tableView NS_AVAILABLE_IOS(9_0);
//
//// Spring Loading
//
//// Allows opting-out of spring loading for an particular row.
//// If you want the interaction effect on a different subview of the spring loaded cell, modify the context.targetView property. The default is the cell.
//// If this method is not implemented, the default is YES except when the row is part of a drag session.
//- (BOOL)tableView:(UITableView *)tableView shouldSpringLoadRowAtIndexPath:(NSIndexPath *)indexPath withContext:(id<UISpringLoadedInteractionContext>)context API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos, watchos);
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return cellItemsNumberAtSection(self.sectionItems, section);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
     GTTableViewAdapterCellItem *cellItem = cellItemAtIndexPath(self.sectionItems, indexPath);
    NSString *cellClassStr;
    NSString *cellReuseIdentifier;
    //创建cell
    if(!cellIsReadyAtIndexPath(self.sectionItems, indexPath)) {
        //cell未就绪
        cellClassStr = cellItem.replaceCellClass;
        cellReuseIdentifier = cellItem.replaceCellClass;
    } else {
        //cell就绪
        cellClassStr = cellItem.cellClass;
        cellReuseIdentifier = cellItem.reuseIdentifier;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
    if(!cell) {
        Class class = NSClassFromString(cellClassStr);
        cell = [[class alloc] init];
    }
    //cell就绪
    if(cellIsReadyAtIndexPath(self.sectionItems, indexPath)) {
        //设置背景色和高亮颜色
        cell.accessoryType = cellItem.accessoryType;
        if(cellItem.cellBackgroudColor) {
            //设置背景色
            if(!cell.backgroundView) {
                cell.backgroundView = [[UIView alloc] init];
            } else {
                cell.backgroundView.hidden = NO;
            }
            cell.backgroundView.backgroundColor = [self gt_colorWithHexString:cellItem.cellBackgroudColor];
        } else {
            //没有设置背景色
            if(cell.backgroundView) {
                cell.backgroundView.hidden = YES;
            }
        }
        //设置高亮颜色设置了高亮颜色必须将selectionStyle 设置为UITableViewCellSelectionStyleNone 否则无效
        if(cellItem.cellHighlightBackgroudColor) {
           cell.selectionStyle = UITableViewCellSelectionStyleNone;
        } else {
            cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        }
        //设置是否支持menu
        if(cellItem.needShowMenu) {
            UILongPressGestureRecognizer *menuLongPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(showMenuGestureRecognizer:)];
            [cell addGestureRecognizer:menuLongPressGestureRecognizer];
        } else {
            for(UIGestureRecognizer *gestureRecognizer in cell.gestureRecognizers) {
                [gestureRecognizer removeTarget:self action:@selector(showMenuGestureRecognizer:)];
            }
        }
       
    }
    //更新cell 的分割线左边距，和右边距
    if(!cellItem.hideSeparator) {
       cell.separatorInset = UIEdgeInsetsMake(0, cellItem.separatorLeftMargin, 0, cellItem.separatorRightMargin);
    } else {
        cell.separatorInset = UIEdgeInsetsMake(0, tableView.bounds.size.width/2, 0, tableView.bounds.size.width/2);
    }
    //调用cell 绑定数据的方法
    if([cell respondsToSelector:cellItem.cellBindDataSeletor]) {

        [cell performSelector:cellItem.cellBindDataSeletor withObject:cellItem.cellData];
#pragma clang diagnostic pop
    }
    return cell;
}
//
////@optional
//// Default is 1 if not implemented
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(self.tableview!=tableView) {
        self.tableview = tableView;
    }
    return self.sectionItems.count;
}
//// fixed font style. use custom view (UILabel) if you want something different
//- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    
//}
//- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
//    
//}
//
//// Editing
//
//// Individual rows can opt out of having the -editing property set for them. If not implemented, all rows are assumed to be editable.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if(cellIsReadyAtIndexPath(self.sectionItems, indexPath)) {
        GTTableViewAdapterCellItem *cellItem = cellItemAtIndexPath(self.sectionItems, indexPath);
        return cellItem.cellCanEdit;
    }
    return NO;
}
//
//// Moving/reordering
//
//// Allows the reorder accessory view to optionally be shown for a particular row. By default, the reorder control will be shown only if the datasource implements -tableView:moveRowAtIndexPath:toIndexPath:
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(cellIsReadyAtIndexPath(self.sectionItems, indexPath)) {
        GTTableViewAdapterCellItem *cellItem = cellItemAtIndexPath(self.sectionItems, indexPath);
        return cellItem.cellCanMove;
    }
    return NO;
}

//// Index
//// return list of section titles to display in section index view (e.g. "ABCD...Z#")
//- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
//    
//}
//// tell table which section corresponds to section title/index (e.g. "B",1))
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
//    
//}
//
//// Data manipulation - insert and delete support
//
//// After a row has the minus or plus button invoked (based on the UITableViewCellEditingStyle for the cell), the dataSource must commit the change
//// Not called for edit actions using UITableViewRowAction - the action's handler will be invoked instead
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(editingStyle == UITableViewCellEditingStyleDelete) {
        deleteDataSourceAtIndexPath(self.sectionItems, indexPath);
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        if([self.delegate respondsToSelector:@selector(adapter:deleteRowAtIndexPath:deleteRowData:)]) {
            GTTableViewAdapterCellItem *cellItem = cellItemAtIndexPath(self.sectionItems, indexPath);
            [self.delegate adapter:self deleteRowAtIndexPath:indexPath deleteRowData:cellItem.cellData];
        }
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        if([self.delegate respondsToSelector:@selector(adapter:insertRowAtIndexPath:)]) {
            [self.delegate adapter:self insertRowAtIndexPath:indexPath];
        }
    }
}
//
//// Data manipulation - reorder / moving support
//
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    exchangeDataSource(self.sectionItems, sourceIndexPath, destinationIndexPath);
    if([self.delegate respondsToSelector:@selector(adapter:moveRowAtIndexPath:cellDataOfSourceIndexPath:toIndexPath:cellDataOfDestinationIndexPath:)]) {
        GTTableViewAdapterCellItem *sourceCellItem = cellItemAtIndexPath(self.sectionItems, sourceIndexPath);
        GTTableViewAdapterCellItem *destinationCellItem = cellItemAtIndexPath(self.sectionItems, destinationIndexPath);
        [self.delegate adapter:self moveRowAtIndexPath:sourceIndexPath cellDataOfSourceIndexPath:sourceCellItem.cellData toIndexPath:destinationIndexPath cellDataOfDestinationIndexPath:destinationCellItem.cellData];
    }
}
#pragma mark private_methods
static inline CGFloat cellItemsNumberAtSection(NSMutableArray *sectionItems,NSInteger section) {
   GTTableViewAdapterSectionItem *sectionItem= sectionItemAtSection(sectionItems,section);
    return sectionItem.cellItems.count;
}
static inline GTTableViewAdapterCellItem *cellItemAtIndexPath(NSMutableArray *sectionItems,NSIndexPath * indexPath) {
        GTTableViewAdapterSectionItem *sectionItem= sectionItemAtSection(sectionItems,indexPath.section);
        GTTableViewAdapterCellItem *cellItem = [sectionItem cellItemAtRow:indexPath.row];
    return cellItem;
}
static inline GTTableViewAdapterSectionItem *sectionItemAtSection(NSMutableArray *sectionItems,NSInteger section) {
    
    GTTableViewAdapterSectionItem *sectionItem= [sectionItems objectAtIndex:section];
    return sectionItem;
}
static inline BOOL cellIsReadyAtIndexPath(NSMutableArray *sectionItems,NSIndexPath * indexPath) {
    GTTableViewAdapterCellItem *cellItem = cellItemAtIndexPath(sectionItems,indexPath);
    return [[cellItem valueForKey:@"needUpdate"] boolValue];
}
static inline void exchangeDataSource(NSMutableArray *sectionItems,NSIndexPath *sourceIndexPath,NSIndexPath * toIndexPath) {
     GTTableViewAdapterSectionItem *sourceSectionItem= sectionItemAtSection(sectionItems,sourceIndexPath.section);
    GTTableViewAdapterCellItem *sourceCellItem = [sourceSectionItem.cellItems objectAtIndex:sourceIndexPath.row];
   [sourceSectionItem removeCellItemAtRow:sourceIndexPath.row];
    
    GTTableViewAdapterSectionItem *toSectionItem= sectionItemAtSection(sectionItems,toIndexPath.section);
    [toSectionItem insertCellItem:sourceCellItem atRow:toIndexPath.row];
  
    
}
static inline void deleteDataSourceAtIndexPath(NSMutableArray *sectionItems,NSIndexPath *indexPath) {
    GTTableViewAdapterSectionItem *sectionItem= sectionItemAtSection(sectionItems,indexPath.section);
    [sectionItem removeCellItemAtRow:indexPath.row];
}
- (UIColor *)gt_colorWithHexString:(NSString *)color {
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1];
}
- (void)showMenuGestureRecognizer:(UILongPressGestureRecognizer *)gestureRecognizer {
    if(gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        UITableViewCell *cell = (UITableViewCell *)[gestureRecognizer view];
        NSIndexPath *indexPath = [self.tableview indexPathForCell:cell];
        GTTableViewAdapterCellItem *cellItem =  cellItemAtIndexPath(self.sectionItems, indexPath);
        if(cellItem.needShowMenu) {
            UIMenuController *menuController = [UIMenuController sharedMenuController];
            menuController.menuItems = cellItem.menuItems;
            [cell becomeFirstResponder];
            [menuController setTargetRect:CGRectMake(0, cell.frame.size.height * 0.5, cell.frame.size.width, cell.frame.size.height) inView:cell];
            [menuController setMenuVisible:YES animated:YES];
        }
    }
    
  
}

#pragma mark set/get
- (NSMutableArray *)sectionItems {
    if(!_sectionItems) {
        _sectionItems = [[NSMutableArray alloc] init];
    }
    return _sectionItems;
}
@end
