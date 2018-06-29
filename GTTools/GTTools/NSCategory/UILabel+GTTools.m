//
//  UILabel+GTTools.m
//  GTTools
//
//  Created by 吴华林 on 2018/6/29.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import "UILabel+GTTools.h"
#import <objc/runtime.h>

@implementation UILabel (GTCopy)
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return (action == @selector(copyText:));
}

- (void)attachTapHandler {
    
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *g = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self addGestureRecognizer:g];
}

- (void)handleTap:(UIGestureRecognizer *)g {
    [self becomeFirstResponder];
    if (g.state != UIGestureRecognizerStateBegan)
    {
        return ;
    }
    UIMenuItem *item = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyText:)];
    [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObject:item]];
    [[UIMenuController sharedMenuController] setTargetRect:self.frame inView:self.superview];
    [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
}

//  复制时执行的方法
- (void)copyText:(id)sender {
    //  通用的粘贴板
    UIPasteboard *pBoard = [UIPasteboard generalPasteboard];
    
    if (objc_getAssociatedObject(self, @"expectedText"))
    {
        pBoard.string = objc_getAssociatedObject(self, @"expectedText");
    }
    else
    {
        if (self.text)
        {
            pBoard.string = self.text;
        }
        else
        {
            pBoard.string = self.attributedText.string;
        }
    }
}

- (BOOL)canBecomeFirstResponder {
    return [objc_getAssociatedObject(self, @selector(isCopyable)) boolValue];
}

- (void)setIsCopyable:(BOOL)number {
    objc_setAssociatedObject(self, @selector(isCopyable), [NSNumber numberWithBool:number], OBJC_ASSOCIATION_ASSIGN);
    [self attachTapHandler];
}

- (BOOL)isCopyable {
    return [objc_getAssociatedObject(self, @selector(isCopyable)) boolValue];
}
@end
