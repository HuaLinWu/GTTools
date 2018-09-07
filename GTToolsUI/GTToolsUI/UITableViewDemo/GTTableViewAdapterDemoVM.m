//
//  GTTableViewAdapterDemoVM.m
//  GTToolsUI
//
//  Created by 吴华林 on 2018/8/28.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import "GTTableViewAdapterDemoVM.h"
@interface GTTableViewAdapterDemoVM()
@property(nonatomic,strong)GTTableViewAdapter *adapter;
@end
@implementation GTTableViewAdapterDemoVM
- (void)fetchData {
    GTTableViewAdapterSectionItem *sectionItem0 = [[GTTableViewAdapterSectionItem alloc] init];
    GTTableViewAdapterCellItem *item1 = [[GTTableViewAdapterCellItem alloc] init];
    item1.cellClass = @"GTTableViewCell1";
    item1.rowHeight = 60;
    item1.replaceCellClass = @"GTTableViewReplaceCell";
    item1.replaceRowHeight = 44;
    item1.cellCanEdit = NO;
    item1.cellCanMove = NO;
    item1.cellEditingStyle = UITableViewCellEditingStyleDelete;
    item1.separatorLeftMargin =50;
    item1.separatorRightMargin =50;
    item1.showMenu = YES;
    [sectionItem0 addCellItem:item1];
    
    GTTableViewAdapterCellItem *item2 = [[GTTableViewAdapterCellItem alloc] init];
    item2.cellClass = @"GTTableViewCell1";
    item2.rowHeight = 60;
    item2.replaceCellClass = @"GTTableViewReplaceCell";
    item2.replaceRowHeight = 44;
    item2.cellCanEdit = YES;
    item2.cellCanMove = YES;
    item2.showMenu = YES;
    item2.cellEditingStyle = UITableViewCellEditingStyleInsert;
//    item2.cellBackgroudColor=@"ff4400";
//    item2.cellHighlightBackgroudColor=@"000000";
    [sectionItem0 addCellItem:item2];
    
    GTTableViewAdapterCellItem *item3 = [[GTTableViewAdapterCellItem alloc] init];
    item3.cellClass = @"GTTableViewCell1";
    item3.rowHeight = 60;
    item3.replaceCellClass = @"GTTableViewReplaceCell";
    item3.replaceRowHeight = 44;
    item3.shouldHighlight = NO;
    item3.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [sectionItem0 addCellItem:item3];
    
    GTTableViewAdapterCellItem *item4 = [[GTTableViewAdapterCellItem alloc] init];
    item4.cellClass = @"GTTableViewCell1";
    item4.rowHeight = 60;
    item4.replaceCellClass = @"GTTableViewReplaceCell";
    item4.replaceRowHeight = 44;
    [sectionItem0 addCellItem:item4];
   
    
    GTTableViewAdapterCellItem *item5 = [[GTTableViewAdapterCellItem alloc] init];
    item5.cellClass = @"GTTableViewCell1";
    item5.rowHeight = 60;
    item5.replaceCellClass = @"GTTableViewReplaceCell";
    item5.replaceRowHeight = 44;
    [sectionItem0 addCellItem:item5];
    
    GTTableViewAdapterCellItem *item6 = [[GTTableViewAdapterCellItem alloc] init];
    item6.cellClass = @"GTTableViewCell1";
    item6.rowHeight = 60;
    item6.replaceCellClass = @"GTTableViewReplaceCell";
    item6.replaceRowHeight = 44;
    [sectionItem0 addCellItem:item6];
    
    GTTableViewAdapterCellItem *item7 = [[GTTableViewAdapterCellItem alloc] init];
    item7.cellClass = @"GTTableViewCell1";
    item7.rowHeight = 60;
    item7.replaceCellClass = @"GTTableViewReplaceCell";
    item7.replaceRowHeight = 44;
    [sectionItem0 addCellItem:item7];
     [self.adapter addSectionItem:sectionItem0];
    GTRunInOtherThread(^{
     item1.cellData = @{@"image":@"icon1",@"title":@"美女1",@"subTitle":@"这是卡通动漫头像美女1"};
        [item1 setNeedUpdate];
     item2.cellData = @{@"image":@"icon2",@"title":@"美女2",@"subTitle":@"这是卡通动漫头像美女2"};
        [item2 setNeedUpdate];
    item3.cellData = @{@"image":@"icon3",@"title":@"美女3",@"subTitle":@"这是卡通动漫头像美女3"};
         [item3 setNeedUpdate];
    item4.cellData = @{@"image":@"icon4",@"title":@"美女4",@"subTitle":@"这是卡通动漫头像美女4"};
    [item4 setNeedUpdate];
        
        item5.cellData = @{@"image":@"icon4",@"title":@"美女5",@"subTitle":@"这是卡通动漫头像美女5"};
        [item5 setNeedUpdate];
        item6.cellData = @{@"image":@"icon4",@"title":@"美女6",@"subTitle":@"这是卡通动漫头像美女6"};
        [item6 setNeedUpdate];
        item7.cellData = @{@"image":@"icon4",@"title":@"美女7",@"subTitle":@"这是卡通动漫头像美女7"};
        [item7 setNeedUpdate];
    });
    
     GTTableViewAdapterSectionItem *sectionItem1 = [[GTTableViewAdapterSectionItem alloc] init];
    for(int i=8;i<1000;i++) {
        GTTableViewAdapterCellItem *item = [[GTTableViewAdapterCellItem alloc] init];
        item.cellClass = @"GTTableViewCell2";
        item.rowHeight = 60;
        item.replaceCellClass = @"GTTableViewReplaceCell";
        item.replaceRowHeight = 44;
        item.hideSeparator = YES;
        [item setNeedUpdate];
        [sectionItem1 addCellItem:item];
    }
    
    [self.adapter addSectionItem:sectionItem1];
}
#pragma mark set/get
- (GTTableViewAdapter *)adapter {
    if(!_adapter) {
        _adapter = [[GTTableViewAdapter alloc] init];
    }
    return _adapter;
}
@end
