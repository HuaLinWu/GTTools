//
//  CollectionViewCell.m
//  GTToolsUI
//
//  Created by 吴华林 on 2018/8/6.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import "CollectionViewCell.h"
#import <GTTools/GTTools.h>
@implementation CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.imageView gt_setImageWithURL:@"http://e.hiphotos.baidu.com/image/pic/item/42a98226cffc1e17461390ed4690f603728de9ba.jpg" placeholderImage:nil];
}

@end
