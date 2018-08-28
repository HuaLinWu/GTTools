//
//  TableViewCell2.m
//  GTToolsUI
// 高度随着cell 里面按钮点击事件进行变化
//  Created by 吴华林 on 2018/8/28.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import "GTTableViewCell2.h"
@interface GTTableViewCell2()
@property(nonatomic,strong)UIButton *magnifyBtn;
@property(nonatomic,strong)UIButton *shrinkBtn;
@end
@implementation GTTableViewCell2

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
   self= [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        _magnifyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _magnifyBtn.frame = CGRectMake(20, 5, 40, 40);
        [_magnifyBtn setTitle:@"放大" forState:UIControlStateNormal];
        [_magnifyBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_magnifyBtn addTarget:self action:@selector(magnifyAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_magnifyBtn];
        
        _shrinkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _shrinkBtn.frame = CGRectMake(80, 5, 40, 40);
        [_shrinkBtn setTitle:@"缩小" forState:UIControlStateNormal];
         [_shrinkBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_shrinkBtn addTarget:self action:@selector(shrinkAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_shrinkBtn];
    }
    return self;
}
- (void)magnifyAction {
    NSLog(@"放大按钮被点击");
}
- (void)shrinkAction {
     NSLog(@"缩小按钮被点击");
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
