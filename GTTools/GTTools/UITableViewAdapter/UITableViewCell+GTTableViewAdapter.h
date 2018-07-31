//
//  UITableViewCell+GTTableViewAdapter.h
//  Quanshi
//
//  Created by 吴华林 on 2017/11/13.
//  Copyright © 2017年 吴华林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableViewCellProtocol.h"
extern NSString *const kCellImage;
extern NSString *const kCellTitle;
extern NSString *const kCellDetailTitle;
@interface UITableViewCell (GTTableViewAdapter)<UITableViewCellProtocol>
@end
