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
- (BOOL)canBecomeFirstResponder
{
    return YES;
}
/**
 *  设置label能够执行那些具体操作
 *
 *  @param action 具体操作
 *
 *  @return YES:支持该操作
 */
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    //    NSLog(@"%@",NSStringFromSelector(action));
    
    if(action == @selector(cut:) || action == @selector(copy:) || action == @selector(zang:)|| action == @selector(myPaste:)) return YES;
    return NO;
}
- (void)zang:(UIMenuController *)item {
    
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
