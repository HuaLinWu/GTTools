//
//  UIViewBindingDataProtocol.h
//  UITableViewDemo
//
//  Created by 吴华林 on 2017/10/30.
//  Copyright © 2017年 吴华林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UITableViewCell+Line.h"
@protocol UITableViewCellProtocol <NSObject>
@required
- (void)bindingData:(id)data;

@optional
- (instancetype)initCunstomWithStyle:(UITableViewCellStyle)stysle lineStyle:(FCLineTableViewCellStyle)lineStyle topLineEdgeInsets:(UIEdgeInsets)topLineEdge bottomLineEdgeInsets:(UIEdgeInsets)bottomLineEdge topLineColor:(UIColor *)topLIneColor bottomLineColor:(UIColor *)bottomLineColor reuseIdentifier:(NSString *)reuseIdentifier;
@end

