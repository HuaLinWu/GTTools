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
@property (weak, nonatomic) IBOutlet UIView *testView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)jumpWebViewBtnClick:(UIButton *)sender {
//    UIWebViewController *webVC = [[UIWebViewController alloc] init];
//    [self presentViewController:webVC animated:YES completion:nil];
    sender.layer.borderColor = [UIColor redColor].CGColor;
    sender.layer.cornerRadius = sender.height/2;
    sender.backgroundColor = [UIColor greenColor];
    sender.layer.masksToBounds = YES;
}
- (IBAction)jumpWKWebViewClick:(UIButton *)sender {

    
    [self.testView gt_setCornerRadius:5 borderColor:nil borderWidth:0];
    [self.testView removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
