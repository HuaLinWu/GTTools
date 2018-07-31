//
//  UITableViewSingleSctionBaseCelIItem.h
//  Quanshi
//
//  Created by 吴华林 on 2017/11/13.
//  Copyright © 2017年 吴华林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UITableView.h>
#import "UITableViewCell+Line.h"
@interface UITableViewSingleSctionBaseCelIItem : NSObject
@property(nonatomic, assign)CGFloat cellHeight;
@property(nonatomic, assign)CGFloat estimatedRowHeight;
@property(nonatomic, copy)void(^cellHeightAsyBlock)(id cellData);
@property(nonatomic, copy) NSString *cellClass;
@property(nonatomic, copy) NSString *cellReuseIdentifier;
@property(nonatomic, assign)UITableViewCellStyle cellStyle;
@property(nonatomic, strong)id cellData;
@property(nonatomic, assign)BOOL canEdit;
@property(nonatomic, assign)BOOL canMove;
@property(nonatomic, assign)UITableViewCellEditingStyle cellEditingStyle;
@property(nonatomic, assign)UITableViewCellAccessoryType cellAccesssoryType;
@property (nonatomic, assign) UITableViewCellSelectionStyle selectionStyle;
@property(nonatomic, strong)NSArray<UITableViewRowAction *> *rowActions;
@property (nonatomic, assign) FCLineTableViewCellStyle lineCellStyle;
@property (nonatomic, assign) UIEdgeInsets topLineEdge;
@property (nonatomic, assign) UIEdgeInsets bottomLineEdge;
@property (nonatomic, strong) UIColor *topLineColor;
@property (nonatomic, strong) UIColor *bottomLineColor;
@end

