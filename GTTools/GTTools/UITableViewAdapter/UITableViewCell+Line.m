//
//  UITableViewCell+FCLineTableViewCell.m
//  Riot
//
//  Created by 吴华林 on 2017/7/11.
//  Copyright © 2017年 finogeeks.com. All rights reserved.
//

#import "UITableViewCell+Line.h"
#import <Masonry/Masonry.h>
@implementation UITableViewCell (Line)

- (instancetype)initWithLineStyle:(FCLineTableViewCellStyle)lineStyle reuseIdentifier:(NSString *)reuseIdentifier {
    
    return [self initWithStyle:UITableViewCellStyleDefault lineStyle:lineStyle reuseIdentifier:reuseIdentifier];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style lineStyle:(FCLineTableViewCellStyle)lineStyle reuseIdentifier:(NSString *)reuseIdentifier {
    
    return [self initWithStyle:style lineStyle:lineStyle topLineColor:[UIColor lightGrayColor] bottomLineColor:[UIColor lightGrayColor] reuseIdentifier:reuseIdentifier layoutBlock:^(UIView *topLineView, UIView *bottomLineView) {
        if(topLineView) {
            __weak typeof(topLineView.superview) contentView = topLineView.superview;
            [topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(contentView).with.offset(0);
                make.leading.equalTo(contentView).with.offset(0);
                make.trailing.equalTo(contentView).with.offset(0);
                make.height.mas_equalTo(@(1/[UIScreen mainScreen].scale));
            }];
        }
        if(bottomLineView) {
            __weak typeof(bottomLineView.superview) contentView = bottomLineView.superview;
            [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(contentView).with.offset(0);
                make.leading.equalTo(contentView).with.offset(0);
                make.trailing.equalTo(contentView).with.offset(0);
                make.height.mas_equalTo(@(1/[UIScreen mainScreen].scale));
            }];
        }
        
    }];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style lineStyle:(FCLineTableViewCellStyle)lineStyle topLineEdgeInsets:(UIEdgeInsets)topLineEdgeInsets bottomLineEdgeInsets:(UIEdgeInsets)bottomLineEdgeInsets reuseIdentifier:(NSString *)reuseIdentifier {
    
    return [self initWithStyle:style lineStyle:lineStyle topLineEdgeInsets:topLineEdgeInsets bottomLineEdgeInsets:bottomLineEdgeInsets topLineColor:[UIColor lightGrayColor] bottomLineColor:[UIColor lightGrayColor] reuseIdentifier:reuseIdentifier];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style lineStyle:(FCLineTableViewCellStyle)lineStyle topLineEdgeInsets:(UIEdgeInsets)topLineEdgeInsets bottomLineEdgeInsets:(UIEdgeInsets)bottomLineEdgeInsets topLineColor:(UIColor *)topLineColor bottomLineColor:(UIColor *)bottomLineColor reuseIdentifier:(NSString *)reuseIdentifier {
    
    return [self initWithStyle:style lineStyle:lineStyle topLineColor:topLineColor bottomLineColor:bottomLineColor reuseIdentifier:reuseIdentifier layoutBlock:^(UIView *topLineView, UIView *bottomLineView) {
        __weak typeof(topLineView.superview) contentView = topLineView.superview;
        if(topLineView) {
            [topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(contentView).with.insets(topLineEdgeInsets);
            }];
            
        }
        if(bottomLineView) {
             __weak typeof(bottomLineView.superview) contentView = bottomLineView.superview;
            [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(contentView).with.insets(bottomLineEdgeInsets);
            }];
        }

    }];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style lineStyle:(FCLineTableViewCellStyle)lineStyle topLineColor:(UIColor *)topLineColor bottomLineColor:(UIColor *)bottomLineColor reuseIdentifier:(NSString *)reuseIdentifier layoutBlock:(void(^)(UIView *topLineView,UIView*bottomLineView))block {
    
    self = [self initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        
        UIView *topLineView = nil;
        UIView *bottomLineView = nil;
        switch (lineStyle) {
            case FCLineTableViewCellStyleTopLine: {
                
                topLineView = [[UIView alloc] init];
                
                break;
            }
            case FCLineTableViewCellStyleBottomLine: {
                
                bottomLineView = [[UIView alloc] init];
                break;
            }
            case FCLineTableViewCellStyleBothLine: {
                
                topLineView = [[UIView alloc] init];
                bottomLineView = [[UIView alloc] init];
                break;
            }
                default: break;
        }
       
        if(topLineView) {
            
            topLineView.backgroundColor = topLineColor?topLineColor:[UIColor lightGrayColor];
            [self addSubview:topLineView];
        }
        if(bottomLineView) {
            
            bottomLineView.backgroundColor = bottomLineColor?bottomLineColor:[UIColor lightGrayColor];
            [self addSubview:bottomLineView];
        }
        block(topLineView,bottomLineView);
        
    }
    return self;
}

@end
