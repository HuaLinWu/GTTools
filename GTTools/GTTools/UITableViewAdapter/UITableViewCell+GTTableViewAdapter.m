//
//  UITableViewCell+GTTableViewAdapter.m
//  Quanshi
//
//  Created by 吴华林 on 2017/11/13.
//  Copyright © 2017年 吴华林. All rights reserved.
//

#import "UITableViewCell+GTTableViewAdapter.h"
#import "UITableViewCell+Line.h"

NSString *const kCellImage= @"kAdapterCellImage";
NSString *const kCellTitle = @"kAdapterCellTitle";
NSString *const kCellDetailTitle = @"kAdapterDetailText";

@implementation UITableViewCell (GTTableViewAdapter)
- (instancetype)initCunstomWithStyle:(UITableViewCellStyle)stysle lineStyle:(FCLineTableViewCellStyle)lineStyle topLineEdgeInsets:(UIEdgeInsets)topLineEdge bottomLineEdgeInsets:(UIEdgeInsets)bottomLineEdge topLineColor:(UIColor *)topLIneColor bottomLineColor:(UIColor *)bottomLineColor reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [self initWithStyle:stysle lineStyle:lineStyle topLineEdgeInsets:topLineEdge bottomLineEdgeInsets:bottomLineEdge topLineColor:topLIneColor bottomLineColor:bottomLineColor reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}
- (void)bindingData:(id)data {
    
    if([data isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dict = (NSDictionary *)data;
        self.textLabel.text = dict[kCellTitle];
        self.detailTextLabel.text = dict[kCellDetailTitle];
        if([dict[kCellImage] isKindOfClass:[UIImage class]]) {
            self.imageView.image = dict[kCellImage];
        }
        
    }
}
@end

