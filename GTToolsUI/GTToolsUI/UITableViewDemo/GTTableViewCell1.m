//
//  GTTableViewCell1.m
//  GTToolsUI
//
//  Created by 吴华林 on 2018/8/28.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import "GTTableViewCell1.h"
@interface GTTableViewCell1()

@end
@implementation GTTableViewCell1


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)bindData:(id)data {
    if([data isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dict = (NSDictionary *)data;
        UIImage *image = [UIImage imageNamed:[dict objectForKey:@"image"]];
        self.imageView.image = image;
        
        NSString *title = dict[@"title"];
        self.textLabel.text = title;
        
        NSString *subTitle = dict[@"subTitle"];
        self.detailTextLabel.text = subTitle;
    }
}
@end
