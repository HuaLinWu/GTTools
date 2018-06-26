//
//  ViewController.m
//  GTToolsUI
//
//  Created by 吴华林 on 2018/6/21.
//  Copyright © 2018年 吴华林. All rights reserved.
//

#import "ViewController.h"
#import "UIWebViewController.h"
#import <GTTools/GTTools.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)jumpWebViewBtnClick:(UIButton *)sender {
    UIWebViewController *webVC = [[UIWebViewController alloc] init];
    [self presentViewController:webVC animated:YES completion:nil];
}
- (IBAction)jumpWKWebViewClick:(UIButton *)sender {
    [sender gt_drawRectWithRoundeCorner:5.0 borderWidth:1 backgroundColor:[UIColor greenColor] borderColor:[UIColor redColor] rectCorner:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft|UIRectCornerBottomRight];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
