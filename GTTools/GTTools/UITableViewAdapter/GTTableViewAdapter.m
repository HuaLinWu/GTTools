//
//  GTTableViewAdapter.m
//  GTTools
//
//  Created by 吴华林 on 2018/8/22.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import "GTTableViewAdapter.h"
#import <UIKit/UITableView.h>
#import <objc/runtime.h>
@interface GTTableViewAdapter()<UITableViewDelegate,UITableViewDataSource>
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
#pragma mark UITableViewDelegate
// Display customization

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0);
//- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0);
//- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath NS_AVAILABLE_IOS(6_0);
//- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0);
//- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0);

// Variable height support

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    GTTableViewAdapterCellItem *cellItem = cellItemAtIndexPath(self.sectionItems, indexPath);
    return cellItem.rowHeight;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;

// Use the estimatedHeight methods to quickly calcuate guessed values which will allow for fast load times of the table.
// If these methods are implemented, the above -tableView:heightForXXX calls will be deferred until views are ready to be displayed, so more expensive logic can be placed there.
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(7_0);
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section NS_AVAILABLE_IOS(7_0);
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section NS_AVAILABLE_IOS(7_0);

// Section header & footer information. Views are preferred over title should you decide to provide both

//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;   // custom view for header. will be adjusted to default or specified header height
//- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;   // custom view for footer. will be adjusted to default or specified footer height

//// Accessories (disclosures).
//
//- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath NS_DEPRECATED_IOS(2_0, 3_0) __TVOS_PROHIBITED;
//- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath;
//
//// Selection
//
//// -tableView:shouldHighlightRowAtIndexPath: is called when a touch comes down on a row.
//// Returning NO to that message halts the selection process and does not cause the currently selected row to lose its selected look while the touch is down.
//- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(6_0);
//- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(6_0);
//- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(6_0);
//
//// Called before the user changes the selection. Return a new indexPath, or nil, to change the proposed selection.
//- (nullable NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath;
//- (nullable NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0);
//// Called after the user changes the selection.
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0);
//
//// Editing
//
//// Allows customization of the editingStyle for a particular cell located at 'indexPath'. If not implemented, all editable cells will have UITableViewCellEditingStyleDelete set for them when the table has editing property set to YES.
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath;
//- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0) __TVOS_PROHIBITED;
//
//// Use -tableView:trailingSwipeActionsConfigurationForRowAtIndexPath: instead of this method, which will be deprecated in a future release.
//// This method supersedes -tableView:titleForDeleteConfirmationButtonForRowAtIndexPath: if return value is non-nil
//- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(8_0) __TVOS_PROHIBITED;
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
//// The willBegin/didEnd methods are called whenever the 'editing' property is automatically changed by the table (allowing insert/delete/move). This is done by a swipe activating a single row
//- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath __TVOS_PROHIBITED;
//- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(nullable NSIndexPath *)indexPath __TVOS_PROHIBITED;
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
//// Copy/Paste.  All three methods must be implemented by the delegate.
//
//- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(5_0);
//- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender NS_AVAILABLE_IOS(5_0);
//- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender NS_AVAILABLE_IOS(5_0);
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
     GTTableViewAdapterCellItem *cellItem = cellItemAtIndexPath(self.sectionItems, indexPath);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellItem.reuseIdentifier];
    if(!cell) {
        Class class = NSClassFromString(cellItem.cellClass);
        cell = [[class alloc] init];
    }
    if([cell respondsToSelector:cellItem.cellBindDataSeletor]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
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
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//}
//
//// Moving/reordering
//
//// Allows the reorder accessory view to optionally be shown for a particular row. By default, the reorder control will be shown only if the datasource implements -tableView:moveRowAtIndexPath:toIndexPath:
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//}
//
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
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//}
//
//// Data manipulation - reorder / moving support
//
//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
//    
//}
#pragma mark private_methods
static inline CGFloat cellItemsNumberAtSection(NSMutableArray *sectionItems,NSInteger section) {
    NSArray *cellItems= [sectionItems objectAtIndex:section];
    return cellItems.count;
}
static inline GTTableViewAdapterCellItem *cellItemAtIndexPath(NSMutableArray *sectionItems,NSIndexPath * indexPath) {
     NSArray *cellItems= [sectionItems objectAtIndex:indexPath.section];
    GTTableViewAdapterCellItem *cellItem = [cellItems objectAtIndex:indexPath.row];
    return cellItem;
}
#pragma mark set/get
- (NSMutableArray *)sectionItems {
    if(!_sectionItems) {
        _sectionItems = [[NSMutableArray alloc] init];
    }
    return _sectionItems;
}
@end
